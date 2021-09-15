# janklab.mlxshake.globals

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
| `distroot` | ??? |
| `settings` | ??? |

### Methods

| Method | Description |
| -------- | ----------- |
| `initialize` | ??? |
| `version` | ??? |
| `globals` | ??? |
| `empty` | ??? |

## Methods

### `initialize`

```text

```

### `version`

```text

```

### `globals`

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

### `empty`

```text

```


