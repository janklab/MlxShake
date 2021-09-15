# Logger - janklab.mlxshake.internal.logger

## Description


## Helptext

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
| [jLogger](#janklab.mlxshake.internal.logger.Logger.jLogger) |  |
| [name](#janklab.mlxshake.internal.logger.Logger.name) |  |
| [enabledLevels](#janklab.mlxshake.internal.logger.Logger.enabledLevels) |  |

### Methods

| Method | Description |
| -------- | ----------- |
| [getLogger](#janklab.mlxshake.internal.logger.Logger.getLogger) |  |
| [listEnabledLevels](#janklab.mlxshake.internal.logger.Logger.listEnabledLevels) |  |
| [isTraceEnabled](#janklab.mlxshake.internal.logger.Logger.isTraceEnabled) |  |
| [isDebugEnabled](#janklab.mlxshake.internal.logger.Logger.isDebugEnabled) |  |
| [isInfoEnabled](#janklab.mlxshake.internal.logger.Logger.isInfoEnabled) |  |
| [isWarnEnabled](#janklab.mlxshake.internal.logger.Logger.isWarnEnabled) |  |
| [isErrorEnabled](#janklab.mlxshake.internal.logger.Logger.isErrorEnabled) |  |
| [tracej](#janklab.mlxshake.internal.logger.Logger.tracej) |  |
| [debugj](#janklab.mlxshake.internal.logger.Logger.debugj) |  |
| [infoj](#janklab.mlxshake.internal.logger.Logger.infoj) |  |
| [warnj](#janklab.mlxshake.internal.logger.Logger.warnj) |  |
| [errorj](#janklab.mlxshake.internal.logger.Logger.errorj) |  |
| [trace](#janklab.mlxshake.internal.logger.Logger.trace) |  |
| [debug](#janklab.mlxshake.internal.logger.Logger.debug) |  |
| [info](#janklab.mlxshake.internal.logger.Logger.info) |  |
| [warn](#janklab.mlxshake.internal.logger.Logger.warn) |  |
| [error](#janklab.mlxshake.internal.logger.Logger.error) |  |
| [dispstrs](#janklab.mlxshake.internal.logger.Logger.dispstrs) |  |
| [dispstr](#janklab.mlxshake.internal.logger.Logger.dispstr) |  |
| [disp](#janklab.mlxshake.internal.logger.Logger.disp) |  |
| [Logger](#janklab.mlxshake.internal.logger.Logger.Logger) |  |
| [empty](#janklab.mlxshake.internal.logger.Logger.empty) | Returns an empty object array of the given size |

## Properties

<a name="janklab.mlxshake.internal.logger.Logger.jLogger"></a>
### jLogger






```text
No helptext available.
```

<a name="janklab.mlxshake.internal.logger.Logger.name"></a>
### name






```text
No helptext available.
```

<a name="janklab.mlxshake.internal.logger.Logger.enabledLevels"></a>
### enabledLevels






```text
No helptext available.
```


## Methods

<a name="janklab.mlxshake.internal.logger.Logger.getLogger"></a>
### getLogger






```text
Gets the named Logger

```

<a name="janklab.mlxshake.internal.logger.Logger.listEnabledLevels"></a>
### listEnabledLevels






```text
List the levels that are enabled for this logger.

```

<a name="janklab.mlxshake.internal.logger.Logger.isTraceEnabled"></a>
### isTraceEnabled






```text
True if TRACE level logging is enabled for this logger.

```

<a name="janklab.mlxshake.internal.logger.Logger.isDebugEnabled"></a>
### isDebugEnabled






```text
True if DEBUG level logging is enabled for this logger.

```

<a name="janklab.mlxshake.internal.logger.Logger.isInfoEnabled"></a>
### isInfoEnabled






```text
True if INFO level logging is enabled for this logger.

```

<a name="janklab.mlxshake.internal.logger.Logger.isWarnEnabled"></a>
### isWarnEnabled






```text
True if WARN level logging is enabled for this logger.

```

<a name="janklab.mlxshake.internal.logger.Logger.isErrorEnabled"></a>
### isErrorEnabled






```text
True if ERROR level logging is enabled for this logger.

```

<a name="janklab.mlxshake.internal.logger.Logger.tracej"></a>
### tracej






```text
Log a message at the TRACE level, using SLFJ formatting.

```

<a name="janklab.mlxshake.internal.logger.Logger.debugj"></a>
### debugj






```text
Log a message at the DEBUG level, using SLFJ formatting.

```

<a name="janklab.mlxshake.internal.logger.Logger.infoj"></a>
### infoj






```text
Log a message at the INFO level, using SLFJ formatting.

```

<a name="janklab.mlxshake.internal.logger.Logger.warnj"></a>
### warnj






```text
Log a message at the WARN level, using SLFJ formatting.

```

<a name="janklab.mlxshake.internal.logger.Logger.errorj"></a>
### errorj






```text
Log a message at the ERROR level, using SLFJ formatting.

```

<a name="janklab.mlxshake.internal.logger.Logger.trace"></a>
### trace






```text
Log a message at the TRACE level.

```

<a name="janklab.mlxshake.internal.logger.Logger.debug"></a>
### debug






```text
Log a message at the DEBUG level.

```

<a name="janklab.mlxshake.internal.logger.Logger.info"></a>
### info






```text
Log a message at the INFO level.

```

<a name="janklab.mlxshake.internal.logger.Logger.warn"></a>
### warn






```text
Log a message at the WARN level.

```

<a name="janklab.mlxshake.internal.logger.Logger.error"></a>
### error






```text
Log a message at the ERROR level.

```

<a name="janklab.mlxshake.internal.logger.Logger.dispstrs"></a>
### dispstrs






```text
DISPSTRS Custom object display strings.

```

<a name="janklab.mlxshake.internal.logger.Logger.dispstr"></a>
### dispstr






```text
DISPSTR Custom object display string.

```

<a name="janklab.mlxshake.internal.logger.Logger.disp"></a>
### disp






```text
DISP Custom object display.

```

<a name="janklab.mlxshake.internal.logger.Logger.Logger"></a>
### Logger






```text
LOGGER Build a new logger object around an SLF4J Logger object.

Generally, you shouldn't call this. Use logger.Logger.getLogger() instead.

```

<a name="janklab.mlxshake.internal.logger.Logger.empty"></a>
### empty


Returns an empty object array of the given size



```text
Returns an empty object array of the given size
```


