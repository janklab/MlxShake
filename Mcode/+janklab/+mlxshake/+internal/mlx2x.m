function mlx2x(inMlxFile, outFile, format)
% Export MLX to various formats using Matlab's undocumented internals
%
%     janklab.mlxshake.internal.mlx2x(inMlxFile, outFile, format)
%
% Format is optional. If omitted, format is inferred *by Matlab* from the
% outFile file extension.

arguments
    inMlxFile (1,1) string
    outFile (1,1) string
    format (1,1) string = "auto"
end

% Parse inputs

if format ~= "auto"
    error("mlx2x currently only supports the 'auto' format.");
end

[inDir,inFileStem,inFileExtn] = fileparts(inMlxFile);
if inDir == ""
    inDir = pwd;
end
realInFile = fullfile(inDir, inFileStem + inFileExtn);
[outDir,outFileStem,outFileExtn] = fileparts(outFile);
if outDir == ""
    outDir = pwd;
end
realOutFile = fullfile(outDir, outFileStem + outFileExtn);

% Do export

matlab.internal.liveeditor.openAndConvert(char(realInFile), char(realOutFile));

end