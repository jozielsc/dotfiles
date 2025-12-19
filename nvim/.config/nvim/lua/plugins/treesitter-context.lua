return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufReadPre",
  opts = {
    enable = true,
    max_lines = 5, -- quantas linhas ficam fixas
    trim_scope = "outer", -- outer | inner
    mode = "cursor", -- cursor | top_line
    separator = "─",
    zindex = 20,
  },
}
