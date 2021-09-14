classdef LsLatex2MardkownExporter < janklab.mlxshake.internal.MlxshakeBase
    % Exports LS-exported LaTeX to Markdown
    
    %#ok<*INUSA>
    
    properties
    end
    
    methods
        
        function outMdFile = lslatex2markdown(this, inFile, opts)
            % Convert Live Script LaTeX to Markdown.
            %
            % outMdFile = obj.lslatex2markdown(inFile, opts)
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
            % Opts is a janklab.mlxshake.MlxExportOptions object. See its documentation for
            % available options and their behavior.
            %
            % Returns the path to the generated .md file.
            %
            % See also:
            % MLXEXPORTOPTIONS
            
            arguments
                this (1,1)
                inFile (1,1) string
                opts (1,1) janklab.mlxshake.MlxExportOptions = janklab.mlxshake.MlxExportOptions
            end
            
            persistent initializerHack
            if isempty(initializerHack)
                initializerHack = janklab.mlxshake.internal.MlxshakeBase;
            end
            
            LF = newline;
            
            %% Argument handling and validation
            
            [inDir,inFileStem,inFileExtn] = fileparts(inFile);
            if inDir == ""
                inDir = pwd;
            end
            
            if inFileExtn == ""
                texFile = fullfile(inDir, inFileStem + ".tex");
            else
                texFile = inFile;
            end
            % styFile = fullfile(inDir, 'matlab.sty');
            inImagesRelDir = inFileStem + "_images";
            inImagesDir = fullfile(inDir, inImagesRelDir);
            
            if ismissing(opts.outFile)
                outDir = inDir;
                outMdFile = fullfile(outDir, inFileStem + ".md");
            else
                outMdFile = opts.outFile;
                [outDir,~,~] = fileparts(outMdFile);
                if outDir == ""
                    outDir = pwd;
                end
            end
            [~,outFileStem,~] = fileparts(outMdFile);
            outImagesRelDir = outFileStem + "_images";
            outImagesDir = fullfile(outDir, outImagesRelDir);
            if ~isfolder(outImagesDir)
                mkdir(outImagesDir);
            end
            
            if ~isfile(texFile)
                error("Input LaTeX file '" + texFile + " does not exist. " ...
                    + "If you haven't generate latex file from a live script please do so, " ...
                    + "using mlx2latex.");
            end
            
            loginfo('Exporting: %s -> %s', texFile, outMdFile);
            
            %% Preprocess latex
            
            % Read latex
            str = readtext(texFile);
            
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
                str = mergeSameEnvironments(str, env);
            end
            
            %% Markdown conversion
            
            % Literal output handling
            [str, ixLiteral] = processLiteralOutput(str);
            
            % Other parts
            str2md = str(~ixLiteral);
            str2md = processDocumentOutput(str2md, opts.tableMaxCellContentLength);
            
            % Equations
            
            % Yes, in*Dir is right: We're building intermediate files here, and
            % they get copied over to the destination at the end.
            str2md = processEquations(str2md, opts, inImagesRelDir, inImagesDir);
            
            % Included graphics
            str2md = processIncludedGraphics(str2md, opts.markdownPublishTarget, ...
                opts.png2jpeg, inFileStem, inDir);
            
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
            absImgInDir = inDir + "/" + inFileStem + "_images";
            % relImgOutDir = inFileStem + "_images";
            mdstr = strrep(mdstr, absImgInDir + "/", "");
            
            % Add a mention of MlxShake
            if opts.addMention
                mdstr = mdstr + LF + LF ...
                    + sprintf("<!-- This Markdown was generated from Matlab Live Script with Janklab MlxShake (https://mlxshake.janklab.net) -->") ...
                    + LF;
            end
            
            % Condense excess newlines
            % BUG: This is a little too aggressive, because it will also apply to code
            % blocks and pre text. But that's a rare enough use case that we'll let that
            % slide for now.
            mdstr = regexprep(mdstr, "\n\n\n+", "\n\n");
            
            % Fix trailing whitespace
            mdstr = regexprep(mdstr, " +\n", "\n");
            mdstr = regexprep(mdstr, "\n\n+$", "\n");
            
            %% File output
            
            if outDir ~= inDir
                % TODO: Utility function to wrap up this dir-copy logic
                outImagesDir = fullfile(outDir, outFileStem + "_images");
                rmrf(outImagesDir);
                mkdir2(outImagesDir);
                copyfile(inImagesDir, outImagesDir);
            end
            writetext(mdstr, outMdFile);
            
            loginfo("Exported:  %s -> %s", texFile, outMdFile);
            
        end
        
    end
    
