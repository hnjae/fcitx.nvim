local M = {}

local fcitx_cmd = ""
if vim.fn.executable("fcitx5-remote") == 1 then
  fcitx_cmd = "fcitx5-remote"
else
  fcitx_cmd = "fcitx-remote"
end

local function Fcitx2Latin()
  if tonumber(vim.fn.system(fcitx_cmd)) ~= 2 then
    return
  end

  vim.w._fcitx_non_latin = true
  io.popen(fcitx_cmd .. " -c")
end

local function Fcitx2NonLatin(cmd)
  if not vim.w._fcitx_non_latin then
    return
  end

  -- Needs sleep to prevent fcitx5-hangul's issue in text-input-v3
  io.popen(cmd)
  vim.w._fcitx_non_latin = false
end

local opts_default = {
  ---@type number?
  sleep = 0,

  ---@type boolean?|fun(): boolean
  enable = function()
    return vim.fn.has("linux") == 1
      and os.getenv("SSH_TTY") == nil
      and os.getenv("DISPLAY") ~= nil
      and os.getenv("XMODIFIERS") == "@im=fcitx"
      and vim.fn.executable(fcitx_cmd) == 1
  end,
}

M.setup = function(opts)
  opts = vim.tbl_deep_extend("keep", opts, opts_default)
  if type(opts.enable) ~= "function" and not opts.enable or (not opts.enable()) then
    return
  end

  local to_nonlatin_cmd
  if opts.sleep == nil or opts.sleep <= 0 then
    to_nonlatin_cmd = fcitx_cmd .. " -o"
  else
    to_nonlatin_cmd = "sleep " .. opts.sleep .. " && " .. fcitx_cmd .. " -o"
  end

  local au_id = vim.api.nvim_create_augroup("fcitx", {})

  vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    group = au_id,
    desc = "Switch IME if needed.",
    callback = function()
      Fcitx2NonLatin(to_nonlatin_cmd)
    end,
  })

  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    group = au_id,
    desc = "Switch IME to latin.",
    callback = Fcitx2Latin,
  })
end

return M
