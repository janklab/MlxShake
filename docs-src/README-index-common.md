
## Summary

This tool lets you generate project documentation and web site content from live scripts in your project. This is a nice way of generating rich documentation with included graphics that are up to date with your latest code. Especially nice for tutorials and examples.

See the [Tutorial](https://mlxshake.janklab.net/Tutorial.html) for examples of what it can do. The Tutorial is itself generated from a Matlab live script using MlxShake!

The full documentation is available on [the MlxShake web site](https://mlxshake.janklab.net).

## PRERELEASE BETA SOFTWARE

This is pre-release, beta quality software! It is an experimental work in progress. Everything about it, especially its public API, is subject to change at any time. And it is probably buggy.

DO NOT USE THIS SOFTWARE IN PRODUCTION SYSTEMS!

## Acknowledgments

MlxShake is based on, and started out as a fork of, MathWorker Michio Inoue's [livescript2markdown](https://github.com/minoue-xx/livescript2markdown) tool. MlxShake can largely be viewed as a productization of livescript2markdown.

The Live Script to LaTeX export code is informed by Pavel Roslovets's [Live-Script-to-Markdown-Converter toolbox](https://github.com/roslovets/Live-Script-to-Markdown-Converter).

## License Warning

MlxShake is licensed under a nonstandard MathWorks-specific variant of the BSD 2-Clause License that includes this additional clause:

```text
* In all cases, the software is, and all modifications and derivatives of the
  software shall be, licensed to you solely for use in conjunction with
  MathWorks products and service offerings.
```

This is because the [livescript2markdown](https://github.com/minoue-xx/livescript2markdown) project is licensed that way, and MlxShake contains derivatives of its code.

## Requirements

Matlab version, I dunno, R2019b or later?

## Introduction

MlxShake provides tools for exporting Matlab Live Scripts to Markdown and other formats, including HTML, PDF, Microsoft Word, and more.

## Installation

Download the [latest release](https://github.com/janklab/MlxShake/releases) or clone the [repo](https://github.com/janklab/MlxShake) and put it somewhere on your disk.

Add its `Mcode/` directory to your Matlab path using `addpath()`.

## Usage

Quick summary:

* `exportlivescript` – Export a Live Script `.mlx` file to Markdown. (This is what you probably want.)
* `mlx2latex` – Do just the `.mlx` to `.tex` export step.
* `lslatex2markdown` – Do just the `.tex` to `.md` conversion step.
* `bin/mlxshake` – Run MlxShake from the Unix shell or other programs.

Super quick example:

From Matlab:

```matlab
janklab.mlxshake.exportlivescript('MyLiveScript.mlx')
```

From the Mac or Linux command line:

```bash
./bin/mlxshake MyLiveScript.mlx --format html
```

See the [Tutorial](https://mlxshake.janklab.net/Tutorial.html) for fuller instructions and feature description.

## Project Goals

The goals of MlxShake, specifically as an enhanced fork of [livescript2markdown](https://github.com/minoue-xx/livescript2markdown), are:

* Automate the full process from `.mlx` to `.md`.
* Be suitable for use in automated document generation processes.
* Make the Markdown good enough that no manual touch-up is usually needed.
* Make the code as modern as possible (as of R2019b).
* Produce nicely-formatted output files.
* Support additional output formats.

## Author

MlxShake was developed by [Andrew Janke](https://apjanke.net) based on [livescript2markdown](https://github.com/minoue-xx/livescript2markdown) by [Michio Inoue](https://github.com/minoue-xx).

The project home page is the [GitHub repo page](https://github.com/janklab/MlxShake). Bug reports and feature requests are welcome. The online documentation is on the [MlxShake web site](https://mlxshake.janklab.net), but that is very much a work in progress.

MlxShake is part of the [Janklab](https://janklab.net) suite of open source libraries for Matlab.

MlxShake's repo structure is based on Janklab's [MatlabProjectTemplate](https://github.com/apjanke/MatlabProjectTemplate).

Code was written while listening to [live Phish shows](https://www.livephish.com/).

## Contributing

Contributions are appreciated! Right now I mostly need feature requests, bug reports, and especially example Live Script files that MlxShake can be tested against.

All code contributions to MlxShake must be dual-licensed under the BSD 3-Clause License and the special MathWorks-specific variant of the BSD 2-Clause License that MlxShake is currently licensed under. This is so that MlxShake can be easily relicensed to BSD 3-Clause in the future if its underlying `livescript2markdown` code is similarly relicensed. (Which would be nice, IMHO.)

See the [CONTRIBUTING](https://github.com/janklab/MlxShake/blob/master/.github/CONTRIBUTING.md) file for more info, including coding guidelines.
