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
        % The publishing-platform-specific style of Markdown to use.
        %
        % This does not control what Markdown flavor is being used. Instead,
        % this is about how things are arranged or placed in the Markdown so
        % that the output is suitable for particular publishing targets (web
        % hosts), like GitHub Pages or Qiita.
        %
        % Valid values:
        %   'gh-pages' - For GitHub Pages. (default)
        %   'qiita' - For Qiita.
        %
        % If you don't know which one to use, stick with 'gh-pages'; it's pretty
        % vanilla.
        markdownPublishTarget (1,1) string ...
            {mustBeMember(markdownPublishTarget, ["gh-pages", "qiita"])} = 'gh-pages'
        % Whether to convert PNG images to JPEGs.
        % This saves space at the expense of image quality. Off by default.
        png2jpeg (1,1) logical = false
        % Maximum table width.
        % Default is 20.
        % (TODO: What units is this in: columns, inches, ???)
        tableMaxWidth (1,1) double = 20
        % Whether to add a comment referencing ExportMlx in the Markdown output.
        % This doesn't show up in user-visible presentation, but it helps people
        % figure out how the file was built, and I'd like some more users! But I
        % won't mind if you turn it off.
        addMention (1,1) logical = true
        % Whether to use a temporary directory for the intermediate files (UNIMPLEMENTED).
        % This is used for the .tex, .sty, and other files produced during the
        % processing sequence before arriving at the final .md file.
        useTempDir (1,1) logical = false
        % Whether to retain the intermediate files generated during the export.
        % Defaults to false. If true, the .tex, .sty, and other intermediate
        % files ar retained. If false, they are deleted once the final .md is
        % produced. Be careful! These intermediate files may overwrite
        % manually-managed files in the same directory as your .mlx and .md
        % files.
        keepIntermediateFiles (1,1) logical = false
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

