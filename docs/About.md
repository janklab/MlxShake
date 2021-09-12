# About ExportMlx

## Development History

ExportMlx was started in September 2021 as a fork of MathWorker [Michio Inoue's](https://github.com/minoue-xx) [livescript2markdown](https://github.com/minoue-xx/livescript2markdown) project. I created this fork because I wanted to enhance the functionality of livescript2markdown and fix a couple bugs, and it was easier to create a fork than to send a bunch of PRs up to livescript2markdown. Also I wanted the code to be just how I like it, and having my own project let me do it this way.

## Features and Enhancements

Viewed as a fork of livescript2markdown, ExportMlx provides the following features:

* Automation of entire export process from `.mlx` to Markdown or other output.
* Support for additional export targets.
* Captures rendered math equations as static local files.
* Better library packaging.
* Nicer formatting of generated Markdown.

The main motivation here is to take the basic livescript2markdown code and "productize" it into a high quality library that can be easily reused by other Matlab code and in enterprise software contexts.

## Related Works and Acknowledgments

The core LaTeX-to-Markdown export code in ExportMlx is based on MathWorker [Michio Inoue's](https://github.com/minoue-xx) [livescript2markdown](https://github.com/minoue-xx/livescript2markdown) project.

The earlier part of the export process that converts `.mlx` files to `.tex` is informed by, but does not actually use any code from, [Pavel Roslovets'](https://github.com/roslovets) [Live-Script-To-Markdown-Converter](https://github.com/roslovets/Live-Script-to-Markdown-Converter).

I was introduced to livescript2markdown and the potential for Matlab Live Scripts to act as rich documentation in a project by [Vijay Iyer](https://www.linkedin.com/in/mathworks-neuro-liaison) at MathWorks, and used this in a MathWorks-sponsored project to [enhance the Neuropixel Utils library](https://apjanke.github.io/neuropixel-jankify/) in 2021.

The repo structure and utility code comes from my own [MatlabProjectTemplate](https://matlabprojecttemplate.janklab.net) project. Using it for ExportMlx has helped me make MatlabProjectTemplate itself better.

Thank you to the [Matlab Continuous Integration](https://www.mathworks.com/solutions/continuous-integration.html) team for making Matlab CI a thing and supporting its free use for Open Source projects.
