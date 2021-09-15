# janklab.mlxshake.mlx2latex

```text
Export a Live Script (.mlx) file to LaTeX (.tex).

janklab.mlxshake.mlx2latex(mlxFile, outFile)

Exports a Matlab Live Script to LaTeX. This produces a .tex file and an
accompanying matlab.sty file and <foo>_images directory next to it. Will
clobber any existing files.

InMlxFile (string) is the path to the input .mlx Live Script file to export.
Files on the Matlab path will not be located; you must provide the full path
to the input file.

OutFile (string) is the path to the output .tex file to export. The
'.tex' extension may be omitted and defaults to '.tex'. You can also use a
different file extension, and that will be respected, but that might mess things
up. By default, the output file is the input file with the '.mlx' extension
replaced by '.tex'.

The undocumented return value is for MlxShake's internal use.

```

