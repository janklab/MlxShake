# errorj - janklab.mlxshake.internal.logger

Log an ERROR level message from caller, using SLF4J style formatting.

logger.errorj(msg, varargin)

This accepts a message with SLF4J style formatting, using '{}' as placeholders for
values to be interpolated into the message.

Examples:

logger.errorj('Some message. value1={} value2={}', 'foo', 42);



