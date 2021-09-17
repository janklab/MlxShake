# initializePackage - janklab.mlxshake.internal

Basic package initialization

This should *only* do basic library initialization involving paths and dependency
loading and the like. It should *not* discover initial values for library settings;
that's done in mlxshake.Settings.discover. It has to be that way so the package
settings state can handle a `clear classes` gracefully.



