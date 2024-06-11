vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

AniState = false
SusMode = false

local function StatusLineChange()
    local current_time = os.date("%d-%m-%Y %H:%M")
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
    local mode = string.upper(vim.api.nvim_get_mode().mode)

    local ani_symbol = "OwU "
    if (SusMode) then
        if (AniState) then
            ani_symbol = "B==D"
        else
            ani_symbol = "B=D "
        end
    else
        if (AniState) then
            ani_symbol = "UwU "
        end
    end

    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local line_number = cursor_pos[1]

    local total_lines = vim.api.nvim_buf_line_count(0)

    local line_percent = math.floor((line_number/total_lines)*100)
    
    vim.o.statusline = ani_symbol .. " " .. current_time .. " %<%f %h%m%r%=%-14.(%l,%c%V%) %P"
end

local repeat_timer = vim.loop.new_timer()

repeat_timer:start(0, 1, vim.schedule_wrap(
    function()
        StatusLineChange()
    end)
)


local anim_timer = vim.loop.new_timer()

anim_timer:start(0, 1000, vim.schedule_wrap(
    function ()
        AniState = not AniState
    end
))

function Sus()
    SusMode = not SusMode
end

vim.cmd([[command! -nargs=0 Sus lua Sus()]])


vim.cmd('highlight CursorLine guibg=#303030')

vim.cmd([[
    autocmd InsertEnter * highlight CursorLine guibg=#303030
    autocmd InsertLeave * highlight CursorLine guibg=NONE
]])


print("Welcome Loser!")
