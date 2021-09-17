classdef MlxshakeBaseHandle < handle
  % This class is a trick to support automatic library initialization.
  %
  % To use it, have all your classes that depend on the library being
  % initialized inherit from this or ExportmlxBase.
  %
  % See also:
  % MLXSHAKEBASE
  
  properties (Constant, Hidden)
    initializer = janklab.mlxshake.internal.LibraryInitializer;
  end
  
end

