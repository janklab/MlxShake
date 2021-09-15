# MlxExportOptions - janklab.mlxshake

## Description


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
| [MlxExportOptions](#janklab.mlxshake.MlxExportOptions.MlxExportOptions) |  |
| [empty](#janklab.mlxshake.MlxExportOptions.empty) | Returns an empty object array of the given size |

## Properties

<a name="janklab.mlxshake.MlxExportOptions.validFormats"></a>
### validFormats






```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.format"></a>
### format






```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.outFile"></a>
### outFile






```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.markdownPublishTarget"></a>
### markdownPublishTarget






```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.png2jpeg"></a>
### png2jpeg






```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.tableMaxCellContentLength"></a>
### tableMaxCellContentLength






```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.addMention"></a>
### addMention






```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.tempDir"></a>
### tempDir






```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.keepIntermediateFiles"></a>
### keepIntermediateFiles






```text
No helptext available.
```

<a name="janklab.mlxshake.MlxExportOptions.grabEquationImages"></a>
### grabEquationImages






```text
No helptext available.
```


## Methods

<a name="janklab.mlxshake.MlxExportOptions.MlxExportOptions"></a>
### MlxExportOptions






```text
Construct a new object.

obj = janklab.mlxshake.MlxExportOptions
obj = janklab.mlxshake.MlxExportOptions(struct(...))
obj = janklab.mlxshake.MlxExportOptions({'property',value, ...})

You may pass in a struct or cell vector of name/value pairs, where
the names are any property on MlxExportOptions. Names that are not
properties of MlxExportOptions cause an error.

```

<a name="janklab.mlxshake.MlxExportOptions.empty"></a>
### empty


Returns an empty object array of the given size



```text
Returns an empty object array of the given size
```


