function out = system2(cmd)
% A version of system that raises an error on failure
if nargout == 0
    janklab.exportmlx.internal.util.system2(cmd);
else
    out = janklab.exportmlx.internal.util.system2(cmd);
end
end