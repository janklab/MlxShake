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
    + "This is a bug in ExportMlx (or maybe Matlab). " ...
    + "Please report it at https://github.com/janklab/ExportMlx/issues.");

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
