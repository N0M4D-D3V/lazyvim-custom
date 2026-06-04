-- ~/.config/nvim/lua/plugins/snacks.lua
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = false,
          },
          grep = {
            hidden = true,
            ignored = false,
          },
          explorer = {
            hidden = true,
            ignored = false,
            follow_file = true,
            git_status = true,
          },
        },
      },
    },
  },
}
