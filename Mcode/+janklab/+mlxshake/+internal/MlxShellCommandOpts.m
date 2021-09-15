classdef MlxShellCommandOpts
    % Options to the mlxshake shell command
    
    properties
        inFile (1,1) string = missing
        outFile (1,1) string = missing
        format (1,1) string = "auto"
        help (1,1) logical = false
        nomention (1,1) logical = false
        equations (1,1) string = missing
    end
    
end

