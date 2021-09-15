# janklab.mlxshake.internal.logger.Logger

```text
LOGGER Main entry point through which logging happens

The Logger class provides method calls for performing logging, and the ability
to look up loggers by name. This is the main entry point through which all
janklab.mlxshake.logger logging happens.

Usually you don't need to interact with this class directly, but can just call
one of the error(), warn(), info(), debug(), or trace() functions in the logger
namespace. Those will log messages using the calling class's name as the name
of the logger. Also, don't call the constructor for this class. Use the static
getLogger() method instead.

Use this class directly if you want to customize the names of the loggers to
which logging is directed.

Each of the logging methods - error(), warn(), info(), debug(), and
trace() - takes a sprintf()-style signature, with a format string as
the first argument, and substitution values as the remaining
arguments.
   janklab.mlxshake.internal.logger.info(format, varargin)
You can also insert an MException object at the beginning of the
argument list to have its message and stack trace included in the log
message.
   janklab.mlxshake.internal.logger.warn(exception, format, varargin)

See also:
janklab.mlxshake.internal.logger.error
janklab.mlxshake.internal.logger.warn
janklab.mlxshake.internal.logger.info
janklab.mlxshake.internal.logger.debug
janklab.mlxshake.internal.logger.trace

Examples:

log = mlxshake.logger.Logger.getLogger('foo.bar.FooBar');
log.info('Hello, world! Running on Matlab 
```

## Class Contents

### Properties

| Property | Description |
| -------- | ----------- |
| `jLogger` | ??? |
| `name` | ??? |
| `enabledLevels` | ??? |

### Methods

| Method | Description |
| -------- | ----------- |
| `getLogger` | ??? |
| `listEnabledLevels` | ??? |
| `isTraceEnabled` | ??? |
| `isDebugEnabled` | ??? |
| `isInfoEnabled` | ??? |
| `isWarnEnabled` | ??? |
| `isErrorEnabled` | ??? |
| `tracej` | ??? |
| `debugj` | ??? |
| `infoj` | ??? |
| `warnj` | ??? |
| `errorj` | ??? |
| `trace` | ??? |
| `debug` | ??? |
| `info` | ??? |
| `warn` | ??? |
| `error` | ??? |
| `dispstrs` | ??? |
| `dispstr` | ??? |
| `disp` | ??? |
| `Logger` | ??? |
| `empty` | ??? |

## Methods

### `getLogger`

```text

```

### `listEnabledLevels`

```text

```

### `isTraceEnabled`

```text

```

### `isDebugEnabled`

```text

```

### `isInfoEnabled`

```text

```

### `isWarnEnabled`

```text

```

### `isErrorEnabled`

```text

```

### `tracej`

```text
Log a TRACE level message from caller, using SLF4J style formatting.

logger.tracej(msg, varargin)

This accepts a message with SLF4J style formatting, using '{}' as placeholders for
values to be interpolated into the message.

Examples:

logger.tracej('Some message. value1={} value2={}', 'foo', 42);

```

### `debugj`

```text
Log a DEBUG level message from caller, using SLF4J style formatting.

logger.debug(msg, varargin)

This accepts a message with SLF4J style formatting, using '{}' as placeholders for
values to be interpolated into the message.

Examples:

logger.debugj('Some message. value1={} value2={}', 'foo', 42);

```

### `infoj`

```text
Log an INFO level message from caller, using SLF4J style formatting.

logger.infoj(msg, varargin)

This accepts a message with SLF4J style formatting, using '{}' as placeholders for
values to be interpolated into the message.

Examples:

logger.infoj('Some message. value1={} value2={}', 'foo', 42);

```

### `warnj`

```text
Log a WARN level message from caller, using SLF4J style formatting.

logger.warnj(msg, varargin)

This accepts a message with SLF4J style formatting, using '{}' as placeholders for
values to be interpolated into the message.

Examples:

logger.warnj('Some message. value1={} value2={}', 'foo', 42);

```

### `errorj`

```text
Log an ERROR level message from caller, using SLF4J style formatting.

logger.errorj(msg, varargin)

This accepts a message with SLF4J style formatting, using '{}' as placeholders for
values to be interpolated into the message.

Examples:

logger.errorj('Some message. value1={} value2={}', 'foo', 42);

```

### `trace`

```text
Log a TRACE level message from caller, with printf style formatting.

logger.trace(msg, varargin)
logger.trace(exception, msg, varargin)

This accepts a message with printf style formatting, using '```

### `debug`

```text
Log a DEBUG level message from caller, with printf style formatting.

logger.debug(msg, varargin)
logger.debug(exception, msg, varargin)

This accepts a message with printf style formatting, using '```

### `info`

```text
Log an INFO level message from caller, with printf style formatting.

logger.info(msg, varargin)
logger.info(exception, msg, varargin)

This accepts a message with printf style formatting, using '```

### `warn`

```text
Log a WARN level message from caller, with printf style formatting.

logger.warn(msg, varargin)
logger.warn(exception, msg, varargin)

This accepts a message with printf style formatting, using '```

### `error`

```text
Log an ERROR level message from caller, with printf style formatting.

logger.error(msg, varargin)
logger.error(exception, msg, varargin)

This accepts a message with printf style formatting, using '```

### `dispstrs`

```text

```

### `dispstr`

```text

```

### `disp`

```text

```

### `Logger`

```text
LOGGER Main entry point through which logging happens

The Logger class provides method calls for performing logging, and the ability
to look up loggers by name. This is the main entry point through which all
janklab.mlxshake.logger logging happens.

Usually you don't need to interact with this class directly, but can just call
one of the error(), warn(), info(), debug(), or trace() functions in the logger
namespace. Those will log messages using the calling class's name as the name
of the logger. Also, don't call the constructor for this class. Use the static
getLogger() method instead.

Use this class directly if you want to customize the names of the loggers to
which logging is directed.

Each of the logging methods - error(), warn(), info(), debug(), and
trace() - takes a sprintf()-style signature, with a format string as
the first argument, and substitution values as the remaining
arguments.
   janklab.mlxshake.internal.logger.info(format, varargin)
You can also insert an MException object at the beginning of the
argument list to have its message and stack trace included in the log
message.
   janklab.mlxshake.internal.logger.warn(exception, format, varargin)

See also:
janklab.mlxshake.internal.logger.error
janklab.mlxshake.internal.logger.warn
janklab.mlxshake.internal.logger.info
janklab.mlxshake.internal.logger.debug
janklab.mlxshake.internal.logger.trace

Examples:

log = mlxshake.logger.Logger.getLogger('foo.bar.FooBar');
log.info('Hello, world! Running on Matlab ```

### `empty`

```text

```


