function mdFile = exportlivescript(inFile, opts)
% Export a Matlab Live Script (.mlx) file to Markdown or other formats.
%
% mdFile = janklab.exportmlx.exportlivescript(mlxFile, opts)
%
% Exports a Matlab Live Script .mlx file to Markdown or other presentation file
% formats. Defaults to Markdown format.
%
% Depending on the output format, this may produce multiple output files.
%
% InFile (string) is the path to the input Live Script .mlx file you want to
% export. You may omit the '.mlx' extension.
%
% Opts controls various aspects of exportlivescript's behavior. It is a
% janklab.exportmlx.MlxExportOptions or a cell vector of name/value pairs (which gets
% turned in to an MlxExportOptions). See MlxExportOptions' documentation for the
% available options and their effects.
%
% Useful options:
%
%   format   - The output file format. May be "auto", "markdown", "html", "pdf",
%              "latex", "msword", or maybe more.
%   outFile  - Path to the output file to produce. Defaults to a file of the
%              appropriate extension for the output format in the input
%              directory next to the original input file.
%
% Returns the path to the main exported file. There may be other auxiliary files
% produced; they will be in the folder next to the main output file. What
% exactly they are and what they are named varies based on the output format.
%
% Examples:
%
%     import janklab.exportmlx.exportlivescript
%
%     exportlivescript('foo.mlx');
%
%     % Write to an alternate location
%     exportlivescript('foo.mlx', {'outFile','/path/to/bar.md'});
%
%     % Export a different format, like PDF
%     exportlivescript('foo.mlx', {'format', 'pdf'});
%
%     % Output format is automatically selected based on file extension
%     exportlivescript('foo.mlx', {'outFile', 'blah.docx'});
%
%     % You can also work with the export options as an object
%     opts = janklab.exportmlx.MlxExportOptions;
%     opts.outFile = '/path/to/bar.md';
%     opts.keepIntermediateFiles = true;
%     exportlivescript('foo.mlx', opts);
%
% See also:
% MLXEXPORTOPTIONS
% MLX2LATEX
% LSLATEX2MARKDOWN

arguments
    inFile (1,1) string
    opts (1,1) janklab.exportmlx.MlxExportOptions = janklab.exportmlx.MlxExportOptions
end

% Handle input and figure out paths and options

blah = regexprep(inFile, '\.mlx$', '', 'ignorecase');
if blah == inFile
    mlxFile = blah + '.mlx';
else
    mlxFile = inFile;
end
[inDir,inFileStem,~] = fileparts(mlxFile);
if inDir == ""
    inDir = pwd;
end

% { format, extn, isDirectExport; ... }
formatDefns = {
    "markdown"  ".md"       false
    "html"      ".html"     true
    "pdf"       ".pdf"      true
    "latex"     ".tex"      true
    "msword"    ".docx"     true
    };
formatDefns = cell2table(formatDefns, 'VariableNames',{'format', 'extn', 'isdirect'});

if opts.format == "auto"
    if ismissing(opts.outFile)
        format = "markdown";
    else
        [~,~,outFileExtn] = fileparts(opts.outFile);
        if outFileExtn == ""
            format = "markdown";
        else
            [tf,loc] = ismember(outFileExtn, formatDefns.extn);
            if ~tf
                error("Unrecognized output file extension: '%s'. Cannot determine output format.", ...
                    outFileExtn);
            end
            format = formatDefns.format(loc);
        end
    end
else
    format = opts.format;
end
[~,loc] = ismember(format, formatDefns.format);
wantFileExtn = formatDefns.extn(loc);
formatIsDirectExport = formatDefns.isdirect(loc);

if ismissing(opts.outFile)
    outDir = inDir;
    outFileStem = inFileStem;
    outFileExtn = wantFileExtn;
else
    [outDir,outFileStem,outFileExtn] = fileparts(opts.outFile);
    if isempty(outDir)
        outDir = pwd;
    end
end
outFile = fullfile(outDir, outFileStem + outFileExtn);
if outFileExtn ~= wantFileExtn
    warning('jl:exportmlx:FileExtnMismatch', ...
        "File extension '%s' for output file does not match standard extension " ...
        + "for format '%s'. Output may be broken or in wrong format. " ...
        + "Output file: '%s'", ...
        outFileExtn, format, outFile);
end

if formatIsDirectExport
    janklab.exportmlx.internal.mlx2x(inFile, outFile);
else
    tempDir = [];
    if islogical(opts.tempDir)
        if opts.tempDir
            % Auto-select
            tempDir = tempname;
            mkdir(tempDir);
            workingDir = tempDir;
        else
            % Use output dir
            workingDir = outDir;
        end
    else
        workingDir = opts.tempDir;
    end
    
    % Export to intermediate latex
    
    texFile = fullfile(workingDir, inFileStem+'.tex');
    latexRslt = janklab.exportmlx.mlx2latex(mlxFile, texFile);
    
    % Convert to final output format
    
    switch format
        case "markdown"
            % I don't like this modify-the-options pattern. Find a better way.
            opts2 = opts;
            opts2.outFile = outFile;
            mdFile = janklab.exportmlx.lslatex2markdown(texFile, opts2);
        otherwise
            error("Output format '%s' is unimplemented. Sorry.", format);
    end
    
    % Clean up
    if ~opts.keepIntermediateFiles
        if workingDir == outDir
            % HACK to handle case where workingDir = outDir and there is
            % an _images directory generated that needs to be preserved.
            rmrf(texFile);
            rmrf(fullfile(workingDir, 'matlab.sty'));
        else
            rmrf(latexRslt.files);
        end
        if ~isempty(tempDir)
            rmrf(tempDir);
        end
    else
        % Just leave everything sitting there
    end
    
end


end
