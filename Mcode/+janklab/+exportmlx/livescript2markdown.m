function mdFile = livescript2markdown(mlxFile)
% Export a Live Script (.mlx) file to Markdown (.md plus images)
%
% mdfile = livescript2markdown(mlxFile)
%
% Exports a Matlab Live Script .mlx file to Markdown by exporting it to
% LaTeX (.tex) and then converting that to Markdown. Retains the
% intermediate .tex and .sty files. (So make sure those aren't files you've
% created yourself and want to keep!)
%
% MlxFile (string) is the path to the Live Script .mlx file you want to
% export. You may omit the '.mlx' extension.
%
% Returns the path to the exported Markdown .md file.
%
% See also:
% LIVESCRIPT2LATEX
% LATEX2MARKDOWN

arguments
    mlxFile (1,1) string
end

noExtnFile = regexprep(mlxFile, '\.mlx$', '', 'ignorecase');
if noExtnFile == mlxFile
    mlxFile = noExtnFile + '.mlx';
end

livescript2latex(mlxFile);
mdFile = latex2markdown(noExtnFile);

end
