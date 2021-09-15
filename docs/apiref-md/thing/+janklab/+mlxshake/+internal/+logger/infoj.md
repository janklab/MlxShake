# infoj - janklab.mlxshake.internal.logger

```text
Log an INFO level message from caller, using SLF4J style formatting.

logger.infoj(msg, varargin)

This accepts a message with SLF4J style formatting, using '{}' as placeholders for
values to be interpolated into the message.

Examples:

logger.infoj('Some message. value1={} value2={}', 'foo', 42);


```
