function exportmlx_gendoco
% For internal use by ExportMlx developers at authoring time.
%
% This generates the doc/*.md files from the doc/*.mlx input files.

repoDir = string(fileparts(fileparts(mfilename('fullpath'))));
docDir = string(fullfile(repoDir, 'doc'));

docFiles = [
    "UserGuide"
    ];
for fileStem = docFiles(:)'
    mlxFile = fullfile(docDir, fileStem + ".mlx");
    fprintf('Exporting: %s\n', mlxFile);
    janklab.exportmlx.livescript2latex(mlxFile);
    % texFile = fullfile(docDir, fileStem + ".tex");
    % mdFile = fullfile(docDir, fileStem + ".md");
    noExtnFile = fullfile(docDir, fileStem);
    mdFile = janklab.exportmlx.latex2markdown(noExtnFile);
    
    % Clean up image links
    % (This is a bug in the export that should be fixed.)
    bogus = 'UserGuide_images//Users/janke/local/repos/ExportMlx/doc/';
    cmd = "perl -pi -e 's|" + bogus +"||g' " + mdFile;
    system(cmd);
end

fprintf('Exported doco.\n')
