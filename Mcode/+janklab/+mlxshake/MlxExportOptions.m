classdef MlxExportOptions
    % Options to control behavior of Live Script export.
    %
    % All the options to control the behavior of exportlivescript and
    % its helper functions are bundled up in this class.
    %
    % The constructor accepts name/value pairs as a 2n-long cell vector or
    % struct, so anywhere you can provide an ExportOptions object, you can also
    % pass in a cell or struct of property definitions, which will automatically
    % be converted to an ExportOptions.
    %
    % See also:
    % EXPORTLIVESCRIPT
    
    properties (Constant)
        validFormats = ["auto", "markdown", "html", "pdf", "latex", "msword"];
    end
    
    properties
        % Output file format.
        %
        % Controls what format to export the Live Script to.
        %
        % Defaults to "auto".
        %
        % Valid values:
        %
        %   "auto" - Automatically select the format based on the file extension
        %       of the output file (using the outFile option). Defaults to 
        %       Markdown if no explicit output file is given, or the output 
        %       file has no extension.
        %   "markdown"
        %   "html"
        %   "pdf"
        %   "latex"
        %   "msword"  - Microsoft Word
        %  
        format (1,1) string {mustBeMember(format, ["auto", "markdown", "html",...
            "pdf", "latex", "msword"])} = "auto"
        
        % The output file path for the final exported file.
        %
        % This is the full path to the destination file. If you supply a plain
        % file name with no path, it will end up in the current working
        % directory. (Not necessarily the parent directory of the input file.)
        %
        % This file defines the main output file, like the '<foo>.md' file for
        % Markdown. Additional auxiliary files and directories may also be
        % generated next to it, and they will be named based on transformations
        % of the main output file name.
        %
        % If missing, the output file is chosen automatically based on the input
        % .mlx file name.
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
        
        % Maximum length of strings in table cells, in characters.
        %
        % Default is 20. Strings longer than this are simply truncated to this
        % length and appended with "...".
        %
        % THIS BEHAVIOR IS SUBJECT TO CHANGE IN THE NEAR FUTURE.
        tableMaxCellContentLength (1,1) double = 20
        
        % Whether to add a comment referencing MlxShake in the Markdown output.
        % This doesn't show up in user-visible presentation, but it helps people
        % figure out how the file was built, and I'd like some more users! But I
        % won't mind if you turn it off.
        addMention (1,1) logical = true
        
        % Controls what working directory to use for temporary intermediate files.
        %
        % May be a logical or a string containing a path. Valid values:
        %
        %    logical true (default) - A temporary directory is automatically selected
        %        and created.
        %    string - Specifies the path to the working directory. The dir
        %        will not be deleted after export is finished.
        %    logical false ? No temporary directory is used; intermediate files are
        %        placed in the final output directory.
        %
        % The intermediate files are the *.tex, *.sty, and and other temporary
        % files produced during theprocessing sequence before arriving at the
        % final *.md or other output files.
        tempDir = true
        
        % Whether to retain the intermediate files generated during the export.
        %
        % Defaults to false. If true, the .tex, .sty, and other intermediate
        % files are retained. If false, they are deleted once the final .md is
        % produced. Be careful! These intermediate files may overwrite
        % manually-managed files in the same directory as your .mlx and .md
        % files.
        %
        % This is mostly useful for debugging MlxShake itself. The existence
        % and type of intermediate files produced is an internal implementation
        % detail of MlxShake, and may change at any time. Do not rely on
        % intermediate files for any of your real output.
        keepIntermediateFiles (1,1) logical = false
        
        % Whether to make local copies of math equation images.
        %
        % This controls how the codecogs rendering of math equations is handled.
        % If true, then at export time, each equation is rendered as an image
        % and that is saved to a file. If false, then the math equations are
        % left as codecogs image links that render the image using an online web
        % service at document viewing time.
        grabEquationImages (1,1) logical = true
    end
    
    methods
        
        function this = MlxExportOptions(arg)
            % Construct a new object.
            %
            % obj = janklab.mlxshake.MlxExportOptions
            % obj = janklab.mlxshake.MlxExportOptions(struct(...))
            % obj = janklab.mlxshake.MlxExportOptions({'property',value, ...})
            %
            % You may pass in a struct or cell vector of name/value pairs, where
            % the names are any property on MlxExportOptions. Names that are not
            % properties of MlxExportOptions cause an error.
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
            elseif isa(arg, 'janklab.mlxshake.MlxExportOptions')
                this = arg;
            else
                error('Invalid input type: %s', class(arg));
            end
            
        end
        
        function this = set.tempDir(this, val)
            if ischar(val)
                val = string(val);
            end
            if ~(isstring(val) || islogical(val))
                error('tempDir must be string or logical; got a %s', class(val));
            end
            if ~isscalar(val)
                error('tempDir must be scalar');
            end
            this.tempDir = val;
        end
        
    end
end

