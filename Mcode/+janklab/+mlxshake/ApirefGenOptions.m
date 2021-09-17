classdef ApirefGenOptions
    % Options to control the behavior of the genapiref function.
    %
    % This controls various aspects of GENAPIREF's behavior.
    %
    % See also:
    % GENAPIREF
    
    properties
        % The file format to output to.
        format (1,1) string {mustBeMember(format, ["markdown", "html"])} = "markdown"
        
        projectName (1,1) string = "Untitled Project"
        
        % Whether to include stuff in +internal packages in the doco.
        %
        % Defaults to false.
        doInternal (1,1) logical = false
        
        % Whether to include Hidden members (methods and properties) in the doco.
        %
        % Defaults to false.
        showHidden (1,1) logical = false
        
        % The default format to interpret helptext as.
        %
        % This controls how helptext in the input source code is interpreted,
        % and thus how it is rendered in the output.
        %
        % Valid values:
        %
        % * "markdown" - Indicates that your helptext contains valid Markdown
        %         and can be rendered as such.
        % * "vanilla"  - Matlab's default helptext format, whatever that is.
        %         (default)
        %
        % The main impact of using "markdown" format is that, in your helptext,
        % you need to:
        %
        % * Indent all code examples by at least four spaces or enclose them in
        %   triple-backtick (`\`\`\``) code fences. Using indents will play
        %   nicer with Matlab's `help` function, but triple-backticks will let
        %   you get syntax highlighting and save space.
        % * Use `*` or `-` characters to introduce list items.
        
        helptextFormat (1,1) string {mustBeMember(helptextFormat, ...
            ["markdown", "vanilla"])} = "vanilla"
        % Old comments:
        % The default is actually "markdown", not "vanilla", because I think a
        % lot of helptext already works as Markdown, and that produces
        % nicer-formatted output. Switch it to "vanilla" if you have problems.
    end
    
    methods

        function this = ApirefGenOptions(arg)
            % Construct a new object.
            %
            %     obj = janklab.mlxshake.ApirefGenOptions
            %     obj = janklab.mlxshake.ApirefGenOptions(struct(...))
            %     obj = janklab.mlxshake.ApirefGenOptions({'property',value, ...})
            %
            % You may pass in a struct or cell vector of name/value pairs, where
            % the names are any property on ApirefGenOptions. Names that are not
            % properties of ApirefGenOptions cause an error.
            if nargin == 0
                return
            end
            
            if iscell(arg)
                nvs = janklab.mlxshake.internal.util.nvlist(arg);
                for i = 1:2:numel(nvs)
                    this.(nvs{i}) = nvs{i+1};
                end
            elseif isstruct(arg)
                if ~isscalar(arg)
                    error('struct inputs must be scalar');
                end
                for prop = fieldnames(arg)'
                    this.(prop) = arg.(prop);
                end
            elseif isa(arg, 'janklab.mlxshake.ApirefGenOptions')
                this = arg;
            else
                error('Invalid input type: %s', class(arg));
            end
            
        end
        
    end
    
end

