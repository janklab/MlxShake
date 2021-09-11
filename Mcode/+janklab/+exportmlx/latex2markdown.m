function mdFile = latex2markdown(inFile, options)
% Convert Live Script LaTeX to Markdown.
%
% mdfile = janklab.exportmlx.latex2markdown(inFile, options)
%
% Converts a LaTeX-format exported Live Script file to Markdown. Will also
% produce accompanying image files in a subdirectory next to the output .md
% file.
%
% This does not work on LaTeX in general! Only the specific LaTeX files
% that are produced by Matlab's "Export to LaTeX" function for Matlab Live
% Scripts.
%
% InFile (string) is the path to the LaTeX .tex file to convert.
% The '.tex' suffix is optional.
%
% Options is a janklab.exportmlx.ExportOptions or a cell vector of
% name/value pairs. Available options are:
%
%   outFile - Specifies a custom file name. Defaults to the input file
%   name with '.tex' replaced by '.md'.
%
%   markdownStyle - Specifies the style of Markdown to use. 'github'* or 'qiita'.
%
%   png2jpeg (logical) - If true, converts PNG images to JPEGs. This saves space at the
%   expense of reduced image quality.
%
%   tableMaxWidth (double, 20*) - Maximum table width. (TODO: What units is
%   this in: columns, inches, ???)
%
% Returns the path to the generated .md file.
%
% See also:
% EXPORTOPTIONS

arguments
    inFile (1,1) string
    options (1,1) janklab.exportmlx.ExportOptions = janklab.exportmlx.ExportOptions
end

% Latex filename
[parentDir,name,extn] = fileparts(inFile);

if parentDir == ""
    parentDir = pwd;
end

if extn == ""
    noExtnFile = inFile;
    latexFile = fullfile(parentDir, name + ".tex");
else
    noExtnFile = fullfile(parentDir, name);
    latexFile = inFile;
end

% check if latexfile exists
assert(exist(latexFile, 'file') > 0, ...
    latexFile + " does not exist. " ...
    + "If you haven't generate latex file from a live script please do so.");

% Import latex file and have it as a string variable
% If the mlx contains double byte charactors, it needs to use fgets.
% Otherwise the following does the work.
% str = string(fileread(latexfile));
fid = fopen(latexFile, 'r', 'n', 'UTF-8');
str = string;
tmp = fgets(fid);
while tmp > 0
    str = append(str, string(tmp));
    tmp = fgets(fid);
end
fclose(fid);

% Extract body from latex
str = extractBetween(str, "\begin{document}", "\end{document}");

% Delete table of contents
% ex: \label{H_D152BAC0}
str = regexprep(str, "\\matlabtableofcontents{([^{}]+)}", "");
str = regexprep(str, "\\label{[a-zA-Z_0-9]+}", "");

% Divide the body into each environment

% Preprocess 1:
% Add 'newline' to the end of the following.
% \end{lstlisting}, \end{verbatim}, \end{matlabcode}, \end{matlaboutput},\end{center}
% \end{matlabtableoutput}, \end{matlabsymbolicoutput}  \vspace{1em}
str = replace(str, "\end{lstlisting}"+newline, "\end{lstlisting}"+newline+newline);
str = replace(str, "\end{verbatim}"+newline, "\end{verbatim}"+newline+newline);
str = replace(str, "\end{matlabcode}"+newline, "\end{matlabcode}"+newline+newline);
str = replace(str, "\end{matlaboutput}"+newline, "\end{matlaboutput}"+newline+newline);
str = replace(str, "\end{matlabtableoutput}"+newline, "\end{matlabtableoutput}"+newline+newline);
str = replace(str, "\end{matlabsymbolicoutput}"+newline, "\end{matlabsymbolicoutput}"+newline+newline);
str = replace(str, "\end{center}"+newline, "\end{center}"+newline+newline);
str = replace(str, "\vspace{1em}"+newline, "\vspace{1em}"+newline+newline);

% Preprocess 2:
% Replace more than three \n to \n\n.
str = regexprep(str, '\n{3,}', '\n\n');
% Devide them into parts by '\n\n'
str = strsplit(str, '\n\n')';

% Preprocess 3:
% The following environments will be merge into one string
% for the ease of process.
% \begin{verbatim}
% \begin{lstlisting}
% \begin{matlabcode}
% \begin{matlaboutput}
% \begin{matlabtableoutput}
% \begin{matlabsymbolicoutput}
str = mergeSameEnvironments(str, "lstlisting");
str = mergeSameEnvironments(str, "verbatim");
str = mergeSameEnvironments(str, "matlabcode");
str = mergeSameEnvironments(str, "matlaboutput");
str = mergeSameEnvironments(str, "matlabtableoutput");
str = mergeSameEnvironments(str, "matlabsymbolicoutput");

% Let's convert latex to markdown
% 1: Process parts that require literal output.
[str, idxLiteral] = processLiteralOutput(str);

% 2: Process that other parts
str2md = str(~idxLiteral);
str2md = processDocumentOutput(str2md, options.tableMaxWidth);

% Equations
str2md = processEquations(str2md, options.markdownStyle);

% includegraphics
str2md = processincludegraphics(str2md, options.markdownStyle, ...
    options.png2jpeg, name, parentDir);

% Apply vertical/horizontal space
% markdown: two spaces for linebreak
% latex: \vspace{1em}
% latex: \hskip1em
str2md = regexprep(str2md, "\\vspace{1em}", "  ");
str2md = regexprep(str2md, "\\hskip1em", "  ");
str(~idxLiteral) = str2md;

% Done! Merge them together
strmarkdown = join(str, newline);

% File output
if ismissing(options.outFile)
    mdFile = noExtnFile + ".md";
else
    mdFile = options.outFile;
end
imagesDirPath = noExtnFile + "_images";
fileID = fopen(mdFile, 'w');
fprintf(fileID, '%s\n', strmarkdown);
fclose(fileID);

disp("Converting LaTeX to Markdown is complete.");
disp("  Markdown: " + mdFile);
disp("  Images dir: " + imagesDirPath);
