classdef ApirefGenOpts
    % Options for genapiref.
    
    properties
        format (1,1) string {mustBeMember(format, ["markdown", "html"])} = "markdown"
        projectName (1,1) string = "Untitled Project"
        doInternal (1,1) logical = false
    end
    
    methods

        function this = ApirefGenOpts(arg)
            % Construct a new object
            %
            % obj = janklab.mlxshake.ApirefGenOpts
            % obj = janklab.mlxshake.ApirefGenOpts(struct(...))
            % obj = janklab.mlxshake.ApirefGenOpts({'property',value, ...})
            %
            % You may pass in a struct or cell vector of name/value pairs, where
            % the names are any property on ApirefGenOpts. Names that are not
            % properties of ApirefGenOpts cause an error.
            if nargin == 0
                return
            end
            
            if iscell(arg)
                for i = 1:2:numel(arg)
                    this.(arg{i}) = arg{i+1};
                end
            elseif isstruct(arg)
                if ~isscalar(arg)
                    error('struct inputs must be scalar');
                end
                for prop = fieldnames(arg)'
                    this.(prop) = arg.(prop);
                end
            elseif isa(arg, 'janklab.mlxshake.ApirefGenOpts')
                this = arg;
            else
                error('Invalid input type: %s', class(arg));
            end
            
        end
        
    end
    
end

