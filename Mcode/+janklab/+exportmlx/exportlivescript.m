function mdFile = exportlivescript(inFile, opts)
% Export a Live Script (.mlx) file to Markdown.
%
% mdFile = janklab.exportmlx.exportlivescript(mlxFile, opts)
%
% Exports a Matlab Live Script .mlx file to Markdown by exporting it to
% LaTeX (.tex) and then converting that to Markdown.
%
% InFile (string) is the path to the input Live Script .mlx file you want to
% export. You may omit the '.mlx' extension.
%
% Opts controls various aspects of exportlivescript's behavior. It is a
% janklab.exportmlx.MlxExportOptions or a cell vector of name/value pairs (which gets
% turned in to an MlxExportOptions). See MlxExportOptions' documentation for the 
% available options and their effects.
%
% Returns the path to the main exported Markdown .md file. There may be other
% auxiliary files produced; they will be in the folder next to the .md file.
%
% Examples:
%
%     import janklab.exportmlx.exportlivescript
%
%     exportlivescript('foo.mlx');
%     exportlivescript('foo.mlx', {'outFile','/path/to/bar.md'});
%
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

if ismissing(opts.outFile)
    outDir = inDir;
    outFileStem = inFileStem;
    outFileExtn = '.md';
else
    [outDir,outFileStem,outFileExtn] = fileparts(opts.outFile);
    if isempty(outDir)
        outDir = pwd;
    end
end
outFile = fullfile(outDir, outFileStem + outFileExtn);

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

% I don't like this modify-the-options pattern. Find a better way.
opts2 = opts;
opts2.outFile = outFile;
mdFile = janklab.exportmlx.lslatex2markdown(texFile, opts2);

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
