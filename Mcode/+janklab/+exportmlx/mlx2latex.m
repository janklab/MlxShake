function out = mlx2latex(inMlxFile, outFile)
% Export a Live Script (.mlx) file to LaTeX (.tex).
%
% janklab.exportmlx.mlx2latex(mlxFile)
% janklab.exportmlx.mlx2latex(mlxFile, outFile)
%
% Exports a Matlab Live Script to LaTeX. This produces a .tex file and an
% accompanying <foo>_images directory next to it.
%
% InMlxFile (string) is the path to the input .mlx Live Script file to export.
% Files on the Matlab path will not be located; you must provide the full path
% to the input file.
%
% OutFile (string, optional) is the path to the output .tex file to export. The
% '.tex' extension may be omitted and defaults to '.tex'. You can also use a
% different file extension, and that will be respected, but that might mess things
% up.
%
% Exports to a .tex file next to the original input file, with the '.mlx'
% file extension replaced by '.tex'.
%
% The undocumented return value is for ExportMlx's internal use.

arguments
    inMlxFile (1,1) string
    outFile (1,1) string = missing
end

persistent initializerHack
if isempty(initializerHack)
    initializerHack = janklab.exportmlx.internal.ExportmlxBase;
end

[parentDir, fileStem, mlxExt] = fileparts(inMlxFile); %#ok<ASGLU>

if ismissing(outFile)
    outDir = parentDir;
    outStem = fileStem;
    outFileExtn = ".tex";
else
    [outDir,outStem,outFileExtn] = fileparts(outFile);
    if isempty(outDir)
        outDir = ".";
    end
    if isempty(outFileExten)
        outFileExtn = ".tex";
    end
end
outStemPath = fullfile(outDir, outStem);

loginfo('Exporting: %s to %s.*', inMlxFile, outStemPath);
outFileBase = outStem + outFileExtn;
outTexFile = fullfile(outDir, outFileBase);

matlab.internal.liveeditor.openAndConvert(char(inMlxFile), char(outTexFile));
loginfo('Exported: %s -> %s', inMlxFile, outTexFile);

out.dir = outDir;
out.stemPath = outStemPath;
out.files = [outTexFile, fullfile(outDir, "matlab.sty")];

if nargout == 0
    clear out
end

end