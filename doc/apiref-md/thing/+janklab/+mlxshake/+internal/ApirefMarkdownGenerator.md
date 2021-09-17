# ApirefMarkdownGenerator - janklab.mlxshake.internal

HandleCompatible

```text
janklab.mlxshake.internal.ApirefMarkdownGenerator
  janklab.mlxshake.internal.ApirefGenerator
    janklab.mlxshake.internal.MlxshakeBaseHandle
      handle
```

## Helptext

Generates Markdown format output for API Reference doco.


## Class Contents

### Properties

| Property | Description |
| -------- | ----------- |
| [stuffDir](#janklab.mlxshake.internal.ApirefMarkdownGenerator.stuffDir) |  |
| [pkgsDir](#janklab.mlxshake.internal.ApirefMarkdownGenerator.pkgsDir) |  |
| [thingsDir](#janklab.mlxshake.internal.ApirefMarkdownGenerator.thingsDir) |  |
| [pkgInfo](#janklab.mlxshake.internal.ApirefMarkdownGenerator.pkgInfo) |  |
| [uPackages](#janklab.mlxshake.internal.ApirefMarkdownGenerator.uPackages) |  |
| [pkgRelMdFiles](#janklab.mlxshake.internal.ApirefMarkdownGenerator.pkgRelMdFiles) |  |
| [thingRelMdFiles](#janklab.mlxshake.internal.ApirefMarkdownGenerator.thingRelMdFiles) |  |

### Methods

| Method | Description |
| -------- | ----------- |
| [generateClassDoc](#janklab.mlxshake.internal.ApirefMarkdownGenerator.generateClassDoc) | Generate doco file for a class. |
| [generateFunctionDoc](#janklab.mlxshake.internal.ApirefMarkdownGenerator.generateFunctionDoc) | Generate doco file for a function. |
| [generatePackageDoc](#janklab.mlxshake.internal.ApirefMarkdownGenerator.generatePackageDoc) | Generate doco files for a package. |
| [generateIndex](#janklab.mlxshake.internal.ApirefMarkdownGenerator.generateIndex) | Generate the main index files for the full code base. |
| [thingHtmlFileRelPath](#janklab.mlxshake.internal.ApirefMarkdownGenerator.thingHtmlFileRelPath) | janklab.mlxshake.internal.ApirefMarkdownGenerator/thingHtmlFileRelPath is a function. |
| [formatHelptext](#janklab.mlxshake.internal.ApirefMarkdownGenerator.formatHelptext) |  |
| [generateForMyFormat](#janklab.mlxshake.internal.ApirefMarkdownGenerator.generateForMyFormat) | Format-specific generation implementation. |
| [ApirefMarkdownGenerator](#janklab.mlxshake.internal.ApirefMarkdownGenerator.ApirefMarkdownGenerator) | Constructor. |

### Superclasses

| Superclass | Description |
| -------- | ----------- |
| `janklab.mlxshake.internal.ApirefGenerator` |  |

## Properties

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.stuffDir"></a>
### stuffDir

Helptext:


No helptext available.


<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.pkgsDir"></a>
### pkgsDir

Helptext:


No helptext available.


<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.thingsDir"></a>
### thingsDir

Helptext:


No helptext available.


<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.pkgInfo"></a>
### pkgInfo

Helptext:


No helptext available.


<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.uPackages"></a>
### uPackages

Helptext:


No helptext available.


<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.pkgRelMdFiles"></a>
### pkgRelMdFiles

Attributes: HasDefault

Default Value: `strings(0,0)`

Helptext:


No helptext available.


<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.thingRelMdFiles"></a>
### thingRelMdFiles

Attributes: HasDefault

Default Value: `strings(0,0)`

Helptext:


No helptext available.



## Methods

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.generateClassDoc"></a>
### generateClassDoc

Signature:
```
generateClassDoc(this, rec)
```

Helptext:

Generate doco file for a class.



<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.generateFunctionDoc"></a>
### generateFunctionDoc

Signature:
```
generateFunctionDoc(this, pkg, name, qname, mFilePath)
```

Helptext:

Generate doco file for a function.



<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.generatePackageDoc"></a>
### generatePackageDoc

Signature:
```
generatePackageDoc(this, rec)
```

Helptext:

Generate doco files for a package.

This does the package-level stuff only; not the functions and
classes contained within it.



<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.generateIndex"></a>
### generateIndex

Signature:
```
generateIndex(this)
```

Helptext:

Generate the main index files for the full code base.



<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.thingHtmlFileRelPath"></a>
### thingHtmlFileRelPath

Signature:
```
out = thingHtmlFileRelPath(this, thing)
```

Helptext:

janklab.mlxshake.internal.ApirefMarkdownGenerator/thingHtmlFileRelPath is a function.
  out = thingHtmlFileRelPath(this, thing)



<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.formatHelptext"></a>
### formatHelptext

Signature:
```
out = formatHelptext(varargin)
```

Helptext:


helptextStr is the *raw* helptext. Will still have leading spaces
and whatnot.



<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.generateForMyFormat"></a>
### generateForMyFormat

Signature:
```
generateForMyFormat(this)
```

Helptext:

Format-specific generation implementation.

Generates:
  * index.md
  * stuff/<package>.md for each package
  * stuff/<thing>.md for each class or function



<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.ApirefMarkdownGenerator"></a>
### ApirefMarkdownGenerator

Signature:
```
obj = ApirefMarkdownGenerator()
```

Helptext:

Generates Markdown format output for API Reference doco.




