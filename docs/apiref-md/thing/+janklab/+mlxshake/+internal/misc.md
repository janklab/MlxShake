# misc - janklab.mlxshake.internal

```text
janklab.mlxshake.internal.misc
```

## Helptext

```text
Miscellaneous utilities

The ones in this class are ones you typically wouldn't want to import.

  Documentation for janklab.mlxshake.internal.misc
     doc janklab.mlxshake.internal.misc



```

## Class Contents

### Methods

| Method | Description |
| -------- | ----------- |
| [setpackageappdata](#janklab.mlxshake.internal.misc.setpackageappdata) |  |
| [getpackageappdata](#janklab.mlxshake.internal.misc.getpackageappdata) |  |
| [mkdir](#janklab.mlxshake.internal.misc.mkdir) |  |
| [misc](#janklab.mlxshake.internal.misc.misc) | Constructor. |

## Methods

<a name="janklab.mlxshake.internal.misc.setpackageappdata"></a>
### setpackageappdata

Attributes: Static

Signature:
```
misc.setpackageappdata(key, value)
```

Helptext:

```text
janklab.mlxshake.internal.misc.setpackageappdata is a function.
  setpackageappdata(key, value)

```

<a name="janklab.mlxshake.internal.misc.getpackageappdata"></a>
### getpackageappdata

Attributes: Static

Signature:
```
out = misc.getpackageappdata(key)
```

Helptext:

```text
janklab.mlxshake.internal.misc.getpackageappdata is a function.
  out = getpackageappdata(key)

```

<a name="janklab.mlxshake.internal.misc.mkdir"></a>
### mkdir

Attributes: Static

Signature:
```
misc.mkdir(dir)
```

Helptext:

```text
MKDIR Make new directory.
  [SUCCESS,MESSAGE,MESSAGEID] = MKDIR(PARENTDIR,NEWDIR) makes a new
  directory, NEWDIR, under the parent, PARENTDIR. While PARENTDIR may be
  an absolute path, NEWDIR must be a relative path. When NEWDIR exists,
  MKDIR returns SUCCESS = 1.  If the number of output arguments is 1 or
  less, it also issues a warning that the directory already exists.

  [SUCCESS,MESSAGE,MESSAGEID] = MKDIR(NEWDIR) creates the directory
  NEWDIR in the current directory, if NEWDIR represents a relative path.
  Otherwise, NEWDIR represents an absolute path and MKDIR attempts to
  create the absolute directory NEWDIR in the root of the current volume.
  An absolute path starts in any one of a Windows drive letter, a UNC
  path '\' or a UNIX '/' character. 

  INPUT PARAMETERS:
      PARENTDIR: Character vector or string scalar 
                 specifying the parent directory. See NOTE 1.
      NEWDIR:    Character vector or string scalar specifying the new 
                 directory. 

  RETURN PARAMETERS:
      SUCCESS:   Logical scalar, defining the outcome of MKDIR. 
                 1 : MKDIR executed successfully. 0 : an error occurred.
      MESSAGE:   Character vector, defining the error or warning message. 
                 empty character array : MKDIR executed successfully. message :
                 an error or warning message, as applicable.
      MESSAGEID: Character vector, defining the error or warning identifier.
                 empty character array: MKDIR executed successfully. message id:
                 the MATLAB error or warning message identifier (see
                 ERROR, MException, WARNING, LASTWARN).

  NOTE 1: UNC paths are supported. 

  See also CD, COPYFILE, DELETE, DIR, FILEATTRIB, MOVEFILE, RMDIR.

```

<a name="janklab.mlxshake.internal.misc.misc"></a>
### misc

Signature:
```
obj = misc()
```

Helptext:

```text
Miscellaneous utilities

The ones in this class are ones you typically wouldn't want to import.

```


