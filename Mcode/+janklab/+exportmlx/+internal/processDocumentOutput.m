function str = processDocumentOutput(str, tableMaxWidth)
% Process document output

LF = newline;

%% 2-1: Fix latex conventions for non-literal parts
replacements = [
    % ^ (live script) -> \textasciicircum{} (latex)
    "\textasciicircum{}", "^"
    % _ (live script) -> \_ (latex) example: test_case -> test\_ case
    "\_", "_"
    % / backslash (live script) -> \textbackslash{} (latex)
    "\textbackslash{}", "\"
    % > (live script) -> \textgreater{} (latex)
    "\textgreater{}", ">"
    % < (live script) -> \textless{} (latex)
    "\textless{}", "<"
    % $ (live script) -> \$ (latex)
    "\$", "$"
    % % (live script) -> \% (latex)
    "\%", "%"
];
for i = 1:size(replacements, 1)
    str = replace(str, replacements(i,1), replacements(i,2));
end

% These will be left as they are till the end of this function
% since these affect the markdown format 
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
idxNonGraphics = ~contains(str, "\includegraphics");
str(idxNonGraphics) = replace(str(idxNonGraphics),...
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
itemizeIdx = contains(str, ["\begin{itemize}", "\end{itemize}"]);
itemsParts = str(itemizeIdx);
partsMarkdown = regexprep(itemsParts, " *\\item{([^{}]+)}", "*$1");
partsMarkdown = erase(partsMarkdown, ["\begin{itemize}", "\end{itemize}"]);
str(itemizeIdx) = partsMarkdown;

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
itemizeIdx = contains(str, ["\begin{enumerate}", "\end{enumerate}"]);
itemsParts = str(itemizeIdx);
partsMarkdown = regexprep(itemsParts, " *\\item{([^{}]+)}", "1.$1");% Any numder works
partsMarkdown = erase(partsMarkdown, ["\begin{enumerate}", "\end{enumerate}"]);
str(itemizeIdx) = partsMarkdown;

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

symoutIdx = contains(str, ["\begin{matlabsymbolicoutput}" , "\end{matlabsymbolicoutput}"]);
symoutParts = str(symoutIdx);
tmp = erase(symoutParts, "\begin{matlabsymbolicoutput}" + LF);
tmp = replace(tmp, "$\displaystyle", "$$");
partsMarkdown = replace(tmp, "$" + LF + "\end{matlabsymbolicoutput}", "$$");
str(symoutIdx) = partsMarkdown;
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
idxTblOutput = startsWith(str, "\begin{matlabtableoutput}" + LF);
tableLatex = extractBetween(str(idxTblOutput), ...
    "\begin{tabular}", "\end{tabular}");

tableMD = strings(sum(idxTblOutput), 1);
for ii=1:sum(idxTblOutput)
    tablecontents = split(tableLatex(ii), "\hline");
    formatLatex = tablecontents(1); % {|l|c|r|}
    headerLatex = tablecontents(2); % \mlcell{TD} & \mlcell{TD} & \mlcell{TD} \\ \hline
    bodyLatex = tablecontents(3:end); % and the rest.
    
    format = regexp(formatLatex, "\{([^{}]+)}", 'tokens');
    format = format{:};
    format = replace(format, "c", ":--:");
    format = replace(format, "l", ":--");
    format = replace(format, "r", "--:");
    
    % MultiColumn is not standard in markdown.
    % It only happens as a variable name in MATLAB
    % so adding special case for processing headerLatex
    multicol = regexp(headerLatex, "\\multicolumn{(\d)+}", 'tokens');
    tmp = regexp(headerLatex, "\\mlcell{(.|\s)*?} (?:&|\\\\)", 'tokens');
    if isempty(multicol)
        header = "|" + join([tmp{:}], "|") + "|";
    else
        nRepeat = double(multicol{:});
        header = "|" + join([tmp{:}], "|") + join(repmat("|", 1, nRepeat));
    end
    
    body = string;
    for jj=1:length(bodyLatex)
        tmp = regexp(bodyLatex(jj), "\\mlcell{(.|\s)*?} (?:&|\\\\)", 'tokens');
        if isempty(tmp)
            break
        end
        tmp = cellfun(@(str1) cutStringLength(str1, tableMaxWidth), tmp, ...
            'UniformOutput', false);
        
        % Adding escape to text that affects markdown table (\n and |)
        tmp = cellfun(@(str1) replace(str1, "|", "\|"), tmp, 'UniformOutput', false);
        tmp = cellfun(@(str1) replace(str1, LF, "<br>"), tmp, 'UniformOutput', false);
        body = body + "|" + join([tmp{:}], "|") + "|" + LF;
    end
    
    tableMD(ii) = strjoin([header, format, body],LF);
end
str(idxTblOutput) = tableMD;

%% finish up
str = replace(str, "\{", "{");
str = replace(str, "\}", "}");

end

function str2 = cutStringLength(str1, N)
    
    str2 = str1;
    if strlength(str1) > N
       tmp = char(str1);
       str2 = string(tmp(1:N)) + "...";
    end
end

