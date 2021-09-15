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
| [initialize](#janklab.mlxshake.globals.initialize) |  |
| [version](#janklab.mlxshake.globals.version) |  |
| [globals](#janklab.mlxshake.globals.globals) |  |

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

  Documentation for janklab.mlxshake.globals/globals
     doc janklab.mlxshake.globals


```


