classdef (Abstract) ApirefGenerator < janklab.mlxshake.internal.MlxshakeBaseHandle
    % Generates API Reference doco from source code.
    
    %#ok<*AGROW>
    
    % Input knobs
    properties
        outDir (1,1) string
        inDirs (1,:) string
        opts (1,1) janklab.mlxshake.ApirefGenOptions
    end
    % State for generator run
    properties
        mfiles table
        packages table
    end
    
    methods (Abstract)
        
        generateForMyFormat(this)
        
    end
    
    methods (Static)
        
        function out = forFormat(format)
            % Construct an ApirefGenerator for a given format.
            arguments
                format (1,1) string
            end
            
            switch format
                case "html"
                    out = janklab.mlxshake.internal.ApirefHtmlGenerator;
                case "markdown"
                    out = janklab.mlxshake.internal.ApirefMarkdownGenerator;
                otherwise
                    error("Invalid format: '%s'", format);
            end
        end
        
    end
    
    methods
        
        function generate(this)
            % Generate the doco output.
            this.discover;
            rmrf(this.outDir);
            mkdir(this.outDir);
            this.generateForMyFormat;
        end
        
        function discover(this)
            % Discover source code files on the input paths.
            
            % { File, Package, Name, QName, IsInternal; ... }
            buf = cell(0, 5);
            
            function step(dirPath, pkg, isInternal)
                if isInternal && ~this.opts.doInternal
                    return
                end
                d = dir(dirPath);
                for i = 1:numel(d)
                    entry = d(i);
                    fileName = entry.name;
                    filePath = string(fullfile(entry.folder, entry.name));
                    if entry.isdir
                        if startsWith(fileName, '+')
                            dirPkgName = fileName(2:end);
                            if ~isvarname(dirPkgName)
                                continue
                            end
                            if pkg == ""
                                nextPkg = dirPkgName;                                
                            else
                                nextPkg = pkg + "." + dirPkgName;
                            end
                            nextPkgIsInternal = lower(fileName) == "+internal";
                            step(fullfile(dirPath, fileName), nextPkg, nextPkgIsInternal);
                        end
                    else
                        if endsWith(lower(fileName), '.m')
                            thingName = string(regexprep(fileName, '\.m$', '', 'ignorecase'));
                            if pkg == ""
                                qname = thingName;
                            else
                                qname = pkg + "." + thingName;
                            end
                            buf = [buf; {filePath, pkg, thingName, qname, isInternal}];
                        else
                            % Ignore
                        end
                    end
                end
            end
            
            for iDir = 1:numel(this.inDirs)
                inDir = this.inDirs(iDir);
                if ~isfolder(inDir)
                    error('File not found: %s', inDir);
                end
                step(inDir, "", false);
            end
            
            things = cell2table(buf, 'VariableNames', {'file', 'package', ...
                'name', 'qname', 'isInternal'});
            
            % Resolve things
            thingTypes = repmat(string(missing), size(things.file));
            for iThing = 1:height(things)
                rec = table2struct(things(iThing,:));
                [resolved, ~] = which(rec.qname);
                klass = meta.class.fromName(rec.qname);
                
                if ~isempty(klass)
                    type = "class";
                elseif lower(rec.name) == "contents"
                    % Special Contents.m handling
                    type = "contents";
                elseif ~isempty(resolved)
                    % It's a function or script, but not Contents
                    type = "function";
                else
                    error("Unable to resolve thing: '%s' from file '%s'", ...
                        rec.qname, rec.file);
                end
                thingTypes(iThing) = type;
            end
            things.type = categorical(thingTypes);
            
            this.mfiles = things;
            
            % Packages
            
            package = unique(this.mfiles.package);
            isInternal = false(size(package));
            missings = repmat(string(missing), size(package));
            dispName = missings;
            key = missings;
            for iPkg = 1:numel(package)
                pkg = package(iPkg);
                comps = strsplit(pkg, ".");
                isInternal(iPkg) = ismember("internal", lower(comps));
                if pkg == ""
                    pkgDisp = "<base>";
                    pkgKey = "_base_";
                else
                    pkgDisp = pkg;
                    pkgKey = strrep(pkg, '.', '_');
                end
                dispName(iPkg) = pkgDisp;
                key(iPkg) = pkgKey;
            end
            this.packages = table(package, isInternal, dispName, key);
        end
        
    end
    
end

