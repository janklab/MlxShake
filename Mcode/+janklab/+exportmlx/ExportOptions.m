classdef ExportOptions
    % Options to control behavior of Live Script export
    %
    % All the options to control the behavior of livescript2markdown and
    % its helper functions are bundled up in this class.
    %
    % See also:
    % LIVESCRIPT2MARKDOWN
    
    properties
        % The output file name for the final Markdown export.
        outFile (1,1) string = missing
        % The style (subformat) of Markdown to use.
        markdownStyle (1,1) string ...
            {mustBeMember(markdownStyle, ["github", "qiita"])} = 'github'
        % Whether to convert PNG images to JPEGs.
        % This saves space at the expense of image quality. Off by default.
        png2jpeg (1,1) logical = false
        % Maximum table width.
        % Default is 20.
        % (TODO: What units is this in: columns, inches, ???)
        tableMaxWidth (1,1) double = 20
    end
    
    methods
        
        function this = ExportOptions(arg)
            % Construct a new object
            %
            % obj = janklab.exportmlx.ExportOptions
            % obj = janklab.exportmlx.ExportOptions({'property',value, ...})
            %
            % You may pass in a cell vector of name/value pairs, where the
            % names are any property on ExportOptions.
            if nargin == 0
                return
            end
            
            if iscell(arg)
                for i = 1:2:numel(arg)
                    this.(arg{i}) = arg{i+1};
                end
            elseif isa(arg, 'janklab.exportmlx.ExportOptions')
                this = arg;
            else
                error('Invalid input type: %s', class(arg));
            end
                
        end
        
    end
end

