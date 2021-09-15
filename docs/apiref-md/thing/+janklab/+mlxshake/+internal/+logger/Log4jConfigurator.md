# Log4jConfigurator - janklab.mlxshake.internal.logger

```text
janklab.mlxshake.internal.logger.Log4jConfigurator
```

## Helptext

```text
A configurator for log4j

This class configures the logging setup for Matlab/SLF4M logging. It
configures the log4j library that SLF4M logging sits on top of. (We use log4j
because it ships with Matlab.)

This class is provided as a convenience. You can also configure SLF4M logging
by directly configuring log4j using its normal Java interface.

SLF4M does not automatically configure log4j. You must either call a
configureXxx method on this class or configure log4j directly yourself to get
logging to work. Otherwise, you may get warnings like this at the console:

  log4j:WARN No appenders could be found for logger (unknown).
  log4j:WARN Please initialize the log4j system properly.

If that happens, it means you need to call
logger.Log4jConfigurator.configureBasicConsoleLogging.

This also provides a log4j configuration GUI that you can launch with
`logger.Log4jConfigurator.showGui`.

Examples:

mlxshake.logger.Log4jConfigurator.configureBasicConsoleLogging

mlxshake.logger.Log4jConfigurator.setLevels({'root','DEBUG'});

mlxshake.logger.Log4jConfigurator.setLevels({
    'root'    'INFO'
    'net.apjanke.logger.swing'  'DEBUG'
    });

mlxshake.logger.Log4jConfigurator.prettyPrintLogConfiguration


```

## Class Contents

### Methods

| Method | Description |
| -------- | ----------- |
| [prettyPrintLogConfiguration](#janklab.mlxshake.internal.logger.Log4jConfigurator.prettyPrintLogConfiguration) |  |
| [setLevels](#janklab.mlxshake.internal.logger.Log4jConfigurator.setLevels) |  |
| [getLog4jLevel](#janklab.mlxshake.internal.logger.Log4jConfigurator.getLog4jLevel) |  |
| [setRootAppenderPattern](#janklab.mlxshake.internal.logger.Log4jConfigurator.setRootAppenderPattern) |  |
| [configureBasicConsoleLogging](#janklab.mlxshake.internal.logger.Log4jConfigurator.configureBasicConsoleLogging) |  |
| [Log4jConfigurator](#janklab.mlxshake.internal.logger.Log4jConfigurator.Log4jConfigurator) |  |

## Methods

<a name="janklab.mlxshake.internal.logger.Log4jConfigurator.prettyPrintLogConfiguration"></a>
### prettyPrintLogConfiguration

Attributes: Static

Signature:
```
Log4jConfigurator.prettyPrintLogConfiguration(verbose)
```

Helptext:

```text
Displays the current log configuration to the console

mlxshake.logger.Log4jConfigurator.prettyPrintLogConfiguration()

```

<a name="janklab.mlxshake.internal.logger.Log4jConfigurator.setLevels"></a>
### setLevels

Attributes: Static

Signature:
```
Log4jConfigurator.setLevels(levels)
```

Helptext:

```text
Set the logging levels for multiple loggers

mlxshake.logger.Log4jConfigurator.setLevels(levels)

This is a convenience method for setting the logging levels for multiple
loggers.

The levels input is an n-by-2 cellstr with logger names in column 1 and
level names in column 2.

Examples:

mlxshake.logger.Log4jConfigurator.setLevels({'root','DEBUG'});

mlxshake.logger.Log4jConfigurator.setLevels({
    'root'    'INFO'
    'net.apjanke.logger.swing'  'DEBUG'
    });

```

<a name="janklab.mlxshake.internal.logger.Log4jConfigurator.getLog4jLevel"></a>
### getLog4jLevel

Attributes: Static

Signature:
```
out = Log4jConfigurator.getLog4jLevel(levelName)
```

Helptext:

```text
Gets the log4j Level enum for a named level

```

<a name="janklab.mlxshake.internal.logger.Log4jConfigurator.setRootAppenderPattern"></a>
### setRootAppenderPattern

Attributes: Static

Signature:
```
Log4jConfigurator.setRootAppenderPattern(pattern)
```

Helptext:

```text
Sets the pattern on the root appender

This is just a convenience method. Assumes there is a single
appender on the root logger.

```

<a name="janklab.mlxshake.internal.logger.Log4jConfigurator.configureBasicConsoleLogging"></a>
### configureBasicConsoleLogging

Attributes: Static

Signature:
```
Log4jConfigurator.configureBasicConsoleLogging(varargin)
```

Helptext:

```text
Configures log4j to do basic logging to the console

This sets up a basic log4j configuration, with log output going to the
console, and the root logger set to the INFO level.

This method can safely be called multiple times. If there's already an
appender on the root logger (indicating logging has already been
configured), it silently does nothing.

```

<a name="janklab.mlxshake.internal.logger.Log4jConfigurator.Log4jConfigurator"></a>
### Log4jConfigurator

Signature:
```
obj = Log4jConfigurator()
```

Helptext:

```text
A configurator for log4j

This class configures the logging setup for Matlab/SLF4M logging. It
configures the log4j library that SLF4M logging sits on top of. (We use log4j
because it ships with Matlab.)

This class is provided as a convenience. You can also configure SLF4M logging
by directly configuring log4j using its normal Java interface.

SLF4M does not automatically configure log4j. You must either call a
configureXxx method on this class or configure log4j directly yourself to get
logging to work. Otherwise, you may get warnings like this at the console:

  log4j:WARN No appenders could be found for logger (unknown).
  log4j:WARN Please initialize the log4j system properly.

If that happens, it means you need to call
logger.Log4jConfigurator.configureBasicConsoleLogging.

This also provides a log4j configuration GUI that you can launch with
`logger.Log4jConfigurator.showGui`.

Examples:

mlxshake.logger.Log4jConfigurator.configureBasicConsoleLogging

mlxshake.logger.Log4jConfigurator.setLevels({'root','DEBUG'});

mlxshake.logger.Log4jConfigurator.setLevels({
    'root'    'INFO'
    'net.apjanke.logger.swing'  'DEBUG'
    });

mlxshake.logger.Log4jConfigurator.prettyPrintLogConfiguration

```


