# ExportMlx: Export Matlab Live Scripts to Markdown

Export Matlab Live Scripts to Markdown and other formats.

This tool lets you generate project documentation and web site content from live scripts in your project. This is a nice way of generating rich documentation with included graphics that are up to date with your latest code. Especially nice for tutorials and examples.

See the [User Guide](doc/UserGuide.md) for examples of what it can do; the User Guide is itself generated from a Matlab live script using ExportMlx!

## Acknowledgments

ExportMlx is based on, and started out as a fork of, MathWorker Michio Inoue's [livescript2markdown](https://github.com/minoue-xx/livescript2markdown) tool.

The Live Script to LaTeX export code is informed by Pavel Roslovets's [Live-Script-to-Markdown-Converter toolbox](https://github.com/roslovets/Live-Script-to-Markdown-Converter).

## License Warning

ExportMlx is licensed under a nonstandard variant of the BSD 2-Clause License that includes this additional clause:

```text
* In all cases, the software is, and all modifications and derivatives of the
  software shall be, licensed to you solely for use in conjunction with
  MathWorks products and service offerings.
```

This is because livescript2markdown is licensed that way, and ExportMlx contains derivatives of its code.

## Requirements

Matlab version, I dunno, R2019b or later?

## Introduction

ExportMlx provides tools for exporting Matlab Live Scripts to Markdown and other formats.

This code has been tested with multiple live scripts but please note that it's not perfect. It's expected that you need some manual editing (for now!).

## Installation

Download this distro or repo and put it somewhere on your disk.

Add its `Mcode/` directory to your Matlab path using `addpath()`.

## Usage

See the [User Guide](doc/UserGuide.md) for instructions and feature summary.

## Author

ExportMlx was developed by [Andrew Janke](https://apjanke.net) based on [livescript2markdown](https://github.com/minoue-xx/livescript2markdown) by [Michio Inoue](https://github.com/minoue-xx).

The project home page is the [GitHub repo page](https://github.com/janklab/ExportMlx). Bug reports and feature requests are welcome.

ExportMlx is part of the [Janklab](https://janklab.net) suite of open source libraries for Matlab.
