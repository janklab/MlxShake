function exportmlx_runtests
% Run the tests for this library.

% We currently do not have real tests. Just regenerate the doco and examples
% as a smoke test.
% This is not a good test, because it alters the library's source code as
% part of its operation. Tests should not do that. I'm leaving it in place
% for now so we at least have _something_ to run in CI.
% TODO: FIXME: Better, safer tests.

exportmlx_gendocs;

fprintf('Doco generation succeeded. Looks like nothing is seriously broken.\n')
fprintf('Tests finished.\n')

end