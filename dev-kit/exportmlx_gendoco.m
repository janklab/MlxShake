function exportmlx_gendoco
% For internal use by ExportMlx developers at authoring time.
%
% This generates the docs/*.md files from the docs/*.mlx input files.

%#ok<*NBRAK>

rootDir = janklab.exportmlx.globals.distroot;
docDir = string(fullfile(rootDir, 'docs'));

% Export the main doco

docFiles = [
    "UserGuide"
    ];
for fileStem = docFiles(:)'
    mlxFile = fullfile(docDir, fileStem + ".mlx");
    fprintf('Exporting ExportMlx doc file: %s\n', fileStem + ".mlx");
    janklab.exportmlx.mlx2latex(mlxFile);
    noExtnFile = fullfile(docDir, fileStem);
    janklab.exportmlx.lslatex2markdown(noExtnFile);
end

% And all the examples

examplesDir = fullfile(rootDir, 'examples');
d = dir(examplesDir + "/*.mlx");
exampleMlxs = string({d.name});
for mlxFileBase = exampleMlxs
    [~, fileStem, ~] = fileparts(mlxFileBase);
    mlxFile = fullfile(examplesDir, mlxFileBase);
    fprintf('Exporting ExportMlx example file: %s\n', mlxFileBase);
    janklab.exportmlx.mlx2latex(mlxFile);
    noExtnFile = fullfile(examplesDir, fileStem);
    janklab.exportmlx.lslatex2markdown(noExtnFile);    
end

fprintf('Exported ExportMlx doco.\n')
