# ExportMlx Developer Notes

## BUGS

* Markdown image link text uses absolute file names. Maybe there's something better?
* And the absolute path gets baked into the image link.
* Inline image links get broken in to multiple lines:

```markdown
![/Users/janke/local/repos/ExportMlx/doc/UserGuide_images/figure_0.png
](UserGuide_images/figure_0.png
)
```

## TODO

* Pull in code to programmatically export mlx->tex
* Convert API to OOP and jankify
* Stringify API
* Move code into a package
* Replace all uses of `rand` in doco with something else, for reproducible builds.
* Try to get output Markdownlint-clean
* Eww: the codecogs usage just puts query URLs in for images, instead of saving local copies of the image files themselves.