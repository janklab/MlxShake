# Logger - janklab.mlxshake.internal.logger

```text
janklab.mlxshake.internal.logger.Logger
```

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
| [listEnabledLevels](#janklab.mlxshake.internal.logger.Logger.listEnabledLevels) | List the levels that are enabled for this logger. |
| [isTraceEnabled](#janklab.mlxshake.internal.logger.Logger.isTraceEnabled) | True if TRACE level logging is enabled for this logger. |
| [isDebugEnabled](#janklab.mlxshake.internal.logger.Logger.isDebugEnabled) | True if DEBUG level logging is enabled for this logger. |
| [isInfoEnabled](#janklab.mlxshake.internal.logger.Logger.isInfoEnabled) | True if INFO level logging is enabled for this logger. |
| [isWarnEnabled](#janklab.mlxshake.internal.logger.Logger.isWarnEnabled) | True if WARN level logging is enabled for this logger. |
| [isErrorEnabled](#janklab.mlxshake.internal.logger.Logger.isErrorEnabled) | True if ERROR level logging is enabled for this logger. |
| [tracej](#janklab.mlxshake.internal.logger.Logger.tracej) | Log a message at the TRACE level, using SLFJ formatting. |
| [debugj](#janklab.mlxshake.internal.logger.Logger.debugj) | Log a message at the DEBUG level, using SLFJ formatting. |
| [infoj](#janklab.mlxshake.internal.logger.Logger.infoj) | Log a message at the INFO level, using SLFJ formatting. |
| [warnj](#janklab.mlxshake.internal.logger.Logger.warnj) | Log a message at the WARN level, using SLFJ formatting. |
| [errorj](#janklab.mlxshake.internal.logger.Logger.errorj) | Log a message at the ERROR level, using SLFJ formatting. |
| [trace](#janklab.mlxshake.internal.logger.Logger.trace) | Log a message at the TRACE level. |
| [debug](#janklab.mlxshake.internal.logger.Logger.debug) | Log a message at the DEBUG level. |
| [info](#janklab.mlxshake.internal.logger.Logger.info) | Log a message at the INFO level. |
| [warn](#janklab.mlxshake.internal.logger.Logger.warn) | Log a message at the WARN level. |
| [error](#janklab.mlxshake.internal.logger.Logger.error) | Log a message at the ERROR level. |
| [dispstrs](#janklab.mlxshake.internal.logger.Logger.dispstrs) | DISPSTRS Custom object display strings. |
| [dispstr](#janklab.mlxshake.internal.logger.Logger.dispstr) | DISPSTR Custom object display string. |
| [disp](#janklab.mlxshake.internal.logger.Logger.disp) | DISP Custom object display. |
| [Logger](#janklab.mlxshake.internal.logger.Logger.Logger) | Constructor. |

## Properties

<a name="janklab.mlxshake.internal.logger.Logger.jLogger"></a>
### jLogger

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.internal.logger.Logger.name"></a>
### name

Attributes: Dependent, NonCopyable

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.internal.logger.Logger.enabledLevels"></a>
### enabledLevels

Attributes: Dependent, NonCopyable

Helptext:

```text
No helptext available.
```


## Methods

<a name="janklab.mlxshake.internal.logger.Logger.getLogger"></a>
### getLogger

Attributes: Static

Signature:
```
out = Logger.getLogger(identifier)
```

Helptext:

```text
Gets the named Logger

```

<a name="janklab.mlxshake.internal.logger.Logger.listEnabledLevels"></a>
### listEnabledLevels

Signature:
```
out = listEnabledLevels(this)
```

Helptext:

```text
List the levels that are enabled for this logger.

```

<a name="janklab.mlxshake.internal.logger.Logger.isTraceEnabled"></a>
### isTraceEnabled

Signature:
```
out = isTraceEnabled(this)
```

Helptext:

```text
True if TRACE level logging is enabled for this logger.

```

<a name="janklab.mlxshake.internal.logger.Logger.isDebugEnabled"></a>
### isDebugEnabled

Signature:
```
out = isDebugEnabled(this)
```

Helptext:

```text
True if DEBUG level logging is enabled for this logger.

```

<a name="janklab.mlxshake.internal.logger.Logger.isInfoEnabled"></a>
### isInfoEnabled

Signature:
```
out = isInfoEnabled(this)
```

Helptext:

```text
True if INFO level logging is enabled for this logger.

```

<a name="janklab.mlxshake.internal.logger.Logger.isWarnEnabled"></a>
### isWarnEnabled

Signature:
```
out = isWarnEnabled(this)
```

Helptext:

```text
True if WARN level logging is enabled for this logger.

```

<a name="janklab.mlxshake.internal.logger.Logger.isErrorEnabled"></a>
### isErrorEnabled

Signature:
```
out = isErrorEnabled(this)
```

Helptext:

```text
True if ERROR level logging is enabled for this logger.

```

<a name="janklab.mlxshake.internal.logger.Logger.tracej"></a>
### tracej

Signature:
```
tracej(this, msg, varargin)
```

Helptext:

```text
Log a message at the TRACE level, using SLFJ formatting.

```

<a name="janklab.mlxshake.internal.logger.Logger.debugj"></a>
### debugj

Signature:
```
debugj(this, msg, varargin)
```

Helptext:

```text
Log a message at the DEBUG level, using SLFJ formatting.

```

<a name="janklab.mlxshake.internal.logger.Logger.infoj"></a>
### infoj

Signature:
```
infoj(this, msg, varargin)
```

Helptext:

```text
Log a message at the INFO level, using SLFJ formatting.

```

<a name="janklab.mlxshake.internal.logger.Logger.warnj"></a>
### warnj

Signature:
```
warnj(this, msg, varargin)
```

Helptext:

```text
Log a message at the WARN level, using SLFJ formatting.

```

<a name="janklab.mlxshake.internal.logger.Logger.errorj"></a>
### errorj

Signature:
```
errorj(this, msg, varargin)
```

Helptext:

```text
Log a message at the ERROR level, using SLFJ formatting.

```

<a name="janklab.mlxshake.internal.logger.Logger.trace"></a>
### trace

Signature:
```
trace(this, msg, varargin)
```

Helptext:

```text
Log a message at the TRACE level.

```

<a name="janklab.mlxshake.internal.logger.Logger.debug"></a>
### debug

Signature:
```
debug(this, msg, varargin)
```

Helptext:

```text
Log a message at the DEBUG level.

```

<a name="janklab.mlxshake.internal.logger.Logger.info"></a>
### info

Signature:
```
info(this, msg, varargin)
```

Helptext:

```text
Log a message at the INFO level.

```

<a name="janklab.mlxshake.internal.logger.Logger.warn"></a>
### warn

Signature:
```
warn(this, msg, varargin)
```

Helptext:

```text
Log a message at the WARN level.

```

<a name="janklab.mlxshake.internal.logger.Logger.error"></a>
### error

Signature:
```
error(this, msg, varargin)
```

Helptext:

```text
Log a message at the ERROR level.

```

<a name="janklab.mlxshake.internal.logger.Logger.dispstrs"></a>
### dispstrs

Signature:
```
out = dispstrs(this)
```

Helptext:

```text
DISPSTRS Custom object display strings.

```

<a name="janklab.mlxshake.internal.logger.Logger.dispstr"></a>
### dispstr

Signature:
```
out = dispstr(this)
```

Helptext:

```text
DISPSTR Custom object display string.

```

<a name="janklab.mlxshake.internal.logger.Logger.disp"></a>
### disp

Signature:
```
disp(this)
```

Helptext:

```text
DISP Custom object display.

```

<a name="janklab.mlxshake.internal.logger.Logger.Logger"></a>
### Logger

Signature:
```
this = Logger(jLogger)
```

Helptext:

```text
LOGGER Build a new logger object around an SLF4J Logger object.

Generally, you shouldn't call this. Use logger.Logger.getLogger() instead.

  Documentation for janklab.mlxshake.internal.logger.Logger/Logger
     doc janklab.mlxshake.internal.logger.Logger


```


