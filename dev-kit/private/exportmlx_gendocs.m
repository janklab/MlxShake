function exportmlx_gendocs
% For internal use by ExportMlx developers at authoring time.
%
% Generates all the "intermediate" Markdown doc files that are dynamically
% generated.
%
% This generates the docs/*.md files from the docs/*.mlx input files. Also
% regenerates README.md and docs/index.md from doc-src. Any other dynamic
% generation of the Markdown-stage files (stuff that gets checked in to the
% repo, but is not part of the final static (local) stuff in doc/) should
% be built by this function.

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
    janklab.exportmlx.exportlivescript(mlxFile);
end

% And all the examples

examplesDir = fullfile(rootDir, 'examples');
d = dir(examplesDir + "/*.mlx");
exampleMlxs = string({d.name});
for mlxFileBase = exampleMlxs
    mlxFile = fullfile(examplesDir, mlxFileBase);
    fprintf('Exporting: ExportMlx example file: %s\n', mlxFileBase);
    janklab.exportmlx.exportlivescript(mlxFile);
end

% Our web pages

docSrc = fullfile(rootDir, 'doc-src');
catfiles([fullfile(docSrc, 'index-head.md'), fullfile(docSrc, 'README-index-common.md')], ...
    'docs/index.md');
catfiles([fullfile(docSrc, 'README-head.md'), fullfile(docSrc, 'README-index-common.md')], ...
    'README.md');

% Done

fprintf('Generated all ExportMlx docs.\n')

end

function catfiles(infiles, outfile)
% Concatenate file contents and write to another file.
arguments
    infiles string
    outfile (1,1) string
end

contents = repmat(string(missing), size(infiles));
for i = 1:numel(infiles)
    contents(i) = janklab.exportmlx.internal.util.readtext(infiles(i));
end
combined = strjoin(contents, "");
janklab.exportmlx.internal.util.writetext(combined, outfile);

end