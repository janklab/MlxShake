# janklab.mlxshake.internal.logger.tracej

```text
Log a TRACE level message from caller, using SLF4J style formatting.

logger.tracej(msg, varargin)

This accepts a message with SLF4J style formatting, using '{}' as placeholders for
values to be interpolated into the message.

Examples:

logger.tracej('Some message. value1={} value2={}', 'foo', 42);


```

