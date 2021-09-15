classdef ApirefMarkdownGenerator < janklab.mlxshake.internal.ApirefGenerator
    % Generates Markdown format output for API Reference doco.
    
    % TODO: Links to inherited items.
    % TODO: Would be nice if default value were displayed as the expression
    % from the source code, not the resolved value.
    % FIXME: Static methods with the same name as global functions can pick
    % up the wrong helptext.
    % TODO: Break out constructor display.
    % TODO: More compact item lists?
    % TODO: Get helptext from arguments blocks.
    
    %#ok<*MANU>
    %#ok<*AGROW>
    %#ok<*NBRAK>
    %#ok<*INUSL>
    
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
            % Format-specific generation implementation.
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
        
        function out = thingHtmlFileRelPath(this, thing)
            pkgParts = strsplit(thing.package, '.');
            out = "thing/" + strjoin(strcat("+", pkgParts), "/") ...
                + "/" + thing.name + ".html";
        end
        
        function generateIndex(this)
            % Generate the main index files for the full code base.
            indexMdFile = fullfile(this.outDir, 'index.md');
            
            fh = fopen2(indexMdFile, 'w', 'native', 'UTF-8');
            RAII.fh = onCleanup(@() fclose2(fh));
            p(true, fh);
            
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
            if this.opts.doInternal
                if ~isempty(internalPkgs)
                    p
                    p("## Internal Packages")
                    p
                    for iPkg2 = 1:size(internalPkgs, 1)
                        pkg2 = table2struct(internalPkgs(iPkg2,:));
                        pkgRelHtmlFile = "package/" + pkg2.key + ".html";
                        p("* [`%s`](%s)", pkg2.package, pkgRelHtmlFile);
                    end
                    p
                end
            end
            
            function pThingList(pkgsList)
                for iPkg3 = 1:size(pkgsList, 1)
                    pkg3 = table2struct(pkgsList(iPkg3,:));
                    thingsInPkg = this.mfiles(this.mfiles.package == pkg3.package,:);
                    p("### %s", pkg3.package)
                    p
                    for iThing = 1:height(thingsInPkg)
                        thing = table2struct(thingsInPkg(iThing,:));
                        p("* [`%s`](%s)", thing.name, this.thingHtmlFileRelPath(thing))
                    end
                    p
                end
            end
            p("## Things")
            p
            pThingList(pkgs)
            if this.opts.doInternal
                p("## Internal Things")
                p
                pThingList(internalPkgs)
            end
            
        end
        
        function generatePackageDoc(this, rec)
            % Generate doco files for a package.
            %
            % This does the package-level stuff only; not the functions and
            % classes contained within it.
            [pkg,pkgKey,pkgDisp] = deal(rec.package, rec.key, rec.dispName);
            
            pkgRelMdFile = "package/" + pkgKey + ".md";
            pkgMdFile = fullfile(this.pkgsDir, pkgKey + ".md");
            
            fh = fopen2(pkgMdFile, 'w', 'native', 'UTF-8');
            RAII.fh = onCleanup(@() fclose2(fh));
            p(true, fh);
            
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
            % Generate doco file for a function.
            
            hFcn = str2func(qname);
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
            p(true, fh);
            
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
            % Generate doco file for a class.
            [pkg, classBaseName, qname] = deal(rec.package, rec.name, rec.qname);
            
            pkgComponents = strsplit(pkg, ".");
            relDir = strjoin(strcat("+", pkgComponents), filesep);
            parentDir = fullfile(this.thingsDir, relDir);
            mdFile = fullfile(parentDir, classBaseName + ".md");
            
            [~,hForCodeBlock] = rawHelptextFor(qname);
            
            mkdirs(parentDir);
            fh = fopen2(mdFile, 'w', 'native', 'UTF-8');
            RAII.fh = onCleanup(@() fclose2(fh));
            p(true, fh);
            
            klass = meta.class.fromName(rec.qname);
            tklass = tableizeClassDefinition(klass);
            
            methItems = tklass.methods(~tklass.methods.isInherited,:);
            if ~this.opts.showHidden
                methItems(methItems.isHidden,:) = [];
            end
            propItems = tklass.properties(~tklass.properties.isInherited,:);
            if ~this.opts.showHidden
                propItems(propItems.isHidden,:) = [];
            end
            eventItems = tklass.events(~tklass.events.isInherited,:);
            if ~this.opts.showHidden
                eventItems(eventItems.isHidden,:) = [];
            end
            enumItems = tklass.events(~tklass.events.isInherited,:);
            if ~this.opts.showHidden
                enumItems(enumItems.isHidden,:) = [];
            end
            
            attribs = string([]);
            allClassAttribs = ["Hidden", "Sealed", "Abstract", "Enumeration", ...
                "ConstructOnLoad", "HandleCompatible", "RestrictsSubclassing"];
            allAttribs = allClassAttribs;
            for at = allAttribs
                if klass.(at)
                    attribs(end+1) = at;
                end
            end
            
            p("# %s - %s", classBaseName, pkg)
            p("")
            if ~isempty(attribs)
                p("%s", strjoin(attribs, ', '));
                p
            end
            % Inheritance tree
            function stepInhTree(klass, prefix)
                p("%s%s", prefix, klass.Name)
                for super = klass.SuperclassList(:)'
                    stepInhTree(super, prefix + "  ");
                end
            end
            p("```text")
            stepInhTree(klass, "")
            p("```")
            p
            
            if ~isempty(klass.Description)
                p("## Description")
                p(klass.Description)
                p
            end
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
                for iItem = 1:height(itemList)
                    rec = table2struct(itemList(iItem,:));
                    item = rec.item;
                    itemQname = klass.Name + "." + item.Name;
                    p("| [%s](#%s) | %s |", item.Name, itemQname, item.Description);
                end
                p
            end
            
            pContentsList("Properties", "Property", propItems);
            pContentsList("Methods", "Method", methItems);
            pContentsList("Events", "Events", eventItems);
            pContentsList("Enumerations", "Enumeration", enumItems);
            
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
            
            function [itemQname] = pItemStuff(rec)
                item = rec.item;
                itemQname = klass.Name + "." + item.Name;
                
                if isThisInherited(klass, item)
                    return
                end
                
                itemType = regexprep(class(item), '.*\.', '');
                switch itemType
                    case "class"
                        allAttribs = allClassAttribs;
                    case "method"
                        allAttribs = ["Static" "Abstract" "Sealed" ...
                            "ExplicitConversion" "Hidden"];
                    case "property"
                        allAttribs = ["Dependent" "Constant" "Abstract" ...
                            "Transient" "Hidden" "GetObservable" "SetObservable" ...
                            "AbortSet" "NonCopyable" "HasDefault"];
                    case "event"
                        allAttribs = ["Hidden"];
                    otherwise
                        allAttribs = string([]);
                end
                attrStrs = string([]);
                for attrName = allAttribs
                    if item.(attrName)
                        attrStrs(end+1) = attrName;
                    end
                end
                
                if itemType == "property"
                    hForCodeBlock = "No helptext available.";
                else
                    [~,hForCodeBlock] = rawHelptextFor(itemQname);
                end
                
                p('<a name="%s"></a>', itemQname)
                p("### %s", item.Name)
                p
                if ~isempty(attrStrs)
                    p("Attributes: %s", strjoin(attrStrs, ", "))
                    p
                end
                if itemType == "property"
                    if item.HasDefault
                        try
                            defaultValText = "`" + mat2str(item.DefaultValue) + "`";
                        catch
                            try
                                defaultValText = string(item.DefaultValue);
                            catch
                                defaultValText = "<unrepresentable>";
                            end
                        end
                        p("Default Value: %s", defaultValText);
                        p
                    end
                end
                if itemType == "method"
                    nouts = numel(item.OutputNames);
                    if nouts == 0
                        lhsStr = "";
                    elseif nouts == 1
                        lhsStr = sprintf("%s = ", item.OutputNames{1});
                    else
                        lhsStr = sprintf("[%s] = ", strjoin(item.OutputNames, ', '));
                    end
                    if item.Static
                        signatureStr = sprintf("%s%s.%s(%s)", lhsStr, classBaseName, item.Name, ...
                            strjoin(item.InputNames, ', '));
                    else
                        signatureStr = sprintf("%s%s(%s)", lhsStr, item.Name, ...
                            strjoin(item.InputNames, ', '));
                    end
                    p("Signature:")
                    p("```")
                    p(signatureStr)
                    p("```")
                    p
                end
                % These don't work because they're unimplemented as of
                % R2021a
                % p(item.Description)
                % p
                % p(item.DetailedDescription)
                % p
                p("Helptext:")
                p
                p("```text")
                p(hForCodeBlock)
                p("```")
                p
            end
            
            itemTbl = propItems;
            if ~isempty(itemTbl)
                p("## Properties")
                p
                for iItemInTbl = 1:height(itemTbl)
                    pItemStuff(table2struct(itemTbl(iItemInTbl,:)));
                end
                p
            end
            
            itemTbl = methItems;
            if ~isempty(itemTbl)
                p("## Methods")
                p
                for iItemInTbl = 1:height(itemTbl)
                    pItemStuff(table2struct(itemTbl(iItemInTbl,:)));
                end
                p
            end
            
            itemTbl = eventItems;
            if ~isempty(itemTbl)
                p("## Events")
                p
                for iItemInTbl = 1:height(itemTbl)
                    pItemStuff(table2struct(itemTbl(iItemInTbl,:)));
                end
                p
            end
            
            itemTbl = enumItems;
            if ~isempty(itemTbl)
                p("## Enumerations")
                p
                for iItemInTbl = 1:height(itemTbl)
                    pItemStuff(table2struct(itemTbl(iItemInTbl,:)));
                end
                p
            end
            
            
        end
        
    end
    
