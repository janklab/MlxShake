# Contributing to ExportMlx

Contributions are appreciated! Right now I mostly need [feature requests, bug reports](https://github.com/janklab/ExportMlx/issues), and especially example Live Script files that ExportMlx can be tested against.

## Licensing

All code contributions to ExportMlx, including example Live Script files, must be dual-licensed under the BSD 3-Clause License and the special MathWorks-specific variant of the BSD 2-Clause License that ExportMlx is currently licensed under. This is so that ExportMlx can be easily relicensed to the BSD 3-Clause License in the future if its underlying `livescript2markdown` code is similarly relicensed. (Which would be nice, IMHO.)

Image and prose contributiones should be licensed under a Creative Commons license without the "NC" clause. (Because I want this library to be usable in commercial and business contexts.) And we probably shouldn't use "ND" either, because we might need to munge images, at least formatwise, to fit in with our examples correctly.

## Coding Guidelines

### General Concerns

* Be cross-platform. Code must work on all 3 OSes: Windows, macOS, and Linux.
* No third-party library dependencies.
  * If we really must take one, the library must be "vendored" into this repo, and repackaged into the `janklab.exportmlx.internal.opp` package so it will not conflict with any other uses of that library.
  * But it is fine to take dependencies on any of the undocumented Java libraries that Matlab ships with.
* Compatibility level: Matlab R2019b.
  * You may use any R2019b features. You must not use features from any newer release for any core functionality. You may use newer features for non-core features, but they must be optional, and degrade gracefully or produce nice error messages on older Matlab versions.
* Public code goes in the `janklab.exportmlx` package. Internal-use code (things that aren't part of ExportMlx's public API) go in `janklab.exportmlx.internal`.

### Code Formatting

* 4 space indents.
* Spaces after commas that separate function arguments or list items.
* Spaces around operators.
* Use Matlab auto-formatting (Ctrl-A, Ctrl-I) everywhere.

### Naming Conventions

* Go ahead and use `i` and `j` as loop index variables.
* `ix` prefix for numeric indexes.
* `tf` prefix for logical indexes.
* TitleCase class names, camelCase function and variable names.

### Workflow

* Write decent commit messages.
* Capitalize the first letter of commit messages.
* Listen to [Phish](https://www.livephish.com/) while you code.
