# globals - janklab.mlxshake

## Description


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
| [empty](#janklab.mlxshake.globals.empty) | Returns an empty object array of the given size |

## Properties

<a name="janklab.mlxshake.globals.distroot"></a>
### distroot






```text
No helptext available.
```

<a name="janklab.mlxshake.globals.settings"></a>
### settings






```text
No helptext available.
```


## Methods

<a name="janklab.mlxshake.globals.initialize"></a>
### initialize






```text
Initialize this library/package

```

<a name="janklab.mlxshake.globals.version"></a>
### version






```text
The version of the MlxShake library

Returns a string.

```

<a name="janklab.mlxshake.globals.globals"></a>
### globals






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

<a name="janklab.mlxshake.globals.empty"></a>
### empty


Returns an empty object array of the given size



```text
Returns an empty object array of the given size
```


