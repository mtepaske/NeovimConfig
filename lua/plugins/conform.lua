return {
  "stevearc/conform.nvim",

  opts = {
    formatters_by_ft = {
      python = { "ruff_fix", "black" },

      lua = { "stylua" },

      javascript = { "prettier" },
      typescript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
    },

    format_on_save = {
      timeout_ms = 5000,
      lsp_fallback = true,
    },
  },
}
