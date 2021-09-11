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

### Enhancements

* Eww: The codecogs usage just puts query URLs in for images, instead of saving local copies of the image files themselves.
* Add some tests.
* Support for GitHub Flavored Markdown and other flavors?
  * Actually, the flavor we support now _is_ GFM; that's needed for tables. Need to officially adopt that, and then maybe add other flavors.
* Add support for Jekyll and MkDocs integration.
* Don't leave intermediate `.tex` and `.sty` file droppings (configurable, droppings off by default but enableable with an option).
* Nicer alt text/link text for inline images?
* Handle table arrays with multicolumn variables (which need column-spanning headers).

### Wishlist

* Additional output formats.
  * AsciiDoc support.
  * RestructuredText support.
  * This probably requires reworking the entire processing pipeline to convert the LaTeX to an abstract data structure, and then have converters for that data structure to each output format target, instead of just doing a bunch of regexpreps on the input latex.
* Animated plot support. ([#1](https://github.com/janklab/ExportMlx/issues/1))

## See Also

* The [`Release Checklist.md`](Release Checklist.md) file.
