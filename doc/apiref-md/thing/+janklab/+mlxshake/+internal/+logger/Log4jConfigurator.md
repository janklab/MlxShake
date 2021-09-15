# janklab.mlxshake.internal.logger.Log4jConfigurator

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
| `prettyPrintLogConfiguration` | ??? |
| `setLevels` | ??? |
| `getLog4jLevel` | ??? |
| `setRootAppenderPattern` | ??? |
| `configureBasicConsoleLogging` | ??? |
| `Log4jConfigurator` | ??? |
| `empty` | ??? |

## Methods

### `prettyPrintLogConfiguration`

```text

```

### `setLevels`

```text

```

### `getLog4jLevel`

```text

```

### `setRootAppenderPattern`

```text

```

### `configureBasicConsoleLogging`

```text

```

### `Log4jConfigurator`

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

### `empty`

```text

```


