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
                [mFilePath, pkg, name, qname, type] = deal(rec.file, rec.package, ...
                    rec.name, rec.qname, rec.type);
                
                switch type
                    case "class"
                        this.generateClassDoc(rec);
                    case "contents"
                        % Special Contents.m handling
                        recordPkgContents(pkg, mFilePath);
                    case "function"
                        % It's a function or script, but not Contents
                        this.generateFunctionDoc(pkg, name, qname, mFilePath);
                    otherwise
                        error('internal error: invalid thing type: "%s"', type);
                end
                
            end
            
            % Package files
            
            for iPkg = 1:height(this.packages)
                this.generatePackageDoc(table2struct(this.packages(iPkg,:)));
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

            pkgs = this.packages(~this.packages.isInternal,:);
            internalPkgs = this.packages(this.packages.isInternal,:);
            
            p("# %s Index", this.opts.projectName)
            p            
            p("## Packages")
            p
            for iPkg = 1:size(pkgs, 1)
                pkg = table2struct(pkgs(iPkg,:));
                pkgRelHtmlFile = "package/" + pkg.key + ".html";
                p("* [`%s`](%s)", pkg.package, pkgRelHtmlFile);
            end
            p
            if ~isempty(internalPkgs)
                p
                p("## Internal Packages")
                p
                for iPkg = 1:size(internalPkgs, 1)
                    pkg = table2struct(internalPkgs(iPkg,:));
                    pkgRelHtmlFile = "package/" + pkg.key + ".html";
                    p("* [`%s`](%s)", pkg.package, pkgRelHtmlFile);
                end
                p
            end
            
            p("## Things")
            p
            p("TODO: Implement this.")
            
        end
        
        function generatePackageDoc(this, rec)
            [pkg,pkgKey,pkgDisp] = deal(rec.package, rec.key, rec.dispName);
            
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
            fcnThings = things(things.type == "function",:);
            classThings = things(things.type == "class",:);
            
            p("# " + pkgDisp);
            p
            if rec.isInternal
                p("> NOTE: Internal package! This is an internal implementation detail")
                p("> of the %s library.", this.opts.projectName);
                p
            end
            function genThingList(thingType, theThings)
                p("## %s", thingType);
                p
                for iThing = 1:height(theThings)
                    t = table2struct(theThings(iThing,:));
                    % thingRelMdFile = fullfile(thingsRelMdDir, t.name + ".md");
                    thingRelHtmlFile = thingsRelMdDir + "/" + t.name + ".html";
                    p("* [%s](%s)", t.name, thingRelHtmlFile);
                end
                p
            end
            if ~isempty(fcnThings)
                genThingList("Functions", fcnThings);
            end
            if ~isempty(classThings)
                genThingList("Classes", classThings);
            end
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
            if ~endsWith(h, newline)
                h = h + newline;
            end
            
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

            % HACK: escaping of internal fenced code blocks
            hForCodeBlock = strrep(h, "```", "`` `");
            
            p("# %s", qname)
            p("")
            p("```text")
            p(hForCodeBlock)
            p
            p("```")
            p
            
        end
        
        function generateClassDoc(this, rec)
            [pkg, name, qname] = deal(rec.package, rec.name, rec.qname);
            
            pkgComponents = strsplit(pkg, ".");
            relDir = strjoin(strcat("+", pkgComponents), filesep);
            parentDir = fullfile(this.thingsDir, relDir);
            mdFile = fullfile(parentDir, name + ".md");
            
            [h,hForCodeBlock] = rawHelptextFor(qname);
            
            mkdirs(parentDir);
            fh = fopen2(mdFile, 'w', 'native', 'UTF-8');
            RAII.fh = onCleanup(@() fclose2(fh));
            p(true, fh);
            
            klass = meta.class.fromName(rec.qname);

            p("# %s", qname)
            p("")
            p("```text")
            p(hForCodeBlock)
            p
            p("```")
            p
            
            p("## Class Contents")
            p
            
            if ~isempty(klass.PropertyList)
                p("### Properties")
                p
                p("| Property | Description |")
                p("| -------- | ----------- |")
                for i = 1:numel(klass.PropertyList)
                    prop = klass.PropertyList(i);
                    if isThisInherited(klass, prop)
                        continue
                    end
                    p("| `%s` | %s |", prop.Name, '???');
                end
                p
            end
            
            if ~isempty(klass.MethodList)
                p("### Methods")
                p
                p("| Method | Description |")
                p("| -------- | ----------- |")
                for meth = klass.MethodList(:)'
                    if isThisInherited(klass, meth)
                        continue
                    end
                    p("| `%s` | %s |", meth.Name, '???');
                end
                p
            end
            
            if ~isempty(klass.EventList)
                p("### Events")
                p
                p("| Event | Description |")
                p("| -------- | ----------- |")
                for event = klass.EventList(:)'
                    if isThisInherited(klass, event)
                        continue
                    end
                    p("| `%s` | %s |", event.Name, '???');
                end
                p
            end
            
            if ~isempty(klass.EnumerationMemberList)
                p("### Enumerations")
                p
                p("| Enumeration| Description |")
                p("| -------- | ----------- |")
                for enum = klass.EnumerationMemberList
                    if isThisInherited(klass, enum)
                        continue
                    end
                    p("| `%s` | %s |", enum.Name, '???');
                end
                p
            end
            
            if ~isempty(klass.SuperclassList)
                p("### Superclasses")
                p
                p("| Superclass | Description |")
                p("| -------- | ----------- |")
                for sk = klass.SuperclassList
                    p("| `%s` | %s |", sk.Name, '???');
                end
                p
            end
            
            % TODO: Details for all the things
            
            if ~isempty(klass.MethodList)
                p("## Methods")
                p
                for meth = klass.MethodList(:)'
                    if isThisInherited(klass, meth)
                        continue
                    end
                    methQname = pkg + "." + meth.Name;
                    p("### `%s`", meth.Name)
                    p
                    [h,hForCodeBlock] = rawHelptextFor(methQname);
                    p("```text")
                    p(hForCodeBlock)
                    p("```")
                    p
                end
                p
            end
            
        end
        
    end
    
end

function [out, forCodeBlock] = rawHelptextFor(name)
raw = help(name);
out = regexprep(raw, '(?<=^|\n)  ?', '');
% HACK: escaping of internal fenced code blocks
forCodeBlock = strrep(out, "```", "`` `"); % Undocumented form of help
end

function out = isThisInherited(klass, thing)
out = thing.DefiningClass ~= klass;
end

function p(fmt, varargin)
persistent fh
if nargin > 0 && islogical(fmt)
    fh = varargin{1};
    return
end
if nargin == 0
    fprintf(fh, "\n");
else
    fprintf(fh, fmt + "\n", varargin{:});
end
end

