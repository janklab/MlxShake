function initializePackage
% Basic package initialization
%
% This should *only* do basic library initialization involving paths and dependency
% loading and the like. It should *not* discover initial values for library settings;
% that's done in mlxshake.Settings.discover. It has to be that way so the package
% settings state can handle a `clear classes` gracefully.

% Do not re-initialize if already initialized
if janklab.mlxshake.internal.misc.getpackageappdata('initialized')
    return
end

% Initialize library's internal logging

janklab.mlxshake.internal.logger.Log4jConfigurator.configureBasicConsoleLogging('minimal');

% Put any other custom library initialization code here

% Mark library as initialized

janklab.mlxshake.internal.misc.setpackageappdata('initialized', true);

end
