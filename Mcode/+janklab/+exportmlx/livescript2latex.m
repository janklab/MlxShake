function livescript2latex(mlxFile)
% Export a live script (.mlx) file to LaTeX (.tex).
%
% janklab.exportmlx.livescript2latex(mlxFile)
%
% MlxFile (string) is the path to the .mlx Live Script file to export.
%
% Exports to a .tex file next to the original input file, with the '.mlx'
% file extension replaced by '.tex'.

arguments
    mlxFile (1,1) string
end

[pDir, fileStem, mlxExt] = fileparts(mlxFile); %#ok<ASGLU>
fileStemPath = fullfile(pDir, fileStem);
fprintf('Exporting: %s to %s.*\n', mlxFile, fileStemPath);

% Export to LaTeX
% TODO: Support export to alternate directories

texFile = pDir + '/' + fileStem + '.tex';
matlab.internal.liveeditor.openAndConvert(char(mlxFile), char(texFile));
fprintf('Exported: %s -> %s\n', mlxFile, texFile);
  
end