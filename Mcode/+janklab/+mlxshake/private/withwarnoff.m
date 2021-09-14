function out = withwarnoff(warningId)
% Temporarily disable warnings
arguments
  warningId string
end
out = janklab.mlxshake.internal.util.withwarnoff(warningId);
end
