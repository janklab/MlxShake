---
title: MlxShake FAQ
---

* [How is "MlxShake" pronounced?](#pronunciation)
* [Why do API Reference doco generation?](#why-apiref)

<a name="pronunciation"></a>

## How is "MlxShake" pronounced?

It's "milkshake".

<a name="why-apiref"></a>

## Why do API Reference doco generation?

Why should MlxShake do API Reference ("APIref") documentation generation, when Matlab already has `help()` and `doc()` that work with your helptext?

A few reasons:

* Publishing to the web and intranets.
* Permanent references.
* Integrate into other documentation contexts.
* Integration with exported Live Scripts.
* View doco without installing the package.
* I like class docs with the whole class on one page.
* Some navigation improvements.
* Advanced shizz.

### Publishing to the web and intranets

Matlab's `help()` and `doc()` functions only let you view the help for what's currently loaded in your Matlab session. Building your API reference documentation as static files lets you publish it on the web, organizational intranets, and other places. This lets you do some useful things:

* Prospective users or contributors (including MathWorks Tech Support!) can read the documentation before installing the package, to evaluate it, learn about it, or whatever.
* Search engines like Google can find and index it. Now if you a user has a question about the package, they can google it and maybe get an answer.
  * Plus, googlejuice: Now your documentation maybe counts toward search engine rankings, online relevance scores, and other stuff like that.
  * Prospective users who don't even know about your package, but have a relevant use case, might find it by searching.
* Organizational intranets can link to the documentation, including version-specific documentation.

When working on MlxShake itself, I published its APIref doco to the web, and was able to just pass around a link to that on internet forums, which helped people understand what the library does, and maybe got some people interested in it.

### Permanent references

There's some benefit to having a static copy of version-specific documentation for a package, so you can compare its behavior and documentation between versions by looking at the doco for multiple versions side-by-side in a single session (like, in two different browser window). Easy with static generated APIref. Pretty darn hard with the Matlab Help Browser.

### Integrate into other documentation contexts

If you publish your API Reference documentation to Markdown, HTML, or other formats, you can dump that output into the context of a larger set of documents, like a Jekyll or MkDocs site. Your APIref doco can pick up the styling, navigation tools, and other stuff from that context. That looks nice, and can be functionally useful.

### Integration with exported Live Scripts

Remember the whole original purpose of MlxShake, which was to export Matlab Live Scripts to Markdown etc.? If you're generating your own APIref doco, then you can incorporate those exported Live Scripts in to it. Matlab's doco tools (currently) have no support for this.

### View without installing the package

Whether you publish it to the web or not, this lets people read the documentation without having to install the package or Toolbox into their local Matlab installation. I can see various reasons why that's good.

### I like class docs with the whole class on one page

Matlab's `help()` and `doc()` present the documentation for class's methods and properties in stuff in a single page per method/property/other-thing. That leads to a lot of back-and-forth navigation in the Help Browser, or typeing in a lot of different `help` commands.

I prefer to have my documentation for classes all on one page, like [Javadoc](https://en.wikipedia.org/wiki/Javadoc) does (and I think most Python docs do), with a single big listing of all the properties, methods, events, and other things for the class on one page. Makes it easier to read through the entire thing as a document to get a full understanding of the class; easier to search by hitting Ctrl-F and seeing if something shows up in _any_ of the things for that class; easier to skim the whole thing to get a high-level understanding of the class.

This is a specific case of the broader idea of controlling and customizing the format of the documentation for your package, or the presentation of documentation for other packages. A configurable APIref documentation tool lets you build your doco how you want it, not just the way that the Matlab Help Browser displays it.

Are you building an internal-use copy of the documentation for your own developers that should include stuff in `+internal` packages? You can do that! Do you want `Hidden` methods and properties to be included in the doco? You can do that!

I also like to have a main index page that lists all the packages and things in a library, and per-package index pages that list all the things in a package, both automatically generated. Matlab doesn't seem to support the former at all, and I'm not happy with how it does the latter.

### Advanced shizz

Matlab's native `help()` and `doc()` helptext tools only support a very simple format for helptext. That's kinda underpowered if you're writing documentation for complext code.

I'm playing around with fully supporting Markdown, HTML, and other formats in helptext. (Simple Markdown basically works out of the box, so that's easy.)

I'd also like to do more documentation generation directly from Matlab code itself, instead of just formatting helptext. Things like:

* Including stuff about `arguments` block definitions
* Supporting a "Since:" version indicator
* Generating dependency graphs, or textual documentation about dependencies
