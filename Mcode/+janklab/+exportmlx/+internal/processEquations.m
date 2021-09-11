function str = processEquations(str, format)
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

switch format
    case 'qiita'
        str = regexprep(str, "[^`]?\$\$([^$]+)\$\$[^`]?", ...
            newline + "```math" + newline + "$1" + newline + "```");
    case 'github'
        tt = regexp(str, "[^`]?\$\$([^$]+)\$\$[^`]?", 'tokens');
        idx = cellfun(@iscell, tt);
        % if tt contains 0x0 string, horzcat(tt{:}) generates string vector
        % whereas if tt with cell only, horzcat(tt{:}) generates cell
        % vector... so.
        parts = horzcat(tt{idx});
        for ii=1:length(parts)
            eqncode = replace(parts{ii}, string(newline), " ");
            eqncode = replace(eqncode, " ", "&space;");
            partsMD = "<img src=""https://latex.codecogs.com/gif.latex?" ...
                + eqncode + """/>";
            str = replace(str, "$$" + parts(ii) + "$$", partsMD);
        end
        
        % Inline
        tt = regexp(str, "[^`$]\$([^$]+)\$[^`$]", 'tokens');
        parts = horzcat(tt{:});
        for ii=1:length(parts)
            eqncode = replace(parts(ii), " ", "&space;");
            partsMD = "<img src=""https://latex.codecogs.com/gif.latex?\inline&space;" ...
                + eqncode + """/>";
            str = replace(str, "$" + parts(ii) + "$", partsMD);
        end
end
