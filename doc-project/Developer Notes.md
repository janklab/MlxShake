# ExportMlx Developer Notes

## BUGS

* Inline image links get broken in to multiple lines:

```markdown
![/Users/janke/local/repos/ExportMlx/doc/UserGuide_images/figure_0.png
](UserGuide_images/figure_0.png
)
```

## TODO

* Convert API to OOP and jankify
* Replace all uses of `rand` in doco with something else, for reproducible builds.
* Try to get output Markdownlint-clean
* Eww: the codecogs usage just puts query URLs in for images, instead of saving local copies of the image files themselves.
* Add support for Jekyll and MkDocs integration.
* Don't leave intermediate `.tex` and `.sty` file droppings.
* Maybe add a "credits" note to generated files. This should be disableable. Should probably only be in the comments/internal markup, not reader-visible.
* Nicer alt text/link text for inline images?
* Make it faster.

## See Also

* The [`Release Checklist.md`](Release Checklist.md) file.
