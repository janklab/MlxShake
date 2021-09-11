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
    fprintf('Exporting: ExportMlx doc file: %s\n', fileStem + ".mlx");
    janklab.exportmlx.livescript2markdown(mlxFile);
end

% And all the examples

examplesDir = fullfile(rootDir, 'examples');
d = dir(examplesDir + "/*.mlx");
exampleMlxs = string({d.name});
for mlxFileBase = exampleMlxs
    mlxFile = fullfile(examplesDir, mlxFileBase);
    fprintf('Exporting: ExportMlx example file: %s\n', mlxFileBase);
    janklab.exportmlx.livescript2markdown(mlxFile);
end

fprintf('Exported all ExportMlx doco.\n')
