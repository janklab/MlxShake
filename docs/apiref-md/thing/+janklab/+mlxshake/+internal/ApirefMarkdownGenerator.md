# ApirefMarkdownGenerator - janklab.mlxshake.internal

HandleCompatible

```text
janklab.mlxshake.internal.ApirefMarkdownGenerator
  janklab.mlxshake.internal.ApirefGenerator
    janklab.mlxshake.internal.MlxshakeBaseHandle
      handle
```

## Helptext

```text
Generates Markdown format output for API Reference doco.

  Documentation for janklab.mlxshake.internal.ApirefMarkdownGenerator
     doc janklab.mlxshake.internal.ApirefMarkdownGenerator



```

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

```text
No helptext available.
```

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.pkgsDir"></a>
### pkgsDir

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.thingsDir"></a>
### thingsDir

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.pkgInfo"></a>
### pkgInfo

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.uPackages"></a>
### uPackages

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.pkgRelMdFiles"></a>
### pkgRelMdFiles

Attributes: HasDefault

Default Value: `strings(0,0)`

Helptext:

```text
No helptext available.
```

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.thingRelMdFiles"></a>
### thingRelMdFiles

Attributes: HasDefault

Default Value: `strings(0,0)`

Helptext:

```text
No helptext available.
```


## Methods

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.generateClassDoc"></a>
### generateClassDoc

Signature:
```
generateClassDoc(this, rec)
```

Helptext:

```text
Generate doco file for a class.

```

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.generateFunctionDoc"></a>
### generateFunctionDoc

Signature:
```
generateFunctionDoc(this, pkg, name, qname, mFilePath)
```

Helptext:

```text
Generate doco file for a function.

```

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.generatePackageDoc"></a>
### generatePackageDoc

Signature:
```
generatePackageDoc(this, rec)
```

Helptext:

```text
Generate doco files for a package.

This does the package-level stuff only; not the functions and
classes contained within it.

```

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.generateIndex"></a>
### generateIndex

Signature:
```
generateIndex(this)
```

Helptext:

```text
Generate the main index files for the full code base.

```

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.thingHtmlFileRelPath"></a>
### thingHtmlFileRelPath

Signature:
```
out = thingHtmlFileRelPath(this, thing)
```

Helptext:

```text
janklab.mlxshake.internal.ApirefMarkdownGenerator/thingHtmlFileRelPath is a function.
  out = thingHtmlFileRelPath(this, thing)

```

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.generateForMyFormat"></a>
### generateForMyFormat

Signature:
```
generateForMyFormat(this)
```

Helptext:

```text
Format-specific generation implementation.

Generates:
  * index.md
  * stuff/<package>.md for each package
  * stuff/<thing>.md for each class or function

```

<a name="janklab.mlxshake.internal.ApirefMarkdownGenerator.ApirefMarkdownGenerator"></a>
### ApirefMarkdownGenerator

Signature:
```
obj = ApirefMarkdownGenerator()
```

Helptext:

```text
Generates Markdown format output for API Reference doco.

  Documentation for janklab.mlxshake.internal.ApirefMarkdownGenerator/ApirefMarkdownGenerator
     doc janklab.mlxshake.internal.ApirefMarkdownGenerator


```


