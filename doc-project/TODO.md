# ExportMlx TODO

## BUGS

* Figure out how to handle features that require a certain version of Matlab, or use toolboxes which may not be installed.
  * This includes how to incorporate them into our examples.

## Enhancements

* Add some tests.
* `exportlivescript` command (like, an external OS/shell command, not a Matlab command).
* Set up the Azure DevOps pipeline. As of 2021-09-11, it's not seeing the ExportMlx repo, although I can see many other janklab repos.
* Nicer alt text/link text for inline images?
* Support for GitHub Flavored Markdown and other flavors of Markdown?
  * Actually, the flavor we support now _is_ GFM; that's needed for tables. Need to officially adopt that, and then maybe add other flavors.
  * Or at least some Markdown options: whether tables are GFM tables or raw HTML tables, etc.
* Add support for Jekyll and MkDocs integration.
  * Front matter for Jekyll etc.
  * Math markup for MkDocs.
* Better handle table arrays with multicolumn variables (which need column-spanning headers).
  * This probably means rendering them as raw HTML tables instead of GFM tables. Will need some new options to control this behavior.
* Configure markdownlint to be more lenient with the files in `docs/`.

## Wishlist

* Additional markup output formats.
  * AsciiDoc support.
  * RestructuredText support.
  * This probably requires reworking the entire processing pipeline to convert the LaTeX to an abstract data structure, and then have converters for that data structure to each output format target, instead of just doing a bunch of regexpreps on the input latex.
* Animated plot support. ([#1](https://github.com/janklab/ExportMlx/issues/1))