end

function str = processDocumentOutput(str, tableMaxCellContentLength)
% Process document output

LF = newline;

%% 2-1: Fix latex conventions for non-literal parts
replacements = [
    % ^ (live script) -> \textasciicircum{} (latex)
    "\textasciicircum{}"    "^"
    % _ (live script) -> \_ (latex) example: test_case -> test\_ case
    "\_", "_"
    % / backslash (live script) -> \textbackslash{} (latex)
    "\textbackslash{}"      "\"
    % > (live script) -> \textgreater{} (latex)
    "\textgreater{}"        ">"
    % < (live script) -> \textless{} (latex)
    "\textless{}"           "<"
    % $ (live script) -> \$ (latex)
    "\$"                    "$"
    % % (live script) -> \% (latex)
    "\%"                    "%"
    ];
for i = 1:size(replacements, 1)
    str = replace(str, replacements(i,1), replacements(i,2));
end

% These will be left as they are till the end of this function
% since these affect the markdown format .
%
% { (live script) -> \} (latex) (leave it till end)
% } (live script) -> \{ (latex) (leave it till end)

% To deal with \{ and \} inside other commands, it's easier to
% make regular expression if we change these to letters. (will change it back later)
str = replace(str, "\{", "BackslashCurlyBlacketOpen");
str = replace(str, "\}", "BackslashCurlyBlacketClose");

%% 2-2: Text decoration
% \textbf{bold}
% \textit{italic}
% \underline{underline}
% \texttt{equispace}
% and all the possible conbinations of these four.

% Need to keep this execution sequence
str = regexprep(str, "\\textbf{([^{}]+)}", "**$1**");
str = regexprep(str, "\\textit{([^{}]+)}", "*$1*");
str = regexprep(str, "\\underline{([^{}]+)}", "$1"); % Ignore underline
str = regexprep(str, "\\texttt{(\*{0,3})([^*{}]+)(\*{0,3})}", "$1`$2`$3");

% Note on the processing \texttt
% Example:
% str = "\\texttt{\\textbf{EquispaceBold}}";
% str = regexprep(str, "\\textbf{([^{}]+)}", "**$1**");
% str = regexprep(str, "\\texttt{([^{}]+)}", "`$1`");
% gives
% `**EquispaceBold**`
% which does not work. ` ` needs to be most inside.

%% 2-3: Hyperlinks
% Markdown: [string](http://xxx.com)
% latex: \href{http://xxx.com}{string}
str = regexprep(str, "\\href{([^{}]+)}{([^{}]+)}", "[$2]($1)");

%% 2-4: Title and headings
% Add an extra LF to make sure there's a blank line between immediately
% subsequent headings. Excess LFs will get cleaned up later.
str = regexprep(str, "\\matlabtitle{([^{}]+)}", "# $1\n");
% Headings are converted to next level down to conform with Markdownlint style
str = regexprep(str, "\\matlabheading{([^{}]+)}", "## $1\n");
str = regexprep(str, "\\matlabheadingtwo{([^{}]+)}", "### $1\n");
str = regexprep(str, "\\matlabheadingthree{([^{}]+)}", "#### $1\n");

% Put \{ and \{ back.
str = replace(str, "BackslashCurlyBlacketOpen", "\{");
str = replace(str, "BackslashCurlyBlacketClose", "\}");

%% 2-5: Quotation
% Markdown: >
% Latex:
% \begin{par}
% \begin{center}
% xxxx
% \end{center}
% \end{par}
% Note: \includegraphics is an exception
tfNonGraphics = ~contains(str, "\includegraphics");
str(tfNonGraphics) = replace(str(tfNonGraphics),...
    "\begin{par}" + LF + "\begin{center}" + LF, "> ");

%% 2-6: Delete unnecessary commands
% Commands to specify the text position
things = [
    "\begin{par}"
    "\end{par}"
    "\begin{flushleft}"
    "\end{flushleft}"
    "\begin{flushright}"
    "\end{flushright}"
    "\begin{center}"
    "\end{center}"
    ];
for thing = things'
    str = erase(str, thing);
end

%% 2-7: Unordered list
% markdown: add - to each item
% latex:
%      \begin{itemize}
%      \setlength{\itemsep}{-1ex}
%         \item{\begin{flushleft} リスト１ \end{flushleft}}
%         \item{\begin{flushleft} リスト２ \end{flushleft}}
%         \item{\begin{flushleft} リスト３ \end{flushleft}}
%      \end{itemize}
str = erase(str, "\setlength{\itemsep}{-1ex}" + LF);
tfItemize = contains(str, ["\begin{itemize}", "\end{itemize}"]);
itemsParts = str(tfItemize);
partsMarkdown = regexprep(itemsParts, " *\\item{([^{}]+)}", "*$1");
partsMarkdown = erase(partsMarkdown, ["\begin{itemize}", "\end{itemize}"]);
str(tfItemize) = partsMarkdown;

%% 2-8: Ordered list
% markdown: 1. itemname
% latex:
%      \begin{enumerate}
%      \setlength{\itemsep}{-1ex}
%         \item{\begin{flushleft} リスト１ \end{flushleft}}
%         \item{\begin{flushleft} リスト２ \end{flushleft}}
%         \item{\begin{flushleft} リスト３ \end{flushleft}}
%      \end{enumerate}
str = erase(str, "\setlength{\itemsep}{-1ex}" + LF);
tfItemize = contains(str, ["\begin{enumerate}", "\end{enumerate}"]);
itemsParts = str(tfItemize);
partsMarkdown = regexprep(itemsParts, " *\\item{([^{}]+)}", "1.$1");% Any numder works
partsMarkdown = erase(partsMarkdown, ["\begin{enumerate}", "\end{enumerate}"]);
str(tfItemize) = partsMarkdown;

%% 2-9: Symbolic output
% markdown: inline equation
% latex:
% \begin{matlabsymbolicoutput}
% ans =
%     $\displaystyle -\cos \left(x\right)$
% \end{matlabsymbolicoutput}
%
% and
%
% \begin{matlabsymbolicoutput}
% a =
%     $\displaystyle \left(\begin{array}{cccc}
% \cos \left(\theta \right) & -\sin \left(\theta \right) & 0 & 0\\
% \sin \left(\theta \right) & \cos \left(\theta \right) & 0 & 0\\
% 0 & 0 & 1 & 0\\
% 0 & 0 & 0 & 1
% \end{array}\right)$
% \end{matlabsymbolicoutput}

tfSymout = contains(str, ["\begin{matlabsymbolicoutput}" , "\end{matlabsymbolicoutput}"]);
symoutParts = str(tfSymout);
tmp = erase(symoutParts, "\begin{matlabsymbolicoutput}" + LF);
tmp = replace(tmp, "$\displaystyle", "$$");
partsMarkdown = replace(tmp, "$" + LF + "\end{matlabsymbolicoutput}", "$$");
str(tfSymout) = partsMarkdown;
% NOTE: This part will be processed by processEquations.m

%% 2-10: table output
% markdown:
% | TH left | TH center | TH right |
% | :--- | :---: | ---: |
% | TD | TD | TD |
% | TD | TD | TD |
% latex:
% \begin{matlabtableoutput}
% {
% \begin{tabular} {|l|c|r|}\hline
% \mlcell{TD} & \mlcell{TD} & \mlcell{TD} \\ \hline
% \mlcell{TD} & \mlcell{TD} & \mlcell{TD} \\
% \hline
% \end{tabular}
% }
% \end{matlabtableoutput}
tfTblOutput = startsWith(str, "\begin{matlabtableoutput}" + LF);
tableLatex = extractBetween(str(tfTblOutput), ...
    "\begin{tabular}", "\end{tabular}");

tableMD = strings(sum(tfTblOutput), 1);
for i = 1:sum(tfTblOutput)
    tablecontents = split(tableLatex(i), "\hline");
    formatLatex = tablecontents(1); % {|l|c|r|}
    headerLatex = tablecontents(2); % \mlcell{TD} & \mlcell{TD} & \mlcell{TD} \\ \hline
    bodyLatex = tablecontents(3:end); % and the rest.
    
    format = regexp(formatLatex, "\{([^{}]+)}", 'tokens');
    format = format{:};
    format = replace(format, "c", ":--:");
    format = replace(format, "l", ":--");
    format = replace(format, "r", "--:");
    
    % MultiColumn is not standard in markdown.
    % This happens when a Matlab table variable has multiple columns or is a
    % nested table.
    multicol = regexp(headerLatex, "\\multicolumn{(\d)+}", 'tokens');
    % This regex is buggy: the non-greedy *? inside the {...} fails to handle
    % nested {}s.
    tmp = regexp(headerLatex, "\\mlcell{(.|\s)*?} (?:&|\\\\)", 'tokens');
    if isempty(multicol)
        header = "|" + join([tmp{:}], "|") + "|";
    else
        nRepeat = double(multicol{:});
        % HACK: Just remove braces from column names to work around buggy regex
        % above.
        for iTmp = 1:numel(tmp)
            tmp{iTmp} = strrep(tmp{iTmp}, "}", "");
        end
        header = "|" + join([tmp{:}], "|") + join(repmat("|", 1, nRepeat));
    end
    
    body = string;
    for j = 1:numel(bodyLatex)
        tmp = regexp(bodyLatex(j), "\\mlcell{(.|\s)*?} (?:&|\\\\)", 'tokens');
        if isempty(tmp)
            break
        end
        tmp = cellfunnu(@(str1) cutStringLength(str1, tableMaxCellContentLength), tmp);
        % Adding escape to text that affects markdown table (\n and |)
        tmp = cellfunnu(@(str1) replace(str1, "|", "\|"), tmp);
        tmp = cellfunnu(@(str1) replace(str1, LF, "<br>"), tmp);
        body = body + "|" + join([tmp{:}], "|") + "|" + LF;
    end
    
    tableMD(i) = strjoin([header format body], LF);
end
str(tfTblOutput) = tableMD;

%% finish up
str = replace(str, "\{", "{");
str = replace(str, "\}", "}");

end

function str = processEquations(str, opts, outImagesRelDir, outImagesDir)
% Process math equations
%
% For Github users: Use https://latex.codecogs.com
% See: http://idken.net/posts/2017-02-28-math_github/ (Japanese)
%
% For Qiita users: (Qiita platform renders equations via mathML)
% Leave inline equation as it is and $$equation$$ will be changed to
% ```math
% equation
% ```
arguments
    str string
    opts (1,1) janklab.mlxshake.MlxExportOptions
    outImagesRelDir (1,1) string
    outImagesDir (1,1) string
end

LF = newline;

eqnum = 1;
switch opts.markdownPublishTarget
    case 'gh-pages'
        dummyAltText = 'Some math equation';
        tt = regexp(str, "[^`]?\$\$([^$]+)\$\$[^`]?", 'tokens');
        idx = cellfun(@iscell, tt);
        % if tt contains 0x0 string, horzcat(tt{:}) generates string vector
        % whereas if tt with cell only, horzcat(tt{:}) generates cell
        % vector... so.
        parts = horzcat(tt{idx});
        for i = 1:numel(parts)
            eqncode = replace(parts{i}, string(LF), " ");
            eqncode = replace(eqncode, " ", "&space;");
            if opts.grabEquationImages
                [mdImgTag, eqnum] = saveCodecogsRender(eqncode, outImagesRelDir, outImagesDir, eqnum);
            else
                mdImgTag = sprintf("![%s](%s)", dummyAltText, codecogsGifUrl(eqncode));
            end
            str = replace(str, "$$" + parts(i) + "$$", mdImgTag);
        end
        
        % Inline
        tt = regexp(str, "[^`$]\$([^$]+)\$[^`$]", 'tokens');
        parts = horzcat(tt{:});
        for i = 1:numel(parts)
            eqncode = replace(parts(i), " ", "&space;");
            if opts.grabEquationImages
                [mdImgTag, eqnum] = saveCodecogsRender(eqncode, outImagesRelDir, outImagesDir, eqnum);
            else
                codecogsUrl = codecogsGifUrl("\inline&space;" + eqncode);
                mdImgTag = sprintf("![%s](%s)", dummyAltText,codecogsUrl);
            end
            str = replace(str, "$" + parts(i) + "$", mdImgTag);
        end
        
    case 'qiita'
        str = regexprep(str, "[^`]?\$\$([^$]+)\$\$[^`]?", ...
            LF + "```math" + LF + "$1" + LF + "```");
end

end

function [out, eqnum] = saveCodecogsRender(equationCode, imagesRelDir, imagesDir, eqnum)
fileBase = sprintf("eqn_codecogs_%d.gif", eqnum);
eqnum = eqnum + 1;
relFile = fullfile(imagesRelDir, fileBase);
file = fullfile(imagesDir, fileBase);
grabCodecogsEquationImage(equationCode, file);
out = sprintf("![%s](%s)", "Some math equation", relFile);
end

function out = codecogsGifUrl(equationCode)
baseUrl = "https://latex.codecogs.com/gif.latex";
out = baseUrl + "?" + equationCode;
end

function grabCodecogsEquationImage(equationCode, file)
arguments
    equationCode (1,1) string
    file (1,1) string
end
codecogsGifUrl = "https://latex.codecogs.com/gif.latex";
codecogsUrl = codecogsGifUrl + "?" + equationCode;
websave(file, codecogsUrl);
end

function str = processIncludedGraphics(str, publishTarget, png2jpeg, filename, filepath)
% Process included graphics
%
% Note: There are two cases in the tex
% 1: inserted image: \includegraphics[width=\maxwidth{64.52584044154541em}]{image_0}
% 2: generated figure: \includegraphics[width=\maxwidth{52.78474661314601em}]{figure_0.png}
%
% Inserted images needs to ???
arguments
    str string
    publishTarget (1,1) string
    png2jpeg (1,1) logical
    filename (1,1) string
    filepath (1,1) string
end

LF = newline;

% markdown (GitHub): ![string]('path to a image')
% latex では \includegraphics[width=\maxwidth{56.196688409433015em}]{filename}
tfImage = contains(str, "\includegraphics");
imageParts = str(tfImage);

% When exported latex from live script, figures and inserted images
% are saved in 'imagedir' as image files.
% latex を生成した時点で Figure 等は画像としてimagedir に保存されている
imageDir = filename + "_images/";
imageDir = strrep(imageDir, '\', '/');

% for each images
for i = 1:length(imageParts)
    % Detect the actual filename with extention
    filenames = regexp(imageParts(i), "\\includegraphics\[[^\]]+\]{([^{}]+)}", "tokens");
    [~, fileStem, ~] = fileparts(filenames{:});
    fileGlob = fullfile(filepath, imageDir, fileStem + ".*");
    imageFilename = ls(fileGlob); 
    
    % Compress PNG images as JPEG
    if png2jpeg
        [~,imageFileStem,ext] = fileparts(imageFilename);
        if strcmp(ext,'.png')
            I = imread(fullfile(imageDir, imageFilename));
            imageFilename = [imageFileStem '_png.jpg'];
            imwrite(I, fullfile(imageDir, imageFilename), 'Quality', 85);
        end
    end
    
    switch publishTarget
        case 'gh-pages'
            %  ![string]('path to a image')
            md = regexprep(imageParts(i), "\\includegraphics\[[^\]]+\]{"+filenames{:}+"}",...
                "![" + imageFilename + "](" + imageDir + imageFilename + ")");
            md = strrep(md, LF, "") + LF;
            imageParts(i) = md;

        case 'qiita'
            % Qiita に移行する際は、画像ファイルを該当箇所に drag & drop する必要
            % 幅指定する場合には
            % <img src="" alt="attach:cat" title="attach:cat" width=500px>
            placeholder = regexprep(imageParts(i), "\\includegraphics\[[^\]]+\]{" + filenames{:} + "}",...
                "<--" + LF ...
                + "**Please drag & drop an image file here**" + LF ...
                + "Filename: **" + imageDir + imageFilename + "**" + LF ...
                + "If you want to set the image size use the following command" + LF ...
                + "<img src="" alt=""attach:cat"" title=""attach:cat"" width=500px>" + LF ...
                + "-->");
            imageParts(i) = placeholder;
    end
end

str(tfImage) = imageParts;

end

function [str, tfLiteral] = processLiteralOutput(str)
% Process literal output

%% MATLAB Code
% Latex: 
% \begin{matlabcode}(code)\end{matlabcode}
% \begin{verbatim}(code)\end{verbatim}
% \begin{lstlisting}(code)\end{lstlisting}
%
% Markdown
% ```matlab:MATLAB Code
% （code）
%```

%% Literal Outputs
% Latex: 
% \begin{matlaboutput}(output)\end{matlaboutput}
%
% Markdown
% ```text:Output
%  (output)
% ```
% Note: Other outputs (matlabsymbolicoutout, matlabtableoutput)
% will be processed in processDocumentOutput.m

tfLstlisting = startsWith(str, "\begin{lstlisting}");
tfVerbatim = startsWith(str, "\begin{verbatim}");
tfMatlabCode = startsWith(str, "\begin{matlabcode}");
tfMatlabOutput = startsWith(str, "\begin{matlaboutput}");

tfLiteral = tfLstlisting | tfVerbatim | tfMatlabCode | tfMatlabOutput;

LF = newline;
str(tfLstlisting) = LF + "```matlab:Code(Display)" + extractBetween(str(tfLstlisting), ...
    "\begin{lstlisting}", "\end{lstlisting}") + "```" + LF;
str(tfVerbatim) = LF + "```matlab:Code(Display)" + extractBetween(str(tfVerbatim), ...
    "\begin{verbatim}", "\end{verbatim}") + "```" + LF;
str(tfMatlabCode) = LF + "```matlab:Code" + extractBetween(str(tfMatlabCode), ...
    "\begin{matlabcode}", "\end{matlabcode}") + "```" + LF;
str(tfMatlabOutput) = LF + "```text:Output" + extractBetween(str(tfMatlabOutput), ...
    "\begin{matlaboutput}", "\end{matlaboutput}") + "```" + LF;

end

function out = mergeSameEnvironments(str, environment)
% Merge same environments
%
% out = mergeSameEnvironments(str, environment)
%
% Str is a possibly-nonscalar string array, and how it's broken up matters.
%
% Returns a possibly-nonscalar string array.
arguments
    str string
    environment (1,1) string
end

LF = newline;

% Find each occurence of the environment
% for each \being and \end pair needs to be in one string
tfStart = startsWith(str, "\begin{"+environment+"}");
tfEnd = endsWith(str, "\end{"+environment+"}");
ixStart = find(tfStart);
ixEnd = find(tfEnd);

% Ensure number of \begin and \end match
assert(numel(ixStart) == numel(ixEnd), ...
    "The number of \begin and \end tags does not match for " ...
    + "environment '" + environment + "'." + LF ...
    + "This is a bug in MlxShake (or maybe Matlab). " ...
    + "Please report it at https://github.com/janklab/MlxShake/issues.");

% Do merging
for i = 1:numel(ixStart)
    ix = ixStart(i):ixEnd(i);
    if length(ix) > 1 % skip if \begin and \end are in the same string
        % join them with LF in between
        mergedstring = strjoin(str(ix), string([LF LF]));
        str(ix(1)) = mergedstring;
        str(ix(2:end)) = "";
    end
end

% Delete empty strings
str(strlength(str) == 0) = [];

out = str;

end

function str2 = cutStringLength(str1, N)
str2 = str1;
if strlength(str1) > N
    tmp = char(str1);
    str2 = string(tmp(1:N)) + "...";
end
end

function out = cellfunnu(varargin)
out = cellfun(varargin{:}, 'UniformOutput', false);
end
