-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.ui = {
  tabufline = {
    order = { "treeOffset", "buffers" },
  },
  statusline = {
    theme = "vscode_colored",
    separator_style = "block",
  }
}

M.base46 = {
	theme = "radium",
}

return M
