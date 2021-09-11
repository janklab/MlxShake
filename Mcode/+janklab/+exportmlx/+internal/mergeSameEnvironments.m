function newstr = mergeSameEnvironments(str, environment)
% Merge same environments

LF = newline;

% str is a vector of string
% start index of a enviroment
idx_start = startsWith(str, "\begin{"+environment+"}");
% start index of a enviroment
idx_end = endsWith(str, "\end{"+environment+"}");

% for each \being and \end pair needs to be in one string
start_lstlisting = find(idx_start);
end_lstlisting = find(idx_end);

% check if the number of \being and that of \end match.
assert(sum(idx_start) == sum(idx_end), ...
    "The number of \begin and that of \end does not match for "...
    + string(environment) + " environment." + LF ...
    + "Please contact minoue@mathworks.com with the reproduction step.");

for ii=1:length(start_lstlisting)
    idx = start_lstlisting(ii):end_lstlisting(ii);
    if length(idx) > 1 % skip if \begin and \end are in the same string
        % join them with LF in between
        mergedstring = strjoin(str(idx), string([LF, LF]));
        str(idx(1)) = mergedstring;
        str(idx(2:end)) = "";
    end
end

% Delete the deleted empty string
str(strlength(str) == 0) = [];
newstr = str;
