return {
  "nvim-mini/mini.hipatterns",
  event = "BufReadPre",
  opts = {
    highlighters = {
      -- TODO / FIXME / etc
      fixme = {
        pattern = "%f[%w]()FIXME()%f[%W]",
        group = "MiniHipatternsFixme",
      },
      hack = {
        pattern = "%f[%w]()HACK()%f[%W]",
        group = "MiniHipatternsHack",
      },
      todo = {
        pattern = "%f[%w]()TODO()%f[%W]",
        group = "MiniHipatternsTodo",
      },
      note = {
        pattern = "%f[%w]()NOTE()%f[%W]",
        group = "MiniHipatternsNote",
      },

      -- Cores hex (#fff, #ffffff)
      hex_color = {
        pattern = "#%x%x%x%x?%x?%x?",
        group = function(_, match)
          return MiniHipatterns.compute_hex_color_group(match, "bg")
        end,
      },
    },
  },
}
