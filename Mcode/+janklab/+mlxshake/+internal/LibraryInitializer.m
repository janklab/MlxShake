classdef LibraryInitializer
    % Automatic library initializer hack support.
    
    methods
        
        function this = LibraryInitializer()
            % Construct a new object.
            %
            % This automatically calls the `initializePackage` function.
            janklab.mlxshake.internal.initializePackage;
        end
        
    end
    
end

