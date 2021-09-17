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
        
        function out = loglevel(newLevel)
            % Get or set logging level for the mlxshake package.
            %
            % out = janklab.mlxshake.globals.loglevel()
            % oldLevel = janklab.mlxshake.globals.loglevel(newLevel)
            %
            % This is a convenience method that provides a simplified interface
            % on top of MlxShake's internal logging tools. It does not support
            % all functionality of level control. This is intentional, to keep
            % the interface simple.
            %
            % NewLevel (string) is the logging level to set at the root
            % janklab.mlxshake package. This should control all logging done by
            % MlxShake. Valid values are:
            %    "info"  - The regular, concise and quiet logging.
            %    "debug" - More detailed logging, with progress messages.
            %
            % The return value is the currently-set logging level. Possible
            % values are:
            %    "info"
            %    "debug"
            %    "custom" - Means the logging configuration is in a weird state
            %        that this function is not prepared to handle.
            
            logger = janklab.mlxshake.internal.logger.Logger.getLogger('janklab.mlxshake');
            enabledLevels = logger.enabledLevels;
            if isequal(enabledLevels, {'error', 'warn', 'info'})
                out = "info";
            elseif isequal(enabledLevels, {'error', 'warn', 'info', 'debug'})
                out = "debug";
            else
                out = "custom";
            end
            
            if nargin > 0
                newLevel = lower(string(newLevel));
                switch newLevel
                    case "info"
                        janklab.mlxshake.internal.logger.Log4jConfigurator.setLevels({
                            'janklab.mlxshake','INFO'});
                    case "debug"
                        janklab.mlxshake.internal.logger.Log4jConfigurator.setLevels({
                            'janklab.mlxshake','DEBUG'});
                    otherwise
                        error('Invalid logging level: "%s"', newLevel);
                end
            end
            
            if nargout == 0
                clear out
            end
        end
        
    end
    
end

