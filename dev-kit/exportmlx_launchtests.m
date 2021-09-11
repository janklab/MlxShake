function exportmlx_launchtests
% Entry point for running full test suite from command line or automation

rootdir = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(rootdir, 'Mcode'))
addpath(fullfile(rootdir, 'dev-kit'))

% We currently do not have real tests. Just regenerate the doco and examples
% as a smoke test.

exportmlx_gendoco;

fprintf('Doco generation succeeded. Looks like nothing is seriously broken.\n')
fprintf('Tests finished.\n')

end
