local M = {}

local update_config = function(opts)
  local config = require('femaco.config')
  opts = opts or {}
  for key, value in pairs(opts) do
    config.settings[key] = value
  end
end

local create_commands = function()
  vim.api.nvim_create_user_command('FeMaco', function(params)
    if params.fargs[1] then
      if params.range > 0 then
        require('femaco.edit').edit_code_block_manual(params.fargs[1], params.line1 - 1, params.line2)
      else
        require('femaco.edit').edit_code_block_manual(params.fargs[1])
      end
      return
    end

    if params.range > 0 then
      require('femaco.edit').edit_code_block_auto(params.line1 - 1, params.line2)
    else
      require('femaco.edit').edit_code_block_auto()
    end
  end, { nargs = "*", range = true, complete = 'filetype' })
end

M.setup = function(opts)
  update_config(opts)
  create_commands()
end

return M
