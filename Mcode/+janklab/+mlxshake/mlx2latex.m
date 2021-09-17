function out = mlx2latex(inMlxFile, outFile)
% Export a Live Script (.mlx) file to LaTeX (.tex).
%
%     janklab.mlxshake.mlx2latex(mlxFile, outFile)
%
% Exports a Matlab Live Script to LaTeX. This produces a .tex file and an
% accompanying matlab.sty file and <foo>_images directory next to it. Will
% clobber any existing files.
%
% InMlxFile (string) is the path to the input .mlx Live Script file to export.
% Files on the Matlab path will not be located; you must provide the full path
% to the input file.
%
% OutFile (string) is the path to the output .tex file to export. The
% '.tex' extension may be omitted and defaults to '.tex'. You can also use a
% different file extension, and that will be respected, but that might mess things
% up. By default, the output file is the input file with the '.mlx' extension
% replaced by '.tex'.
%
% The undocumented return value is for MlxShake's internal use.

arguments
    inMlxFile (1,1) string
    outFile (1,1) string = missing
end

persistent initializerHack
if isempty(initializerHack)
    initializerHack = janklab.mlxshake.internal.MlxshakeBase;
end

[inDir, inFileStem, mlxExt] = fileparts(inMlxFile); %#ok<ASGLU>

if ismissing(outFile)
    outDir = inDir;
    outFileStem = inFileStem;
    outFileExtn = ".tex";
else
    [outDir,outFileStem,outFileExtn] = fileparts(outFile);
    if outDir == ""
        outDir = pwd;
    end
    if outFileExtn == ""
        outFileExtn = ".tex";
    end
end
outFileBase = outFileStem + outFileExtn;
outStemPath = fullfile(outDir, outFileStem);
outTexFile = fullfile(outDir, outFileBase);
outImagesDir = fullfile(outDir, outFileStem+"_images");

logdebug('Exporting: %s -> %s', inMlxFile, outTexFile);
matlab.internal.liveeditor.openAndConvert(char(inMlxFile), char(outTexFile));
logdebug('Exported:  %s -> %s', inMlxFile, outTexFile);

out.dir = outDir;
out.stemPath = outStemPath;
out.texFile = outTexFile;
out.files = [outTexFile, outImagesDir, fullfile(outDir, "matlab.sty")];

if nargout == 0
    clear out
end

end