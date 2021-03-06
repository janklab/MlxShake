function mlxshake_make(target, varargin)
% Build tool for mlxshake
%
% mlxshake_make <target> [...options...]
%
% This is the main build tool for doing all the build and packaging operations
% for mlxshake. It's intended to be called as a command. This is what you will
% use to build & package the distribution files for a release of the package.
%
% Targets:
%
%   test      - run the tests
%
%   dist      - build the full dist files (both zips and toolbox)
%   zips      - build the dist archive files (zips)
%
%   toolbox   - build the Matlab Toolbox .mltbx installer file
%   clean     - delete all the derived artifacts
%
%   docs      - build docs/ etc. (the GH Pages stuff) from docs-src and examples (merge)
%   doc       - build doc/, the final static (local) doco files (from docs/, replace)
%   m-doc     - build build/M-doc/ MLTBX format docs (from doc/)
%   docview   - live-preview the project doco (from docs/) (requires Jekyll)
%
%   build     - "build" (transform and pcode) the source code
%   buildmex  - build all the MEX files in the source tree

%#ok<*STRNU>

arguments
  target (1,1) string
end
arguments (Repeating)
  varargin
end

if target == "test"
  mlxshake_launchtests
elseif target == "docs"
  build_docs(varargin)
elseif target == "doc"
  build_doc
elseif target == "doc-preview"
  preview_docs
elseif target == "m-doc"
  make_mdoc
elseif target == "toolbox"
  mlxshake_make m-doc
  mlxshake_package_toolbox
elseif target == "zips"
  mlxshake_make build
  mlxshake_make m-doc
  make_archives
elseif target == "dist"
  mlxshake_make zips
  mlxshake_make toolbox
  fprintf('Made dist.\n')
elseif target == "clean"
  make_clean
elseif target == "build"
  mlxshake_build
elseif target == "buildmex"
  mlxshake_build_all_mex
else
  error("Unknown target: %s", target);
end

end

function make_mdoc
rmrf('build/M-doc')
mkdir2('build/M-doc')
copyfile2('doc/*', 'build/M-doc')
if isfile('build/M-doc/feed.xml')
  delete('build/M-doc/feed.xml')
end
end

function preview_docs
import janklab.mlxshake.internal.util.*;
RAII.cd = withcd('docs');
make_doc --preview
end

function make_archives
program = "MlxShake";
distName = program + "-" + janklab.mlxshake.globals.version;
verDistDir = fullfile("dist", distName);
distfiles = ["build/Mcode" "doc" "examples" "README.md" "LICENSE" ...
    "VERSION" "CHANGES.md"];
rmrf([verDistDir, distName+".tar.gz", distName+".zip"])
if ~isfolder('dist')
  mkdir2('dist')
end
mkdir2(verDistDir)
for distFile = distfiles
    system2(sprintf("cp -R '%s' '%s'", distFile, verDistDir));
end
RAII.cd = withcd('dist');
tar(distName+".tar.gz", distName)
zip(distName+".zip", distName)
end

function make_clean
rmrf(strsplit("dist/* build docs/site docs/_site test-output", " "));
end

function build_docs(parts)
% Build the generated parts of docs/ from docs-src/ and other places
mlxshake_gendocs(parts);
end

function build_doc
% Build the final static doc/ files from docs/
RAII.cd = withcd(fullfile(reporoot, 'docs'));
make_doc;
delete('../doc/make_doc*');
end
