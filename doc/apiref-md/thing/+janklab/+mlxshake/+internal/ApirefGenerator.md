# ApirefGenerator - janklab.mlxshake.internal

Abstract, HandleCompatible

```text
janklab.mlxshake.internal.ApirefGenerator
  janklab.mlxshake.internal.MlxshakeBaseHandle
    handle
```

## Helptext

Generates API Reference doco from source code.


## Class Contents

### Properties

| Property | Description |
| -------- | ----------- |
| [outDir](#janklab.mlxshake.internal.ApirefGenerator.outDir) |  |
| [inDirs](#janklab.mlxshake.internal.ApirefGenerator.inDirs) |  |
| [opts](#janklab.mlxshake.internal.ApirefGenerator.opts) |  |
| [mfiles](#janklab.mlxshake.internal.ApirefGenerator.mfiles) |  |
| [packages](#janklab.mlxshake.internal.ApirefGenerator.packages) |  |

### Methods

| Method | Description |
| -------- | ----------- |
| [generateForMyFormat](#janklab.mlxshake.internal.ApirefGenerator.generateForMyFormat) | Generate the output in the subclass's output format. |
| [forFormat](#janklab.mlxshake.internal.ApirefGenerator.forFormat) |  |
| [discover](#janklab.mlxshake.internal.ApirefGenerator.discover) | Discover source code files on the input paths. |
| [generate](#janklab.mlxshake.internal.ApirefGenerator.generate) | Generate the doco output. |
| [ApirefGenerator](#janklab.mlxshake.internal.ApirefGenerator.ApirefGenerator) | Constructor. |

### Superclasses

| Superclass | Description |
| -------- | ----------- |
| `janklab.mlxshake.internal.MlxshakeBaseHandle` |  |

## Properties

<a name="janklab.mlxshake.internal.ApirefGenerator.outDir"></a>
### outDir

Helptext:


No helptext available.


<a name="janklab.mlxshake.internal.ApirefGenerator.inDirs"></a>
### inDirs

Helptext:


No helptext available.


<a name="janklab.mlxshake.internal.ApirefGenerator.opts"></a>
### opts

Helptext:


No helptext available.


<a name="janklab.mlxshake.internal.ApirefGenerator.mfiles"></a>
### mfiles

Helptext:


No helptext available.


<a name="janklab.mlxshake.internal.ApirefGenerator.packages"></a>
### packages

Helptext:


No helptext available.



## Methods

<a name="janklab.mlxshake.internal.ApirefGenerator.generateForMyFormat"></a>
### generateForMyFormat

Attributes: Abstract

Signature:
```
generateForMyFormat(this)
```

Helptext:

Generate the output in the subclass's output format.



<a name="janklab.mlxshake.internal.ApirefGenerator.forFormat"></a>
### forFormat

Attributes: Static

Signature:
```
out = ApirefGenerator.forFormat(varargin)
```

Helptext:

Construct an ApirefGenerator for a given format.



<a name="janklab.mlxshake.internal.ApirefGenerator.discover"></a>
### discover

Signature:
```
discover(this)
```

Helptext:

Discover source code files on the input paths.



<a name="janklab.mlxshake.internal.ApirefGenerator.generate"></a>
### generate

Signature:
```
generate(this)
```

Helptext:

Generate the doco output.



<a name="janklab.mlxshake.internal.ApirefGenerator.ApirefGenerator"></a>
### ApirefGenerator

Signature:
```
obj = ApirefGenerator()
```

Helptext:

Generates API Reference doco from source code.




