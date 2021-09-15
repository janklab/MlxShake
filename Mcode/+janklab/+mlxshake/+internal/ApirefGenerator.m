classdef (Abstract) ApirefGenerator < janklab.mlxshake.internal.MlxshakeBaseHandle
    % Generates API Reference doco from source code.
    
    %#ok<*AGROW>
    
    % Input knobs
    properties
        outDir (1,1) string
        inDirs (1,:) string
        opts (1,1) janklab.mlxshake.ApirefGenOpts
    end
    % State for generator run
    properties
        mfiles table
    end
    
    methods (Abstract)
        
        generateForMyFormat(this)
        
    end
    
    methods (Static)
        
        function out = forFormat(format)
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
            this.discover;
            rmrf(this.outDir);
            mkdir(this.outDir);
            this.generateForMyFormat;
        end
        
        function discover(this)
            % { File, Package, Name, QName; ... }
            buf = cell(0, 4);
            
            function step(dirPath, pkg)
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
                            if lower(fileName) == "+internal" && ~this.opts.doInternal
                                continue
                            end
                            if pkg == ""
                                nextPkg = dirPkgName;                                
                            else
                                nextPkg = pkg + "." + dirPkgName;
                            end
                            step(fullfile(dirPath, fileName), nextPkg);
                        end
                    else
                        if endsWith(lower(fileName), '.m')
                            thingName = string(regexprep(fileName, '\.m$', '', 'ignorecase'));
                            if pkg == ""
                                qname = thingName;
                            else
                                qname = pkg + "." + thingName;
                            end
                            buf = [buf; {filePath, pkg, thingName, qname}];
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
                step(inDir, "");
            end
            
            this.mfiles = cell2table(buf, 'VariableNames', {'file', 'package', ...
                'name', 'qname'});
        end
        
    end
    
end

