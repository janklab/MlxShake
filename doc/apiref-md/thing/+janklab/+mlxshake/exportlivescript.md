# janklab.mlxshake.exportlivescript

```text
Export a Matlab Live Script (.mlx) file to Markdown or other formats.

mdFile = janklab.mlxshake.exportlivescript(mlxFile, opts)

Exports a Matlab Live Script .mlx file to Markdown or other presentation file
formats. Defaults to Markdown format.

Depending on the output format, this may produce multiple output files.

InFile (string) is the path to the input Live Script .mlx file you want to
export. You may omit the '.mlx' extension.

Opts controls various aspects of exportlivescript's behavior. It is a
janklab.mlxshake.MlxExportOptions or a cell vector of name/value pairs (which gets
turned in to an MlxExportOptions). See MlxExportOptions' documentation for the
available options and their effects.

Useful options:

  format   - The output file format. May be "auto", "markdown", "html", "pdf",
             "latex", "msword", or maybe more.
  outFile  - Path to the output file to produce. Defaults to a file of the
             appropriate extension for the output format in the input
             directory next to the original input file.

Returns the path to the main exported file. There may be other auxiliary files
produced; they will be in the folder next to the main output file. What
exactly they are and what they are named varies based on the output format.

Examples:

    import janklab.mlxshake.exportlivescript

    exportlivescript('foo.mlx');

    
```

