% \texttt{^\{\} }�́A\texttt{\{ }�� `\` }�ȊO�̔C�ӂ̕���
% \texttt{\href\{http://xxx.com\}\{�e�L�X�g\} }

function mdfile = latex2markdown(filename,options)
%  Copyright 2020 The MathWorks, Inc.

% What is arguments?
% see: https://jp.mathworks.com/help/matlab/matlab_prog/argument-validation-functions.html
arguments
    filename (1,1) string
    options.outputfilename char = filename
    options.format char {mustBeMember(options.format,{'qiita','github'})} = 'github'
end

% Latex filename
latexfile = filename + ".tex";

% check if latexfile exists
assert(exist(latexfile,'file')>0, ...
    latexfile + " does not exist. " ...
    + "If you haven't generate latex file from a live script please do so.");

% Import latex file and have it as a string variable
% If the mlx contains double byte charactors, it needs to use fgets.
% Otherwise the following does the work.
% str = string(fileread(latexfile));
fid = fopen(latexfile,'r','n','UTF-8');
str = string;
tmp = fgets(fid);
while tmp > 0
    str = append(str,string(tmp));
    tmp = fgets(fid);
end
fclose(fid);

% Extract body from latex
str = extractBetween(str,"\begin{document}","\end{document}");

%% Devide the body into each environment
% Preprocess 1:
% Add 'newline' to the end of the following.
% \end{lstlisting}, \end{verbatim}, \end{matlabcode}, \end{matlaboutput},\end{center}
% \end{matlabtableoutput}  \vspace{1em}
% �v�f���Ƃɕ������₷���悤�� \end �̌�ɉ��s�������ꍇ�͂P�ǉ�
str = replace(str,"\end{lstlisting}"+newline,"\end{lstlisting}"+newline+newline);
str = replace(str,"\end{verbatim}"+newline,"\end{verbatim}"+newline+newline);
str = replace(str,"\end{matlabcode}"+newline,"\end{matlabcode}"+newline+newline);
str = replace(str,"\end{matlaboutput}"+newline,"\end{matlaboutput}"+newline+newline);
str = replace(str,"\end{matlabtableoutput}"+newline,"\end{matlabtableoutput}"+newline+newline);
str = replace(str,"\end{center}"+newline,"\end{center}"+newline+newline);
str = replace(str,"\vspace{1em}"+newline,"\vspace{1em}"+newline+newline);

% Preprocess 2:
% Replace more than three \n to \n\n.
% 3�s�ȏ�̋󔒂�2�s�ɂ��Ă���
str = regexprep(str,'\n{3,}','\n\n');

% Devide them into parts by '\n\n'
% �󔒍s�ŗv�f�ɕ���
str = strsplit(str,'\n\n')';

% Postprocess 1:
% a part starts with \end{*} merges to the previous string.
% \end{~} �Ŏn�܂��Ă��܂��P�[�X�͑O�� string �ƌ���
% known issue�F\begin{matlaboutput}
% idx = find(startsWith(str,'\end'));
% str(idx-1) = str(idx-1) + newline + str(idx);
% str(idx) = [];

% Postprocess 2:
% Delete empty strings
% str(strlength(str) == 0) = [];

% Postprocess 3:
% The following environments will be merge into one string
% for the ease of process.
% MATLAB�R�[�h�������s�ɂ킽��Ƃ��܂������ł��Ȃ��̂� �Ή����� \end ��������܂ŘA������
% \begin{verbatim}
% \begin{lstlisting}
% \begin{matlabcode}
% \begin{matlaboutput}
str = mergeSameEnvironments(str,"lstlisting");
str = mergeSameEnvironments(str,"verbatim");
str = mergeSameEnvironments(str,"matlabcode");
str = mergeSameEnvironments(str,"matlaboutput");

%% Let's convert latex to markdown
% 1: Process parts that require literal output.
[str, idxLiteral] = processLiteralOutput(str);

% 2: Process that other parts
str2md = str(~idxLiteral);
str2md = processDocumentOutput(str2md);

% Equations (��������)
str2md = processEquations(str2md, options.format);

% includegraphics (�摜����)
str2md = processincludegraphics(str2md, options.format, filename);

% Apply vertical space
% markdown: two spaces for linebreak
% latex: \vspace{1em}
str2md = regexprep(str2md,"\\vspace{1em}","  ");
str(~idxLiteral) = str2md;

%% Done! Merge them together
strmarkdown = join(str,newline);

%% File output�t�@�C���o��
mdfile = options.outputfilename + ".md";
fileID = fopen(mdfile,'w');
fprintf(fileID,'%s\n',strmarkdown);
fclose(fileID);

disp("Coverting latex to qiita markdown is complete");
disp(mdfile);
disp("Note: Related images are saved in " + filename + "_images");