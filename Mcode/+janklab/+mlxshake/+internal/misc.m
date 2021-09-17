classdef misc
    % Miscellaneous utilities not for importing.
    %
    % The ones in this class are ones you typically wouldn't want to import.
    
    methods (Static=true)
        
        function mkdir(dir)
            % Create a directory, raising an error on failure.
            [ok,msg] = mkdir(dir);
            if ~ok
                error('Failed creating directory "%s": %s', dir, msg);
            end
        end
        
        function out = getpackageappdata(key)
            % Get an appdata item for the MlxShake package.
            ad = getappdata(0, 'mlxshake');
            if isempty(ad)
                ad = struct;
            end
            if isfield(ad, key)
                out = ad.(key);
            else
                out = [];
            end
        end
        
        function setpackageappdata(key, value)
            % Set an appdata item for the MlxShake package.
            ad = getappdata(0, 'mlxshake');
            if isempty(ad)
                ad = struct;
            end
            ad.(key) = value;
            setappdata(0, 'mlxshake', ad);
        end
        
    end
    
end