function [str, idxLiteral] = processLiteralOutput(str)
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

idx_lstlisting = startsWith(str, "\begin{lstlisting}");
idx_verbatim = startsWith(str, "\begin{verbatim}");
idx_matlabcode = startsWith(str, "\begin{matlabcode}");
idx_matlaboutput = startsWith(str, "\begin{matlaboutput}");

idxLiteral = idx_lstlisting | idx_verbatim | idx_matlabcode | idx_matlaboutput;

LF = newline;
str(idx_lstlisting) = LF + "```matlab:Code(Display)" + extractBetween(str(idx_lstlisting), ...
    "\begin{lstlisting}", "\end{lstlisting}") + "```" + LF;
str(idx_verbatim) = LF + "```matlab:Code(Display)" + extractBetween(str(idx_verbatim), ...
    "\begin{verbatim}", "\end{verbatim}") + "```" + LF;
str(idx_matlabcode) = LF + "```matlab:Code" + extractBetween(str(idx_matlabcode), ...
    "\begin{matlabcode}", "\end{matlabcode}") + "```" + LF;
str(idx_matlaboutput) = LF + "```text:Output" + extractBetween(str(idx_matlaboutput), ...
    "\begin{matlaboutput}", "\end{matlaboutput}") + "```" + LF;

