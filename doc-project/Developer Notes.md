# ExportMlx Developer Notes

## Workflow

To hack on the code:

```matlab
addpath Mcode; addpath dev-kit
```

and start hacking!

Rerun `exportmlx_gendoco` after all your changes to make sure things are still working, and to keep the User Guide up to date with current library behavior.

## BUGS

## TODO

* Eww: The codecogs usage just puts query URLs in for images, instead of saving local copies of the image files themselves.
* Add CI support.
* Add some tests.
* Support for GitHub Flavored Markdown and other flavors?
* Add support for Jekyll and MkDocs integration.
* Don't leave intermediate `.tex` and `.sty` file droppings (configurable, droppings off by default but enableable with an option).
* Nicer alt text/link text for inline images?
* Handle table arrays with multicolumn variables (which need column-spanning headers).

## See Also

* The [`Release Checklist.md`](Release Checklist.md) file.
