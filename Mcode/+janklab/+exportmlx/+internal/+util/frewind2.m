function frewind2(fid)
% A version of frewind that errors on failure
janklab.exportmlx.internal.util.fseek(fid, 0, 'bof');
end