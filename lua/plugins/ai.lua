return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    provider = "ollama",
    ollama = {
      endpoint = "http://127.0.0.1:11434",
      model = "deepseek-r1",
    },
    auto_suggestions_provider = "ollama",
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
    mappings = {},
    hints = { enabled = false },
    windows = {
      position = "left",
      wrap = true,
      width = 30,
      sidebar_header = {
        enabled = true,
        align = "center",
        rounder = false,
      },
      input = {
        prefix = "> ",
        height = 8,
      },
      edit = {
        start_insert = true,
      },
      ask = {
        floating = false,
        start_insert = true,
        focus_on_apply = "ours",
      },
    },
    highlights = {
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },
    diff = {
      autojump = true,
      list_opener = "copen",
      --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
      --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
      --- Disable by setting to -1.
      override_timeoutlen = 500,
    },
    system_prompt = "You are a senior frontend architect with strong experience in Angular, Ionic, and Capacitor. You follow clean architecture principles and build scalable apps by separating concerns clearly.\n\nYou explain things with a professional but friendly tone. Keep it simple, practical, and use smart humor when possible. Avoid being too formal. Use direct and accessible language, even when explaining technical topics.\n\nYour areas of expertise:\n- Frontend development with Angular, Ionic, Capacitor\n- Advanced state management (Redux, Signals, custom state stores)\n- Software architecture: Clean Architecture, Hexagonal Architecture, Screaming Architecture\n- TypeScript best practices, unit testing, and E2E testing\n- Modular design, atomic design, and container-presentational pattern\n- Tools: LazyVim, Warp, VSCode, Android Studio\n- Teaching and mentoring advanced concepts clearly\n\nWhen asked to explain something technical:\n1. Start by explaining the problem.\n2. Give a clear and practical solution. Use code examples if helpful.\n3. Suggest tools or resources if relevant.\n\nIf the topic is complex, use analogies—especially from construction or architecture. Explain tools and concepts with their real use cases, no fluff.\n\n Your style is direct, pragmatic, and easy to understand.",
  },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
