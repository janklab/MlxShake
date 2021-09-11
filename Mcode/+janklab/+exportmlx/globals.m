classdef globals
  % Global library properties and settings for ExportMlx.
  %
  % Note that if you want to change the settings, you can't do this:
  %
  %    exportmlx.globals.settings.someSetting = 42;
  %
  % That will break due to how Matlab Constant properties work. Instead, you need
  % to first grab the Settings object and store it in a variable, and then work
  % on that:
  %
  %    s = exportmlx.globals.settings;
  %    s.someSetting = 42;
  
  properties (Constant)
    % Path to the root directory of this ExportMlx distribution
    distroot = string(fileparts(fileparts(fileparts(mfilename('fullpath')))));
    % Global settings for exportmlx.
    settings = exportmlx.Settings.discover
  end
  
  methods (Static)
    
    function out = version
      % The version of the ExportMlx library
      %
      % Returns a string.
      persistent val
      if isempty(val)
        versionFile = fullfile(exportmlx.globals.distroot, 'VERSION');
        val = strtrim(exportmlx.internal.util.readtext(versionFile));
      end
      out = val;
    end
    
    function initialize
      % Initialize this library/package
      exportmlx.internal.initializePackage;
    end
    
  end
  
end

