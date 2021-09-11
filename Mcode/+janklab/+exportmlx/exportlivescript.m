function mdFile = exportlivescript(mlxFile, options)
% Export a Live Script (.mlx) file to Markdown (.md plus images)
%
% mdfile = janklab.exportmlx.exportlivescript(mlxFile)
%
% Exports a Matlab Live Script .mlx file to Markdown by exporting it to
% LaTeX (.tex) and then converting that to Markdown. Retains the
% intermediate .tex and .sty files. (So make sure those aren't files you've
% created yourself and want to keep!)
%
% MlxFile (string) is the path to the Live Script .mlx file you want to
% export. You may omit the '.mlx' extension.
%
% Options is a janklab.exportmlx.ExportOptions or a cell vector of
% name/value pairs. See its documentation for available options.
%
% Returns the path to the exported Markdown .md file.
%
% See also:
% LIVESCRIPT2LATEX
% LATEX2MARKDOWN

arguments
    mlxFile (1,1) string
    options (1,1) janklab.exportmlx.ExportOptions = janklab.exportmlx.ExportOptions
end

noExtnFile = regexprep(mlxFile, '\.mlx$', '', 'ignorecase');
if noExtnFile == mlxFile
    mlxFile = noExtnFile + '.mlx';
end

latexRslt = janklab.exportmlx.mlx2latex(mlxFile);
mdFile = janklab.exportmlx.lslatex2markdown(noExtnFile, options);

if ~options.keepIntermediateFiles
    for i = 1:numel(latexRslt.files)
        delete(latexRslt.files(i));
    end
end

end
