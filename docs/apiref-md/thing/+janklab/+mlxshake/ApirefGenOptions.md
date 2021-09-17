# ApirefGenOptions - janklab.mlxshake

```text
janklab.mlxshake.ApirefGenOptions
```

## Helptext

Options to control the behavior of the genapiref function.

This controls various aspects of GENAPIREF's behavior.

See also:
GENAPIREF


## Class Contents

### Properties

| Property | Description |
| -------- | ----------- |
| [format](#janklab.mlxshake.ApirefGenOptions.format) |  |
| [projectName](#janklab.mlxshake.ApirefGenOptions.projectName) |  |
| [doInternal](#janklab.mlxshake.ApirefGenOptions.doInternal) |  |
| [showHidden](#janklab.mlxshake.ApirefGenOptions.showHidden) |  |
| [helptextFormat](#janklab.mlxshake.ApirefGenOptions.helptextFormat) |  |

### Methods

| Method | Description |
| -------- | ----------- |
| [ApirefGenOptions](#janklab.mlxshake.ApirefGenOptions.ApirefGenOptions) | Constructor. |

## Properties

<a name="janklab.mlxshake.ApirefGenOptions.format"></a>
### format

Attributes: HasDefault

Default Value: `"markdown"`

Helptext:


No helptext available.


<a name="janklab.mlxshake.ApirefGenOptions.projectName"></a>
### projectName

Attributes: HasDefault

Default Value: `"Untitled Project"`

Helptext:


No helptext available.


<a name="janklab.mlxshake.ApirefGenOptions.doInternal"></a>
### doInternal

Attributes: HasDefault

Default Value: `false`

Helptext:


No helptext available.


<a name="janklab.mlxshake.ApirefGenOptions.showHidden"></a>
### showHidden

Attributes: HasDefault

Default Value: `false`

Helptext:


No helptext available.


<a name="janklab.mlxshake.ApirefGenOptions.helptextFormat"></a>
### helptextFormat

Attributes: HasDefault

Default Value: `"vanilla"`

Helptext:


No helptext available.



## Methods

<a name="janklab.mlxshake.ApirefGenOptions.ApirefGenOptions"></a>
### ApirefGenOptions

Signature:
```
this = ApirefGenOptions(arg)
```

Helptext:

Construct a new object.

    obj = janklab.mlxshake.ApirefGenOptions
    obj = janklab.mlxshake.ApirefGenOptions(struct(...))
    obj = janklab.mlxshake.ApirefGenOptions({'property',value, ...})

You may pass in a struct or cell vector of name/value pairs, where
the names are any property on ApirefGenOptions. Names that are not
properties of ApirefGenOptions cause an error.




