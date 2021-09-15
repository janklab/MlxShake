function genapiref(outDir, inDirs, opts)
% Generate API Reference documentation from source code.
%
% genapiref(outDir, inDirs, opts)
%
% This is a destructive operation. It will completely remove the existing outDir
% and all its contents, replacing it with newly generated stuff.

arguments
    outDir (1,1) string
    inDirs (1,:) string
    opts (1,1) janklab.mlxshake.ApirefGenOpts = janklab.mlxshake.ApirefGenOpts
end

genner = janklab.mlxshake.internal.ApirefGenerator.forFormat(opts.format);
genner.outDir = outDir;
genner.inDirs = inDirs;
genner.opts = opts;

genner.generate;

end