function livescript2latex(mlxFile)
% Export a live script (.mlx) file to LaTeX (.tex)

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