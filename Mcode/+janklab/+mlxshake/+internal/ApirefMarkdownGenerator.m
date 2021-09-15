classdef ApirefMarkdownGenerator < janklab.mlxshake.internal.ApirefGenerator
    
    %#ok<*MANU>
    %#ok<*AGROW>
    
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
            
            p("# %s - %s", name, pkg)
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
            
            [~,hForCodeBlock] = rawHelptextFor(qname);
            
            mkdirs(parentDir);
            fh = fopen2(mdFile, 'w', 'native', 'UTF-8');
            RAII.fh = onCleanup(@() fclose2(fh));
            p(true, fh);
            
            klass = meta.class.fromName(rec.qname);
            
            attribs = string([]);
            allAttribs = ["Hidden", "Sealed", "Abstract", "Enumeration", ...
                "ConstructOnLoad", "HandleCompatible", "RestrictsSubclassing"];
            for at = allAttribs
                if klass.(at)
                    attribs(end+1) = at;
                end
            end
            
            p("# %s - %s", name, pkg)
            p("")
            if ~isempty(attribs)
                p("%s", strjoin(attribs, ', '));
                p
            end
            
            p("## Description")
            p(klass.Description)
            p
            if ~isempty(klass.DetailedDescription)
                p("## Detailed Description")
                p(klass.DetailedDescription)
                p
            end
            p("## Helptext")
            p
            p("```text")
            p(hForCodeBlock)
            p
            p("```")
            p
            
            p("## Class Contents")
            p
            
            function pContentsList(itemTypePlural, itemType, itemList)
                if isempty(itemList)
                    return
                end
                p("### %s", itemTypePlural)
                p
                p("| %s | Description |", itemType)
                p("| -------- | ----------- |")
                for iItem = 1:numel(itemList)
                    item = itemList(iItem);
                    if isThisInherited(klass, item)
                        continue
                    end
                    itemQname = klass.Name + "." + item.Name;
                    p("| [%s](#%s) | %s |", item.Name, itemQname, item.Description);
                end
                p
            end
            
            pContentsList("Properties", "Property", klass.PropertyList);
            pContentsList("Methods", "Method", klass.MethodList);
            pContentsList("Events", "Events", klass.EventList);
            pContentsList("Enumerations", "Enumeration", klass.EnumerationMemberList);
                        
            if ~isempty(klass.SuperclassList)
                p("### Superclasses")
                p
                p("| Superclass | Description |")
                p("| -------- | ----------- |")
                for sk = klass.SuperclassList
                    p("| `%s` | %s |", sk.Name, sk.Description);
                end
                p
            end
            
            % Details for all the things
            
            function [itemQname] = pCommonItemStuff(item)
                    itemQname = klass.Name + "." + item.Name;
                    p('<a name="%s"></a>', itemQname)
                    p("### %s", item.Name)
                    p
                    if ~isa(item, 'meta.property')
                        [~,hForCodeBlock] = rawHelptextFor(itemQname);
                    else
                        hForCodeBlock = "No helptext available.";
                    end
                    p
                    p(item.Description)
                    p
                    p(item.DetailedDescription)
                    p
                    p("```text")
                    p(hForCodeBlock)
                    p("```")
                    p
            end
            
            if ~isempty(klass.PropertyList)
                p("## Properties")
                p
                for prop = klass.PropertyList(:)'
                    if isThisInherited(klass, prop)
                        continue
                    end
                    propQname = pCommonItemStuff(prop);
                end
                p
            end
            
            if ~isempty(klass.MethodList)
                p("## Methods")
                p
                for meth = klass.MethodList(:)'
                    if isThisInherited(klass, meth)
                        continue
                    end
                    methQname = pCommonItemStuff(meth);
                end
                p
            end
            
            if ~isempty(klass.EventList)
                p("## Events")
                p
                for event = klass.EventList(:)'
                    if isThisInherited(klass, event)
                        continue
                    end
                    eventQname = pCommonItemStuff(event);
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

