# Settings - janklab.mlxshake

HandleCompatible

## Helptext

```text
Global settings for the mlxshake package

Don't use this class directly. If you want to get or set the settings,
work with the instance of this in the janklab.mlxshake.globals.settings
field.

There are currently no settings defined for this package.

  Documentation for janklab.mlxshake.Settings
     doc janklab.mlxshake.Settings



```

## Class Contents

### Methods

| Method | Description |
| -------- | ----------- |
| [discover](#janklab.mlxshake.Settings.discover) |  |
| [Settings](#janklab.mlxshake.Settings.Settings) |  |

### Superclasses

| Superclass | Description |
| -------- | ----------- |
| `janklab.mlxshake.internal.MlxshakeBaseHandle` |  |

## Methods

<a name="janklab.mlxshake.Settings.discover"></a>
### discover

Attributes: Static

Signature:
```
out = Settings.discover()
```

Helptext:

```text
Discovery of initial values for package settings.

This could look at config files, environment variables, Matlab appdata, and
so on.

This needs to avoid referencing mlxshake.globals, to avoid a circular dependency.

```

<a name="janklab.mlxshake.Settings.Settings"></a>
### Settings

Signature:
```
obj = Settings()
```

Helptext:

```text
Global settings for the mlxshake package

Don't use this class directly. If you want to get or set the settings,
work with the instance of this in the janklab.mlxshake.globals.settings
field.

There are currently no settings defined for this package.

  Documentation for janklab.mlxshake.Settings/Settings
     doc janklab.mlxshake.Settings


```


