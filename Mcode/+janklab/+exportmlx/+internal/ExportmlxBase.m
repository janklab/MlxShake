classdef ExportmlxBase
  % This class is a trick to support automatic library initialization
  %
  % To use it, have all your classes that depend on the library being
  % initialized inherit from this or ExportmlxBaseHandle.
  %
  % See also:
  % EXPORTMLXBASEHANDLE
  
  properties (Constant, Hidden)
    initializer = janklab.exportmlx.internal.LibraryInitializer;
  end
  
end

