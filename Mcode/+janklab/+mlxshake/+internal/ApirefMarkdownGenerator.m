classdef ApirefMarkdownGenerator < janklab.mlxshake.internal.ApirefGenerator
    
    %#ok<*MANU>
    
    properties
        stuffDir
        pkgsDir
        thingsDir
        pkgInfo
        uPackages
        
        pkgRelMdFiles = string([])
        thingRelMdFiles = string([])
    end
    
    methods
        
        function generateForMyFormat(this)
            % Format-specific generation
            %
            % Generates:
            %   * index.md
            %   * stuff/<package>.md for each package
            %   * stuff/<thing>.md for each class or function
            
            this.stuffDir = fullfile(this.outDir, "stuff");
            mkdir(this.stuffDir);
            this.pkgsDir = fullfile(this.outDir, 'package');
            mkdir(this.pkgsDir);
            this.thingsDir = fullfile(this.outDir, 'thing');
            mkdir(this.thingsDir);
            
            this.uPackages = unique(this.mfiles.package);
            this.pkgInfo = containers.Map;
            function recordPkgContents(pkg, contentsPath)
                if ~this.pkgInfo.isKey(pkg)
                    this.pkgInfo(pkg) = string([]);
                end
                this.pkgInfo(pkg) = [this.pkgInfo(pkg) contentsPath];
            end
            
            % Thing files
            
            for iFile = 1:height(this.mfiles)
                rec = table2struct(this.mfiles(iFile,:));
                [mFilePath, pkg, name, qname] = deal(rec.file, rec.package, ...
                    rec.name, rec.qname);
                
                [resolved, type] = which(qname);
                klass = meta.class.fromName(qname);
                
                if ~isempty(klass)
                    % It's a class
                elseif lower(name) == "contents"
                    % Special Contents.m handling
                    recordPkgContents(pkg, mFilePath);
                elseif ~isempty(resolved)
                    % It's a function or script, but not Contents
                    this.generateFunctionDoc(pkg, name, qname, mFilePath);                    
                else
                    error("Unable to resolve thing: '%s'", qname);
                end
                
            end
            
            % Package files
            
            for iPkg = 1:numel(this.uPackages)
                this.generatePackageDoc(this.uPackages(iPkg));
            end
            
            % Index file
            
            this.generateIndex;
        end
        
        function generateIndex(this)
            indexMdFile = fullfile(this.outDir, 'index.md');
            
            fh = fopen2(indexMdFile, 'w', 'native', 'UTF-8');
            RAII.fh = onCleanup(@() fclose2(fh));
            function p(fmt, varargin)
                if nargin == 0
                    fprintf(fh, "\n");
                else
                    fprintf(fh, fmt + "\n", varargin{:});
                end
            end

            p("# %s Index", this.opts.projectName)
            p
            p("## Packages")
            p
            for iPkg = 1:size(this.pkgRelMdFiles, 1)
                [pkg,pkgDisp,pkgKey,relMdFile] = this.pkgRelMdFiles{iPkg,:};
                pkgRelHtmlFile = regexprep(relMdFile, '\.md$', '.html');
                p("* [`%s`](%s)", pkg, pkgRelHtmlFile);
            end
            p
            
            p("## Things")
            p
            p("TODO")
            
        end
        
        function generatePackageDoc(this, pkg)
            if pkg == ""
                pkgDisp = "<base>";
                pkgKey = "_base_";
            else
                pkgDisp = pkg;
                pkgKey = strrep(pkg, '.', '_');
            end
            
            pkgRelMdFile = "package/" + pkgKey + ".md";
            pkgMdFile = fullfile(this.pkgsDir, pkgKey + ".md");

            fh = fopen2(pkgMdFile, 'w', 'native', 'UTF-8');
            RAII.fh = onCleanup(@() fclose2(fh));
            function p(fmt, varargin)
                if nargin == 0
                    fprintf(fh, "\n");
                else
                    fprintf(fh, fmt + "\n", varargin{:});
                end
            end

            this.pkgRelMdFiles = [this.pkgRelMdFiles; ...
                {pkg, pkgDisp, pkgKey, pkgRelMdFile}];
            
            pkgComponents = strsplit(pkg, ".");
            pkgPathComponents = strcat("+", pkgComponents);
            thingsRelMdDir = "../thing/" + strjoin(pkgPathComponents, "/");
            
            things = this.mfiles(this.mfiles.package == pkg,:);
            [~,ix] = sort(things.name);
            things = things(ix,:);
            
            p("# " + pkgDisp);
            p
            p("## Things in package")
            p
            for iThing = 1:height(things)
                rec = table2struct(things(iThing,:));
                % thingRelMdFile = fullfile(thingsRelMdDir, rec.name + ".md");
                thingRelHtmlFile = thingsRelMdDir + "/" + rec.name + ".html";
                p("* [%s](%s)", rec.name, thingRelHtmlFile);
            end
            p
        end
        
        function generateFunctionDoc(this, pkg, name, qname, mFilePath)
            % 
            
            % fcnh = str2func(qname);
            pkgComponents = strsplit(pkg, ".");
            relDir = strjoin(strcat("+", pkgComponents), filesep);
            parentDir = fullfile(this.thingsDir, relDir);
            mdFile = fullfile(parentDir, name + ".md");
            
            basicHelptext = help(qname); % Undocumented form of help
            h = regexprep(basicHelptext, '(?<=^|\n)  ?', '');
            
            mkdirs(parentDir);
            fh = fopen2(mdFile, 'w', 'native', 'UTF-8');
            RAII.fh = onCleanup(@() fclose2(fh));
            function p(fmt, varargin)
                if nargin == 0
                    fprintf(fh, "\n");
                else
                    fprintf(fh, fmt + "\n", varargin{:});
                end
            end

            % Hacky escaping of internal fenced code blocks
            hForCodeBlock = strrep(h, "```", "`` `");
            
            
            p("# %s", qname)
            p("")
            p("```text")
            p(hForCodeBlock)
            p("```")
            p
            
        end
        
    end
    
end

