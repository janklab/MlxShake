function outMdFile = lslatex2markdown(inFile, opts)
% Convert Live Script LaTeX to Markdown.
%
% mdfile = janklab.exportmlx.lslatex2markdown(inFile, opts)
%
% Converts a LaTeX-format exported Live Script file to Markdown. Will also
% produce accompanying image files in a subdirectory next to the output .md
% file.
%
% This does not work on LaTeX in general! Only the specific LaTeX files
% that are produced by Matlab's "Export to LaTeX" function for Matlab Live
% Scripts.
%
% The "lslatex" name indicates that this only works on Live Script-produced
% LaTeX, not LaTeX in general.
%
% InFile (string) is the path to the LaTeX .tex file to convert.
% The '.tex' suffix is optional.
%
% Opts is a janklab.exportmlx.MlxExportOptions object. See its documentation for
% available options and their behavior.
%
% Returns the path to the generated .md file.
%
% See also:
% MLXEXPORTOPTIONS

arguments
    inFile (1,1) string
    opts (1,1) janklab.exportmlx.MlxExportOptions = janklab.exportmlx.MlxExportOptions
end

exporter = janklab.exportmlx.internal.LsLatex2MardkownExporter;
outMdFile = exporter.lslatex2markdown(inFile, opts);

end