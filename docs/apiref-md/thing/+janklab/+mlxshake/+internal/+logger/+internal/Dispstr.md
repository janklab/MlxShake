# Dispstr - janklab.mlxshake.internal.logger.internal

```text
janklab.mlxshake.internal.logger.internal.Dispstr
```

## Helptext

```text
All the dispstr implementation code, wrapped up in a class

We make it a class so that all the definitions can live in a single
file, which makes it easy (well, maybe not easy, just not a huge pain in the
ass) to transform the code to relocate its package, which will hopefully
allow us to generate "compatters" for internal use by other libraries that
don't want to take a dependency on dispstr.

  Documentation for janklab.mlxshake.internal.logger.internal.Dispstr
     doc janklab.mlxshake.internal.logger.internal.Dispstr



```

## Class Contents

### Methods

| Method | Description |
| -------- | ----------- |
| [sprintfv](#janklab.mlxshake.internal.logger.internal.Dispstr.sprintfv) |  |
| [size2str](#janklab.mlxshake.internal.logger.internal.Dispstr.size2str) |  |
| [prettyprintTabular_generic](#janklab.mlxshake.internal.logger.internal.Dispstr.prettyprintTabular_generic) |  |
| [prettyprintTabular](#janklab.mlxshake.internal.logger.internal.Dispstr.prettyprintTabular) |  |
| [prettyprintStruct](#janklab.mlxshake.internal.logger.internal.Dispstr.prettyprintStruct) |  |
| [prettyprintCell](#janklab.mlxshake.internal.logger.internal.Dispstr.prettyprintCell) |  |
| [prettyprintMatrix](#janklab.mlxshake.internal.logger.internal.Dispstr.prettyprintMatrix) |  |
| [prettyprintArray](#janklab.mlxshake.internal.logger.internal.Dispstr.prettyprintArray) |  |
| [num2cellstr](#janklab.mlxshake.internal.logger.internal.Dispstr.num2cellstr) |  |
| [mycombvec](#janklab.mlxshake.internal.logger.internal.Dispstr.mycombvec) |  |
| [isErrorIdentifier](#janklab.mlxshake.internal.logger.internal.Dispstr.isErrorIdentifier) |  |
| [dispc](#janklab.mlxshake.internal.logger.internal.Dispstr.dispc) |  |
| [dispStruct](#janklab.mlxshake.internal.logger.internal.Dispstr.dispStruct) |  |
| [dispCell](#janklab.mlxshake.internal.logger.internal.Dispstr.dispCell) |  |
| [display](#janklab.mlxshake.internal.logger.internal.Dispstr.display) |  |
| [disp](#janklab.mlxshake.internal.logger.internal.Dispstr.disp) |  |
| [convertArgsForPrintf](#janklab.mlxshake.internal.logger.internal.Dispstr.convertArgsForPrintf) |  |
| [Dispstr](#janklab.mlxshake.internal.logger.internal.Dispstr.Dispstr) |  |

## Methods

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.sprintfv"></a>
### sprintfv

Attributes: Static

Signature:
```
out = Dispstr.sprintfv(format, varargin)
```

Helptext:

```text
SPRINTFV "Vectorized" sprintf

out = sprintfv(format, varargin)

SPRINTFV is an array-oriented form of sprintf that applies a format to array
inputs and produces a cellstr.

This is not a high-performance method. It's a convenience wrapper around a
loop around sprintf().

Returns cellstr.

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.size2str"></a>
### size2str

Attributes: Static

Signature:
```
out = Dispstr.size2str(sz)
```

Helptext:

```text
SIZE2STR Format an array size for display

out = size2str(sz)

Sz is an array of dimension sizes, in the format returned by SIZE.

Examples:

size2str(magic(3))

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.prettyprintTabular_generic"></a>
### prettyprintTabular_generic

Attributes: Static

Signature:
```
out = Dispstr.prettyprintTabular_generic(varargin)
```

Helptext:

```text
A generic tabular pretty-print that can be used for tabulars or relations

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.prettyprintTabular"></a>
### prettyprintTabular

Attributes: Static

Signature:
```
out = Dispstr.prettyprintTabular(t)
```

Helptext:

```text
PRETTYPRINT_TABULAR Tabular implementation of prettyprint

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.prettyprintStruct"></a>
### prettyprintStruct

Attributes: Static

Signature:
```
out = Dispstr.prettyprintStruct(s)
```

Helptext:

```text
PRETTYPRINT_STRUCT struct implementation of prettyprint

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.prettyprintCell"></a>
### prettyprintCell

Attributes: Static

Signature:
```
out = Dispstr.prettyprintCell(c)
```

Helptext:

```text
PRETTYPRINT_CELL Cell implementation of prettyprint

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.prettyprintMatrix"></a>
### prettyprintMatrix

Attributes: Static

Signature:
```
out = Dispstr.prettyprintMatrix(strs)
```

Helptext:

```text
Pretty-print a matrix of arbitrary display strings

out = prettyprintMatrix(strs)

strs is a matrix of strings which are already converted to their display
form.

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.prettyprintArray"></a>
### prettyprintArray

Attributes: Static

Signature:
```
out = Dispstr.prettyprintArray(strs)
```

Helptext:

```text
PRETTYPRINT_ARRAY Pretty-print an array from dispstrs

out = prettyprintArray(strs)

strs (string) is an array of display strings of any size.

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.num2cellstr"></a>
### num2cellstr

Attributes: Static

Signature:
```
out = Dispstr.num2cellstr(x)
```

Helptext:

```text
NUM2CELLSTR Like num2str, but return cellstr of individual number strings

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.mycombvec"></a>
### mycombvec

Attributes: Static

Signature:
```
out = Dispstr.mycombvec(vecs)
```

Helptext:

```text
MYCOMBVEC All combinations of values from vectors

This is similar to Matlab's combvec, but has a different signature.

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.isErrorIdentifier"></a>
### isErrorIdentifier

Attributes: Static

Signature:
```
out = Dispstr.isErrorIdentifier(str)
```

Helptext:

```text
janklab.mlxshake.internal.logger.internal.Dispstr.isErrorIdentifier is a function.
  out = janklab.mlxshake.internal.logger.internal.Dispstr.isErrorIdentifier(str)

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.dispc"></a>
### dispc

Attributes: Static

Signature:
```
out = Dispstr.dispc(x)
```

Helptext:

```text
DISPC Display, with capture

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.dispStruct"></a>
### dispStruct

Attributes: Static

Signature:
```
Dispstr.dispStruct(x)
```

Helptext:

```text
janklab.mlxshake.internal.logger.internal.Dispstr.dispStruct is a function.
  janklab.mlxshake.internal.logger.internal.Dispstr.dispStruct(x)

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.dispCell"></a>
### dispCell

Attributes: Static

Signature:
```
Dispstr.dispCell(c)
```

Helptext:

```text
janklab.mlxshake.internal.logger.internal.Dispstr.dispCell is a function.
  janklab.mlxshake.internal.logger.internal.Dispstr.dispCell(c)

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.display"></a>
### display

Attributes: Static

Signature:
```
Dispstr.display(x)
```

Helptext:

```text
DISPLAY Display array.
  DISPLAY(X) is called for the object X when the semicolon is not used
  to terminate a statement. 

  For example,
    X = datetime(2014,1:5,1)
  calls DISPLAY(X) while
    X = datetime(2014,1:5,1);
  does not.

  A typical implementation of DISPLAY calls DISP to do most of the work.
  To customize the display of objects, overload the DISP function.
  Note that DISP does not display empty arrays.
  
  See also disp, formattedDisplayText, matlab.mixin.CustomDisplay.

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.disp"></a>
### disp

Attributes: Static

Signature:
```
Dispstr.disp(x)
```

Helptext:

```text
DISP Display array.
  DISP(X) displays array X without printing the array name or 
  additional description information such as the size and class name.
  In all other ways it is the same as leaving the semicolon off an
  expression except that nothing is shown for empty arrays.

  If X is a string or character array, the text is displayed.

  See also formattedDisplayText, sprintf, num2str, format, details.

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.convertArgsForPrintf"></a>
### convertArgsForPrintf

Attributes: Static

Signature:
```
out = Dispstr.convertArgsForPrintf(args)
```

Helptext:

```text
janklab.mlxshake.internal.logger.internal.Dispstr.convertArgsForPrintf is a function.
  out = janklab.mlxshake.internal.logger.internal.Dispstr.convertArgsForPrintf(args)

```

<a name="janklab.mlxshake.internal.logger.internal.Dispstr.Dispstr"></a>
### Dispstr

Signature:
```
obj = Dispstr()
```

Helptext:

```text
All the dispstr implementation code, wrapped up in a class

We make it a class so that all the definitions can live in a single
file, which makes it easy (well, maybe not easy, just not a huge pain in the
ass) to transform the code to relocate its package, which will hopefully
allow us to generate "compatters" for internal use by other libraries that
don't want to take a dependency on dispstr.

  Documentation for janklab.mlxshake.internal.logger.internal.Dispstr/Dispstr
     doc janklab.mlxshake.internal.logger.internal.Dispstr


```


