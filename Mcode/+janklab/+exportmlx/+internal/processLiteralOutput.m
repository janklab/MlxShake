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

