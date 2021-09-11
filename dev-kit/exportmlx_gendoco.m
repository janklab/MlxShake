function exportmlx_gendoco
% For internal use by ExportMlx developers at authoring time.
%
% This generates the docs/*.md files from the docs/*.mlx input files.

%#ok<*NBRAK>

repoDir = janklab.exportmlx.globals.distroot;
docDir = string(fullfile(repoDir, 'docs'));

docFiles = [
    "UserGuide"
    ];
for fileStem = docFiles(:)'
    mlxFile = fullfile(docDir, fileStem + ".mlx");
    fprintf('Exporting ExportMlx doc file: %s\n', fileStem + ".mlx");
    janklab.exportmlx.mlx2latex(mlxFile);
    noExtnFile = fullfile(docDir, fileStem);
    janklab.exportmlx.latex2markdown(noExtnFile);
end

fprintf('Exported doco.\n')
