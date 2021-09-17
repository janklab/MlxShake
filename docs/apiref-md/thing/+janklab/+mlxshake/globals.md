# globals - janklab.mlxshake

```text
janklab.mlxshake.globals
```

## Helptext

```text
Global library properties and settings for MlxShake.

Note that if you want to change the settings, you can't do this:

   janklab.mlxshake.globals.settings.someSetting = 42;

That will break due to how Matlab Constant properties work. Instead, you need
to first grab the Settings object and store it in a variable, and then work
on that:

   s = janklab.mlxshake.globals.settings;
   s.someSetting = 42;

  Documentation for janklab.mlxshake.globals
     doc janklab.mlxshake.globals



```

## Class Contents

### Properties

| Property | Description |
| -------- | ----------- |
| [distroot](#janklab.mlxshake.globals.distroot) |  |
| [settings](#janklab.mlxshake.globals.settings) |  |

### Methods

| Method | Description |
| -------- | ----------- |
| [loglevel](#janklab.mlxshake.globals.loglevel) |  |
| [initialize](#janklab.mlxshake.globals.initialize) |  |
| [version](#janklab.mlxshake.globals.version) |  |
| [globals](#janklab.mlxshake.globals.globals) | Constructor. |

## Properties

<a name="janklab.mlxshake.globals.distroot"></a>
### distroot

Attributes: Constant, NonCopyable, HasDefault

Default Value: `"/Users/janke/local/repos/MlxShake"`

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.globals.settings"></a>
### settings

Attributes: Constant, NonCopyable, HasDefault

Default Value: <unrepresentable>

Helptext:

```text
No helptext available.
```


## Methods

<a name="janklab.mlxshake.globals.loglevel"></a>
### loglevel

Attributes: Static

Signature:
```
out = globals.loglevel(newLevel)
```

Helptext:

```text
Get or set logging level for the mlxshake package.

out = janklab.mlxshake.globals.loglevel()
oldLevel = janklab.mlxshake.globals.loglevel(newLevel)

This is a convenience method that provides a simplified interface
on top of MlxShake's internal logging tools. It does not support
all functionality of level control. This is intentional, to keep
the interface simple.

NewLevel (string) is the logging level to set at the root
janklab.mlxshake package. This should control all logging done by
MlxShake. Valid values are:
   "info"  - The regular, concise and quiet logging.
   "debug" - More detailed logging, with progress messages.

The return value is the currently-set logging level. Possible
values are:
   "info"
   "debug"
   "custom" - Means the logging configuration is in a weird state
       that this function is not prepared to handle.

```

<a name="janklab.mlxshake.globals.initialize"></a>
### initialize

Attributes: Static

Signature:
```
globals.initialize()
```

Helptext:

```text
Initialize this library/package

```

<a name="janklab.mlxshake.globals.version"></a>
### version

Attributes: Static

Signature:
```
out = globals.version()
```

Helptext:

```text
The version of the MlxShake library

Returns a string.

```

<a name="janklab.mlxshake.globals.globals"></a>
### globals

Signature:
```
obj = globals()
```

Helptext:

```text
Global library properties and settings for MlxShake.

Note that if you want to change the settings, you can't do this:

   janklab.mlxshake.globals.settings.someSetting = 42;

That will break due to how Matlab Constant properties work. Instead, you need
to first grab the Settings object and store it in a variable, and then work
on that:

   s = janklab.mlxshake.globals.settings;
   s.someSetting = 42;

```


