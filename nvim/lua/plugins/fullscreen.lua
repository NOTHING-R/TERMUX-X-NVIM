return {
  "declancm/maximize.nvim",
  config = function()
    require("maximize").setup()
    vim.keymap.set("n", "<leader>ff", "<cmd>lua require('maximize').toggle()<cr>", { desc = "Maximize window" })
  end,
}
