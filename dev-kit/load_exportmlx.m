function load_exportmlx(flags)
% Load the ExportMlx library in to this Matlab session.
%
% load_exportmlx [<flag> ...]
%
% This is what you can run from a fresh Matlab session to load in the
% library. It's mostly used by automated test tools and other
% Matlab-launching stuff.
%
% Flags call for additional things to be loaded:
%
%   'dev-kit'    - adds dev-kit/ to the path
%   'examples'   - adds examples/ to the path

arguments
    flags string = []
end

repoDir = fileparts(fileparts(mfilename('fullpath')));
toplevelDir = [repoDir '/Mcode'];
addpath(toplevelDir);
if ismember("dev-kit", flags)
    addpath(fullfile(repoDir, 'dev-kit'));
end
if ismember("examples", flags)
    addpath(fullfile(repoDir, 'examples'));
end
