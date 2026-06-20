## Dotfiles

This project is intended to be used with [chezmoi](https://www.chezmoi.io/).

If you want to apply it right away use `chezmoi init s3rius/dotfiles --apply --git-lfs`.

Otherwise:

```bash
chezmoi init s3rius/dotfiles --git-lfs

chezmoi apply
```
It also installs packages, so if you don't want that, please remove the `run_onchange_install-packages.sh.tmpl` file before applying.
