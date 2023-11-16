-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.format_on_save = true
lvim.plugins = {
  "simrat39/rust-tools.nvim",
  "marko-cerovac/material.nvim",
  "sainnhe/sonokai",
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },
  "nvim-lua/lsp-status.nvim",
  {
    'j-hui/fidget.nvim',
    tag = "legacy",
    event = "LspAttach",
  }
}

-- rust-tools
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
local ok, rust_tools = pcall(require, "rust-tools")
if not ok then
  return
end
rust_tools.setup({
  server = {
    settings = {
      ["rust-analyzer"] = {
        lens = {
          enable = false,
        },
        checkOnSave = {
          command = "clippy",
        },
      },
    },
    on_attach = function(client, bufnr)
      require("lvim.lsp").common_on_attach(client, bufnr)
    end,
    on_init = require("lvim.lsp").common_on_init,
  },
})


-- copilot
local ok, copilot = pcall(require, "copilot")
if not ok then
  return
end

copilot.setup({
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = "<c-l>",
    },
  },
})

-- color
lvim.colorscheme = "sonokai"

-- fidget
local ok, fidget = pcall(require, "fidget")
if not ok then
  return
end

fidget.setup()
