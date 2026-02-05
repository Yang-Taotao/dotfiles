return {
  "AlexvZyl/nordic.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nordic").setup({
      transparent = {
        bg = true, -- Main editor background transparent
        float = false, -- Keep floating windows (e.g., Telescope) opaque
      },
    })
    require("nordic").load()
  end,
}
