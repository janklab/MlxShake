function str2md = processEquations(str2md, format)
%% 2-10: Equations (��������)
% For Github users: Use https://latex.codecogs.com
% see. http://idken.net/posts/2017-02-28-math_github/ (Japanese)
%
% For Qiita users: (Qiita platform renders equations via mathML)
% Leave inline equation as it is (�����̐����� latex �� $equation$ �Ȃ̂ł��̂܂�)
% and $$equation$$ will be changed to
% ```math
% equation
% ```

switch format
    case 'qiita'
        str2md = regexprep(str2md,"[^`]\$\$([^$]+)\$\$[^`]","```math" + newline + "$1" + newline + "```");
    case 'github'
        tt = regexp(str2md,"[^`]\$\$([^$]+)\$\$[^`]", 'tokens');
        parts = horzcat(tt{:});
        for ii=1:length(parts)
            eqncode = replace(parts(ii),string(newline)," ");
            eqncode = replace(eqncode," ", "&space;");
            partsMD = "<img src=""https://latex.codecogs.com/gif.latex?" ...
                + eqncode + """/>";
            str2md = replace(str2md, "$$"+parts(ii)+"$$", partsMD);
        end
        
        % Inline
        tt = regexp(str2md,"[^`$]\$([^$]+)\$[^`$]", 'tokens');
        parts = horzcat(tt{:});
        for ii=1:length(parts)
            eqncode = replace(parts(ii)," ", "&space;");
            partsMD = "<img src=""https://latex.codecogs.com/gif.latex?\inline&space;" ...
                + eqncode + """/>";
            str2md = replace(str2md, "$"+parts(ii)+"$", partsMD);
        end
end