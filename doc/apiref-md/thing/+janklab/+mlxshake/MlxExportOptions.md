# MlxExportOptions - janklab.mlxshake

```text
janklab.mlxshake.MlxExportOptions
```

## Helptext

```text
Options to control behavior of Live Script export.

All the options to control the behavior of exportlivescript and
its helper functions are bundled up in this class.

The constructor accepts name/value pairs as a 2n-long cell vector or
struct, so anywhere you can provide an ExportOptions object, you can also
pass in a cell or struct of property definitions, which will automatically
be converted to an ExportOptions.

See also:
EXPORTLIVESCRIPT

  Documentation for janklab.mlxshake.MlxExportOptions
     doc janklab.mlxshake.MlxExportOptions



```

## Class Contents

### Properties

| Property | Description |
| -------- | ----------- |
| [validFormats](#janklab.mlxshake.MlxExportOptions.validFormats) |  |
| [format](#janklab.mlxshake.MlxExportOptions.format) |  |
| [outFile](#janklab.mlxshake.MlxExportOptions.outFile) |  |
| [markdownPublishTarget](#janklab.mlxshake.MlxExportOptions.markdownPublishTarget) |  |
| [png2jpeg](#janklab.mlxshake.MlxExportOptions.png2jpeg) |  |
| [tableMaxCellContentLength](#janklab.mlxshake.MlxExportOptions.tableMaxCellContentLength) |  |
| [addMention](#janklab.mlxshake.MlxExportOptions.addMention) |  |
| [tempDir](#janklab.mlxshake.MlxExportOptions.tempDir) |  |
| [keepIntermediateFiles](#janklab.mlxshake.MlxExportOptions.keepIntermediateFiles) |  |
| [grabEquationImages](#janklab.mlxshake.MlxExportOptions.grabEquationImages) |  |

### Methods

| Method | Description |
| -------- | ----------- |
| [MlxExportOptions](#janklab.mlxshake.MlxExportOptions.MlxExportOptions) | Constructor. |

## Properties

<a name="janklab.mlxshake.MlxExportOptions.validFormats"></a>
### validFormats

Attributes: Constant, NonCopyable, HasDefault

Default Value: `["auto" "markdown" "html" "pdf" "latex" "msword"]`

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.format"></a>
### format

Attributes: HasDefault

Default Value: `"auto"`

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.outFile"></a>
### outFile

Attributes: HasDefault

Default Value: `string(missing)`

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.markdownPublishTarget"></a>
### markdownPublishTarget

Attributes: HasDefault

Default Value: `"gh-pages"`

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.png2jpeg"></a>
### png2jpeg

Attributes: HasDefault

Default Value: `false`

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.tableMaxCellContentLength"></a>
### tableMaxCellContentLength

Attributes: HasDefault

Default Value: `20`

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.addMention"></a>
### addMention

Attributes: HasDefault

Default Value: `true`

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.tempDir"></a>
### tempDir

Attributes: HasDefault

Default Value: `true`

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.keepIntermediateFiles"></a>
### keepIntermediateFiles

Attributes: HasDefault

Default Value: `false`

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.grabEquationImages"></a>
### grabEquationImages

Attributes: HasDefault

Default Value: `true`

Helptext:

```text
No helptext available.
```


## Methods

<a name="janklab.mlxshake.MlxExportOptions.MlxExportOptions"></a>
### MlxExportOptions

Signature:
```
this = MlxExportOptions(arg)
```

Helptext:

```text
Construct a new object.

obj = janklab.mlxshake.MlxExportOptions
obj = janklab.mlxshake.MlxExportOptions(struct(...))
obj = janklab.mlxshake.MlxExportOptions({'property',value, ...})

You may pass in a struct or cell vector of name/value pairs, where
the names are any property on MlxExportOptions. Names that are not
properties of MlxExportOptions cause an error.

  Documentation for janklab.mlxshake.MlxExportOptions/MlxExportOptions
     doc janklab.mlxshake.MlxExportOptions


```


