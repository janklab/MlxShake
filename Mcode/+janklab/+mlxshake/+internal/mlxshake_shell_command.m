function mlxshake_shell_command(argsFile)
% Implements the mlxshake shell command program
arguments
    % Path to text file containing command line arguments to mlxshake
    argsFile (1,1) string
end

%#ok<*NBRAK>
%#ok<*AGROW>

% Parse arguments
if ~isfile(argsFile)
    bummer('Internal error: args file not found: "%s"', argsFile);
end
cmdArgs = string(myReadlines(argsFile));
optsWithArgs = [
    "format"
    "equations"
    ];
optsWithoutArgs = [
    "help"          
    "no-mention"
    ];

cmdOpts = janklab.mlxshake.internal.MlxShellCommandOpts;
iArg = 1;
iPositionalArg = 0;
while iArg <= numel(cmdArgs)
    arg = cmdArgs{iArg};
    if ~isempty(arg) && arg(1) == '-'
        optName = arg(3:end);
        optField = strrep(optName, '-', '');
        if ismember(optName, optsWithArgs)
            cmdOpts.(optField) = cmdArgs{iArg+1};
            iArg = iArg + 2;
        elseif ismember(optName, optsWithoutArgs)
            cmdOpts.(optField) = true;
            iArg = iArg + 1;
        else
            bummer('Invalid option: %s', arg);
        end
    else
        iPositionalArg = iPositionalArg + 1;
        switch iPositionalArg
            case 1
                cmdOpts.inFile = arg;
            case 2
                cmdOpts.outFile = arg;
            otherwise
                bummer('Too many positional arguments (%d)', iPositionalArg);
        end
        iArg = iArg + 1;
    end
end

% Handle command-only behavior

if cmdOpts.help
    usage = strjoin([
        "Usage: mlxshake <infile> [<outfile>] [--format <format>]"
        "           [--no-mention] [--help] [--equations (online|local)]"
        ], newline);
    fprintf(2, '\n%s\n\n', usage);
    return
end

% More arg handling

if ismissing(cmdOpts.inFile)
    bummer('infile is required');
end
if ~ismember(cmdOpts.format, janklab.mlxshake.MlxExportOptions.validFormats)
    bummer("Invalid format: '%s'. Valid formats are: %s", ...
        cmdOpts.format, strjoin(janklab.mlxshake.MlxExportOptions.validFormats, ", "));
end

% Do it!
opts = janklab.mlxshake.MlxExportOptions;
opts.format = cmdOpts.format;
opts.outFile = cmdOpts.outFile;
opts.addMention = ~cmdOpts.nomention;
switch cmdOpts.equations
    case "online"
        opts.grabEquationImages = false;
end

try
    janklab.mlxshake.exportlivescript(cmdOpts.inFile, opts);
catch err
    bummer('%s', err.message);
end

end

function bummer(fmt, varargin)
% Print an error message and exit with an error status
arguments
    fmt (1,:) char
end
arguments (Repeating)
    varargin
end
fprintf(2, ['mlxshake: Error: ' fmt '\n'], varargin{:});
exit(1);
end

function out = myReadlines(file)
out = string([]);
fid = fopen2(file);
RAII.fid = onCleanup(@() fclose2(fid));
while true
    line = fgetl(fid);
    if ~ischar(line)
        break
    end
    out(end+1) = line;
end
end