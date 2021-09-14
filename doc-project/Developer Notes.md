# MlxShake Developer Notes

## Workflow

To hack on the code:

```matlab
addpath Mcode; addpath dev-kit
```

and start hacking!

Rerun `mlxshake_gendoco` after all your changes to make sure things are still working, and to keep the User Guide up to date with current library behavior.

## Special Notes

Do not edit `README.md` or `docs/index.md` directly! These files are generated from shared sources in the `docs-src/` directory. Edit the files there instead.

## See Also

* The [`TODO` list](TODO.md).
* The [`Release Checklist.md`](Release Checklist.md) file.
