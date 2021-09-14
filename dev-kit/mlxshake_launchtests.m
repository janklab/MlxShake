function mlxshake_launchtests
% Entry point for running full test suite from command line or automation
%
% Loads the library, runs the tests, and prints results. Does not exit Matlab.

load_mlxshake(["dev-kit" "examples"])

mlxshake_runtests;

end
