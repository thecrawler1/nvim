local options = {
  workspaces = {
    {
      name = "work",
      path = "~/tasks/work",
      overrides = {
        notes_subdir = "todo",
        new_notes_location = "todo",
      },
    },
  },
  notes_subdir = "notes",
  new_notes_location = "notes_subdir",
  daily_notes = {
    folder = "dailies",
    date_format = "%Y-%m-%d",
    alias_format = "%Y-%m-%d",
    default_tags = { "daily" },
  },
  mappings = {
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    ["<leader>cn"] = {
      action = function()
        -- Get the current line number and content
        local line_number = vim.api.nvim_win_get_cursor(0)[1]
        local line = vim.api.nvim_get_current_line()

        -- Remove list markers and leading/trailing whitespaces
        local cleaned_line = line:gsub("^%s*[-*]%s*%[.%]%s*", "") -- For list items with checkboxes
          :gsub("^%s*[-*]%s*", "")            -- For plain list items
          :gsub("^%s*", "")                  -- Remove leading spaces
          :gsub("%s*$", "")                  -- Remove trailing spaces

        if cleaned_line == "" then
          print("Error: Line is empty or invalid")
          return
        end

        -- Find the start and end positions of the cleaned text in the original line
        local start_col = line:find(cleaned_line, 1, true) - 1 -- Convert to 0-based indexing
        local end_col = start_col + #cleaned_line

        -- Properly select the text in visual mode
        vim.api.nvim_win_set_cursor(0, {line_number, start_col}) -- Move to the start of the cleaned text
        vim.cmd("normal! v") -- Enter visual mode
        vim.api.nvim_win_set_cursor(0, {line_number, end_col}) -- Extend selection to the end of the cleaned text

        -- Call :ObsidianLinkNew, which will replace the selected text
        vim.cmd("ObsidianLinkNew")
      end,
      opts = { buffer = true },
    },
  },
  note_id_func = function()
    return tostring(os.time())
  end,
}

return options
