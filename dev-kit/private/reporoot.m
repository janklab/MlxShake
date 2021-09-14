function out = reporoot
% The root dir of the MlxShake repo
out = string(fileparts(fileparts(fileparts(mfilename('fullpath')))));
end