end

function [out, forCodeBlock] = rawHelptextFor(name)
raw = help(name); % Undocumented form of help
out = regexprep(raw, '(?<=^|\n)  ?', '');
% HACK: escaping of internal fenced code blocks
forCodeBlock = strrep(out, "```", "`` `");
end

function out = isThisInherited(klass, item)
out = item.DefiningClass ~= klass;
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

function out = tableizeClassDefinition(klass)
out = struct;
out.class = klass;

itemList = klass.PropertyList;
nItems = numel(itemList);
sz = [nItems 1];
isHidden = false(sz);
isInherited = false(sz);
for i = 1:numel(itemList)
    item = itemList(i);
    isHidden(i) = item.Hidden;
    isInherited(i) = isThisInherited(klass, item);
end
item = itemList;
out.properties = table(item, isHidden, isInherited);

itemList = klass.MethodList;
nItems = numel(itemList);
sz = [nItems 1];
isHidden = false(sz);
isInherited = false(sz);
isStatic = false(sz);
for i = 1:numel(itemList)
    item = itemList(i);
    isHidden(i) = item.Hidden;
    isInherited(i) = isThisInherited(klass, item);
    isStatic(i) = item.Static;
end
item = itemList;
out.methods = table(item, isHidden, isInherited);

itemList = klass.EventList;
nItems = numel(itemList);
sz = [nItems 1];
isHidden = false(sz);
isInherited = false(sz);
for i = 1:numel(itemList)
    item = itemList(i);
    isHidden(i) = item.Hidden;
    isInherited(i) = isThisInherited(klass, item);
end
item = itemList;
out.events = table(item, isHidden, isInherited);

itemList = klass.EnumerationMemberList;
nItems = numel(itemList);
sz = [nItems 1];
isHidden = false(sz);
isInherited = false(sz);
for i = 1:numel(itemList)
    item = itemList(i);
    isHidden(i) = item.Hidden;
    isInherited(i) = isThisInherited(klass, item);
end
item = itemList;
out.enumerations = table(item, isHidden, isInherited);

end


