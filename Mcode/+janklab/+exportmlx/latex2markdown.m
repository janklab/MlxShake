function outMdFile = latex2markdown(inFile, options)
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

persistent initializerHack
if isempty(initializerHack)
    initializerHack = janklab.exportmlx.internal.ExportmlxBase;
end

LF = newline;

%% Argument handling and validation

[inParentDir,inFileStem,extn] = fileparts(inFile);
if inParentDir == ""
    inParentDir = pwd;
end

if extn == ""
    noExtnFile = inFile;
    latexFile = fullfile(inParentDir, inFileStem + ".tex");
else
    noExtnFile = fullfile(inParentDir, inFileStem);
    latexFile = inFile;
end

if ~isfile(latexFile)
    error("Input LaTeX file '" + latexFile + " does not exist. " ...
    + "If you haven't generate latex file from a live script please do so, " ...
    + "using mlx2latex.");
end

%% Preprocess latex

% Read latex
str = janklab.exportmlx.internal.util.readtext(latexFile);

% Extract main body from latex
str = extractBetween(str, "\begin{document}", "\end{document}");

% Delete table of contents
str = regexprep(str, "\\matlabtableofcontents{([^{}]+)}", "");
% e.g. \label{H_D152BAC0}
str = regexprep(str, "\\label{[a-zA-Z_0-9]+}", "");

% Divide the body into each environment

% Pre 1: Double newlines for selected items
% TODO: Document why.
placesToDoubleNewlines = [
    "\end{lstlisting}"
    "\end{verbatim}"
    "\end{matlabcode}"
    "\end{matlaboutput}"
    "\end{matlabtableoutput}"
    "\end{matlabsymbolicoutput}"
    "\end{center}"
    "\vspace{1em}"
    ];
for thing = placesToDoubleNewlines'
    str = replace(str, thing+LF, thing+LF+LF);
end

% Pre 2: Shrink more than two \n to just two.
str = regexprep(str, '\n{3,}', '\n\n');
% Divide file into parts by '\n\n'
str = strsplit(str, '\n\n')';

% Pre 3: Merge duplicate environments for ease of processing.
envsToMerge = [
    "lstlisting"
    "verbatim"
    "matlabcode"
    "matlaboutput"
    "matlabtableoutput"
    "matlabsymbolicoutput"
    ];
for env = envsToMerge'
    str = janklab.exportmlx.internal.mergeSameEnvironments(str, env);
end

%% Markdown conversion

% Literal output handling
[str, ixLiteral] = janklab.exportmlx.internal.processLiteralOutput(str);

% Other parts
str2md = str(~ixLiteral);
str2md = janklab.exportmlx.internal.processDocumentOutput(str2md, options.tableMaxWidth);

% Equations
str2md = janklab.exportmlx.internal.processEquations(str2md, options.markdownStyle);

% Included graphics
str2md = janklab.exportmlx.internal.processincludegraphics(str2md, options.markdownStyle, ...
    options.png2jpeg, inFileStem, inParentDir);

% Apply vertical/horizontal space
% markdown: two spaces for linebreak
% latex: \vspace{1em}
% latex: \hskip1em
str2md = regexprep(str2md, "\\vspace{1em}", "  ");
str2md = regexprep(str2md, "\\hskip1em", "  ");
str(~ixLiteral) = str2md;

% Done! Merge them together
mdstr = join(str, LF);

%% Markdown post-processing and fixup

% Fix absolute paths in image links
absImgInDir = inParentDir + "/" + inFileStem + "_images";
% relImgOutDir = inFileStem + "_images";
mdstr = strrep(mdstr, absImgInDir + "/", "");

%% File output

if ismissing(options.outFile)
    outMdFile = noExtnFile + ".md";
else
    outMdFile = options.outFile;
end
imagesDirPath = noExtnFile + "_images";
janklab.exportmlx.internal.util.writetext(mdstr, outMdFile);

loginfo("Converting LaTeX to Markdown is complete.");
loginfo("  Markdown: " + outMdFile);
loginfo("  Images dir: " + imagesDirPath);
