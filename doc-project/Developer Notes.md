# ExportMlx Developer Notes

## Workflow

To hack on the code:

```matlab
addpath Mcode; addpath dev-kit
```

and start hacking!

Rerun `exportmlx_gendoco` after all your changes to make sure things are still working, and to keep the User Guide up to date with current library behavior.

## Special Notes

Do not edit `README.md` or `docs/index.md` directly! These files are generated from shared sources in the `doc-src/` directory. Edit the files there instead.

## TODO

### BUGS

* Figure out how to handle features that require a certain version of Matlab, or use toolboxes which may not be installed.
  * This includes how to incorporate them into our examples.
* Convert codecogs links from raw HTML to Markdown tags.

### Enhancements

* `exportlivescript` command (like, an external command, not a Matlab command).
* The codecogs usage just puts query URLs in for images, instead of saving local copies of the image files themselves. Eww.
* Set up the Azure DevOps pipeline. As of 2021-09-11, it's not seeing the ExportMlx repo, although I can see many other janklab repos.
* Nicer alt text/link text for inline images?
* Add some tests.
  * The current "tests" are a destructive rebuild of the source tree's own generated docs. Not good.
* Move the *.mlx files from docs/ to doc-src/ and export across dirs.
  * Should the retained *.tex files go in doc-src/ or docs/? Should they be visible in the GH Pages site? Should they end up in doc/?
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
