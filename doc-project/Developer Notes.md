# ExportMlx Developer Notes

## Workflow

To hack on the code:

```matlab
addpath Mcode; addpath dev-kit
```

and start hacking!

Rerun `exportmlx_gendoco` after all your changes to make sure things are still working, and to keep the User Guide up to date with current library behavior.

## TODO

### BUGS

* Figure out how to handle features that require a certain version of Matlab, or use toolboxes which may not be installed.
  * This includes how to incorporate them into our examples.

* What is all this junk? Seems to show up when I run under R2019b

```text
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        docs/UserGuide.aux
        docs/UserGuide.fdb_latexmk
        docs/UserGuide.fls
        docs/UserGuide.out
        docs/UserGuide.pdf
        docs/UserGuide.synctex.gz
```

### Enhancements

* The codecogs usage just puts query URLs in for images, instead of saving local copies of the image files themselves. Eww.
* Nicer alt text/link text for inline images?
* Add some tests.
* Support for GitHub Flavored Markdown and other flavors?
  * Actually, the flavor we support now _is_ GFM; that's needed for tables. Need to officially adopt that, and then maybe add other flavors.
* Add support for Jekyll and MkDocs integration.
* Handle table arrays with multicolumn variables (which need column-spanning headers).
* Configure markdownlint to be more lenient with the files in `docs/`.

### Wishlist

* Additional output formats.
  * AsciiDoc support.
  * RestructuredText support.
  * This probably requires reworking the entire processing pipeline to convert the LaTeX to an abstract data structure, and then have converters for that data structure to each output format target, instead of just doing a bunch of regexpreps on the input latex.
* Animated plot support. ([#1](https://github.com/janklab/ExportMlx/issues/1))

## See Also

* The [`Release Checklist.md`](Release Checklist.md) file.
