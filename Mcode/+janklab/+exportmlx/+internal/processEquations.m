function str = processEquations(str, publishTarget)
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
    publishTarget (1,1) string {mustBeMember(publishTarget, ["gh-pages", "qiita"])} = 'gh-pages'
end

LF = newline;

switch publishTarget
    case 'gh-pages'
        tt = regexp(str, "[^`]?\$\$([^$]+)\$\$[^`]?", 'tokens');
        idx = cellfun(@iscell, tt);
        % if tt contains 0x0 string, horzcat(tt{:}) generates string vector
        % whereas if tt with cell only, horzcat(tt{:}) generates cell
        % vector... so.
        parts = horzcat(tt{idx});
        for i = 1:numel(parts)
            eqncode = replace(parts{i}, string(LF), " ");
            eqncode = replace(eqncode, " ", "&space;");
            partsMd = "<img src=""https://latex.codecogs.com/gif.latex?" ...
                + eqncode + """/>";
            str = replace(str, "$$" + parts(i) + "$$", partsMd);
        end
        
        % Inline
        tt = regexp(str, "[^`$]\$([^$]+)\$[^`$]", 'tokens');
        parts = horzcat(tt{:});
        for i = 1:numel(parts)
            eqncode = replace(parts(i), " ", "&space;");
            partsMd = "<img src=""https://latex.codecogs.com/gif.latex?\inline&space;" ...
                + eqncode + """/>";
            str = replace(str, "$" + parts(i) + "$", partsMd);
        end
        
    case 'qiita'
        str = regexprep(str, "[^`]?\$\$([^$]+)\$\$[^`]?", ...
            LF + "```math" + LF + "$1" + LF + "```");
end
