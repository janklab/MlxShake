function frewind2(fid)
% A version of frewind that errors on failure
exportmlx.internal.util.fseek(fid, 0, 'bof');
end