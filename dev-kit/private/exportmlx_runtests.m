function exportmlx_runtests
% Run the tests for this library.

% We currently do not have real tests. Just regenerate the doco and examples
% as a smoke test.
% This is not a good test, because it alters the library's source code as
% part of its operation. Tests should not do that. I'm leaving it in place
% for now so we at least have _something_ to run in CI.
% TODO: FIXME: Better, safer tests.
% What we should actually do is something like:
%   - Check all the .tex files for examples and docs/ in to the source
%     tree, because we can't do the .mlx to .tex export in a CI environment.
%   - Export from .tex to .md into a temporary directory, to not pollute
%     the source tree.
%   - Do some basic validation on those .md files.

% Actually, don't do that; it causes a bunch of CI failures.
% exportmlx_gendocs;

% Instead, just see if the library is loaded
fprintf('ExportMlx version is: %s\n', janklab.exportmlx.globals.version)
fprintf('ExportMlx distroot is: %s\n', janklab.exportmlx.globals.distroot)

fprintf('Library is loaded. Looks like nothing is seriously broken.\n')
fprintf('Tests finished.\n')

end