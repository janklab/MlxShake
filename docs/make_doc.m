function make_doc(varargin)
% Build these doc sources into the final doc/ directory
%
% make_doc
% make_doc --preview
% make_doc --build-only
%
% This will only work on Linux or Mac, not Windows.
%
% Requires Ruby and Bundler to be installed, and available on your $PATH.
%
% Environment variables:
%   EXPORTMLX_MAKEDOC_NO_BUNDLER - set to 1 to bypass 'bundle install'.
%     This is a hack to get things working when your bundler is broken. If
%     you do this, you must have all the necessary gems installed in your
%     main system or user Ruby gems installation. Good luck.

action = "install";
args = string(varargin);
if ismember("--preview", args)
    action = "preview";
elseif ismember("--build-only", args)
    action = "build";
end

%#ok<*STRNU>

import janklab.exportmlx.internal.util.*

RAII.cd = withcd(fileparts(mfilename('fullpath')));

requireRubyAvailable;

skipBundler = string(getenv('EXPORTMLX_MAKEDOC_NO_BUNDLER')) == '1';

    function jekyll(varargin)
        cmd = "jekyll " + strjoin(varargin, "");
        if ~skipBundler
            cmd = "bundle exec " + cmd;
        end
        system2(cmd);
    end

if ~skipBundler
    system2('bundle install >/dev/null');
end

if action == "preview"
    jekyll('serve');
else
    jekyll('build &>/dev/null');
    if action == "install"
        if isfolder('../doc')
            rmdir2('../doc', 's');
        end
        copyfile2('_site/*.*', '../doc');
    end
end

end

function requireRubyAvailable
[status, output] = system('ruby --version'); %#ok<ASGLU>
if status ~= 0
    if ispc
        installMsg = "Please install it from https://rubyinstaller.org/.";
    elseif ismac
        installMsg = "Please install it using Homebrew: `brew install ruby bundler`";
    else
        installMsg = "Please install it using your OS's package manager.";
    end
    error("It doesn't look like you have Ruby installed.\n%s\n%s", ...
        "Ruby is required for building these docs.", installMsg);
end
end
