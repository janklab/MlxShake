classdef Settings < janklab.mlxshake.internal.MlxshakeBaseHandle
    % Global settings for the mlxshake package
    %
    % Don't use this class directly. If you want to get or set the settings,
    % work with the instance of this in the janklab.mlxshake.globals.settings
    % field.
    %
    % There are currently no settings defined for this package.
    
    properties
    end
    
    methods (Static=true)
        
        function out = discover()
            % Discovery of initial values for package settings.
            %
            % This could look at config files, environment variables, Matlab appdata, and
            % so on.
            %
            % This needs to avoid referencing mlxshake.globals, to avoid a circular dependency.
            out = janklab.mlxshake.Settings;
        end
        
    end
    
end