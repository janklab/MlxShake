# LsLatex2MardkownExporter - janklab.mlxshake.internal

## Description


## Helptext

```text
Exports LS-exported LaTeX to Markdown

  Documentation for janklab.mlxshake.internal.LsLatex2MardkownExporter
     doc janklab.mlxshake.internal.LsLatex2MardkownExporter



```

## Class Contents

### Properties

| Property | Description |
| -------- | ----------- |

### Methods

| Method | Description |
| -------- | ----------- |
| [lslatex2markdown](#janklab.mlxshake.internal.LsLatex2MardkownExporter.lslatex2markdown) |  |
| [LsLatex2MardkownExporter](#janklab.mlxshake.internal.LsLatex2MardkownExporter.LsLatex2MardkownExporter) |  |
| [empty](#janklab.mlxshake.internal.LsLatex2MardkownExporter.empty) | Returns an empty object array of the given size |

### Superclasses

| Superclass | Description |
| -------- | ----------- |
| `janklab.mlxshake.internal.MlxshakeBase` |  |

## Properties


## Methods

<a name="janklab.mlxshake.internal.LsLatex2MardkownExporter.lslatex2markdown"></a>
### lslatex2markdown






```text
Convert Live Script LaTeX to Markdown.

outMdFile = obj.lslatex2markdown(inFile, opts)

Converts a LaTeX-format exported Live Script file to Markdown. Will also
produce accompanying image files in a subdirectory next to the output .md
file.

This does not work on LaTeX in general! Only the specific LaTeX files
that are produced by Matlab's "Export to LaTeX" function for Matlab Live
Scripts.

The "lslatex" name indicates that this only works on Live Script-produced
LaTeX, not LaTeX in general.

InFile (string) is the path to the LaTeX .tex file to convert.
The '.tex' suffix is optional.

Opts is a janklab.mlxshake.MlxExportOptions object. See its documentation for
available options and their behavior.

Returns the path to the generated .md file.

See also:
MLXEXPORTOPTIONS

```

<a name="janklab.mlxshake.internal.LsLatex2MardkownExporter.LsLatex2MardkownExporter"></a>
### LsLatex2MardkownExporter






```text
Exports LS-exported LaTeX to Markdown

```

<a name="janklab.mlxshake.internal.LsLatex2MardkownExporter.empty"></a>
### empty


Returns an empty object array of the given size



```text
Returns an empty object array of the given size
```


