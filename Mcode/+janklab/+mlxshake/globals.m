classdef globals
  % Global library properties and settings for MlxShake.
  %
  % Note that if you want to change the settings, you can't do this:
  %
  %    janklab.mlxshake.globals.settings.someSetting = 42;
  %
  % That will break due to how Matlab Constant properties work. Instead, you need
  % to first grab the Settings object and store it in a variable, and then work
  % on that:
  %
  %    s = janklab.mlxshake.globals.settings;
  %    s.someSetting = 42;
  
  properties (Constant)
    % Path to the root directory of this MlxShake distribution
    distroot = string(fileparts(fileparts(fileparts(fileparts(mfilename('fullpath'))))));
    % Global settings for mlxshake.
    settings = janklab.mlxshake.Settings.discover
  end
  
  methods (Static)
    
    function out = version
      % The version of the MlxShake library
      %
      % Returns a string.
      persistent val
      if isempty(val)
        versionFile = fullfile(janklab.mlxshake.globals.distroot, 'VERSION');
        val = strtrim(janklab.mlxshake.internal.util.readtext(versionFile));
      end
      out = val;
    end
    
    function initialize
      % Initialize this library/package
      janklab.mlxshake.internal.initializePackage;
    end
    
  end
  
end

