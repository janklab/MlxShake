function mlxshake_build
% Build the project in preparation for distribution
%
% You do _not_ need to call this to get the project running from Mcode/.
% This is just for special code transformation steps needed for the
% distributed project, like p-coding.

reporoot = janklab.mlxshake.globals.distroot;
origDir = pwd;
RAII.cd = onCleanup(@() cd(origDir));
cd(reporoot)

fprintf('Building MlxShake...\n')

cfgFile = fullfile(reporoot, '.mlproject.json');
config = jsondecode(janklab.mlxshake.internal.util.readtext(cfgFile));

% Copy Mcode/ into build/Mcode
buildMcodeDir = fullfile('build', 'Mcode');
if isfolder(buildMcodeDir)
  rmdir(buildMcodeDir, 's');
end
mkdir(buildMcodeDir);
copyfile('Mcode', buildMcodeDir)

% P-code the files if requested in the project definition
if isfield(config, 'build') && isfield(config.build, 'do_pcode')
  if config.build.do_pcode
    fprintf('Pcoding files...\n')
    origWarn = warning;
    RAII.warning = onCleanup(@() warning(origWarn));
    warning off MATLAB:pcode:FileNotFound
    d = dir('build/Mcode/**/+*');
    dirs = string(['build/Mcode' fullfile({d.folder}, {d.name})]);
    for d = dirs
      pcode(d, '-inplace')
    end
    d = dir([buildMcodeDir, '/**/*.m']);
    mfilesInBuild = fullfile({d.folder}, {d.name});
    delete(mfilesInBuild{:})
  end
end

fprintf('Built MlxShake.\n')

end