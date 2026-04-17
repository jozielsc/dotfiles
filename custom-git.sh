#!/bin/bash

# Pager
git config --global core.pager "delta --paging=always"

# Cores
git config --global color.ui always

# Delta base
git config --global delta.navigate true
git config --global delta.side-by-side false
git config --global delta.line-numbers true
git config --global delta.syntax-theme "Dracula"

# Visual
git config --global delta.features "decorations"
git config --global delta.file-style "bold yellow"
git config --global delta.hunk-header-style "file line-number syntax"

# Cores refinadas
git config --global delta.plus-style "syntax #025824"
git config --global delta.minus-style "syntax #740001"

# Qualidade de diff
git config --global delta.whitespace-error-style "22 reverse"
git config --global delta.inline-hunk-style "syntax"

# Commits
git config --global delta.commit-decoration-style "bold yellow"
git config --global delta.commit-style "raw"

# Leitura
git config --global delta.zero-style "dim"

# Blame
git config --global delta.blame-palette "rgb(180,180,180)"

# Integração
git config --global interactive.diffFilter "delta --color-only"
