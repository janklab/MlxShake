function exportmlx_gendoco

repoDir = string(fileparts(fileparts(mfilename('fullpath'))));
docDir = string(fullfile(repoDir, 'doc'));

docFiles = [
    "UserGuide"
    ];
for fileStem = docFiles(:)'
    mlxFile = fullfile(docDir, fileStem + ".mlx");
    fprintf('Exporting: %s\n', mlxFile);
    livescript2latex(mlxFile);
    texFile = fullfile(docDir, fileStem + ".mlx");
    latex2markdown(texFile);
end

fprintf('Exported doco.')
