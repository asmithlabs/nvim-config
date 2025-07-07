local M = {}

-- List of themes to cycle through
local themes = {
  "terafox",  -- nightfox variant
  "carbonfox", -- nightfox variant
  "tokyonight-night",
  "onedark",
}

local current_theme = nil

-- Apply a theme by name
function M.apply(theme)
  if theme == "onedark" then
    require("onedark").setup({
      style = "warmer", -- options: darker, cool, deep, warm, warmer, light
    })
    require("onedark").load()
  else
    vim.cmd.colorscheme(theme)
  end
  current_theme = theme
  vim.notify("Theme set to: " .. theme)
end

-- Toggle to the next theme in the list
function M.toggle()
  local i = 1
  for idx, t in ipairs(themes) do
    if t == current_theme then
      i = idx
      break
    end
  end
  local next = (i % #themes) + 1
  M.apply(themes[next])
end

-- Automatically choose based on time
function M.auto()
  local hour = tonumber(os.date("%H"))
  local selected = (hour >= 6 and hour < 18) and "terafox" or "carbonfox"
  M.apply(selected)
end

return M
