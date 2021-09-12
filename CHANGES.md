ExportMlx Changelog
================================

Version 0.2.0 (in progress)
------------------------------

Enhancements:

* Add support for additional output formats, including PDF, HTML, and Microsoft Word.

Bug fixes:

* Fix CI tests
* Improve organization of `make` targets
* Clean up some leftover MatlabProjectTemplate cruft to make the code tree friendlier
* Fix `make clean` and `rmrf` to properly handle directories

Version 0.1.1 (2021-09-11)
------------------------------

* Fix some missing files in local doc files

Version 0.1.0 (2021-09-11)
------------------------------

* Initial fork of project from Michio Inoue's [livescript2markdown](https://github.com/minoue-xx/livescript2markdown).
* Jankify the code and API.
* Add programmatic mlx-to-tex export.
* Fix broken inline image links.
* Clean up formatting of generated Markdown.
* Add CI support.
* Optionally delete intermediate generated files (the `.tex` and `.sty` etc. files).
* Make logging/progress output configurable.
