---@meta autocmd
---@class callback_param
---@field id (number) #autocommand id
---@field event (string) #event name of the triggered event autocmd-events
---@field group (number|nil) #autocommand group id, if any
---@field match (string) #expanded value of <amatch>
---@field buf (number) #expanded value of <abuf>
---@field file (string) #expanded value of <afile>
---@field data (any) #arbitrary data passed from nvim_exec_autocmds()
---@class nvim_clear_autocmds_opts1
---@field event (string|nil) #event name of the triggered event autocmd-events
---@field group (string|integer|nil) #autocommand group name or id to match against.
---@field pattern (string|string[]|nil) #pattern(s) to match literally autocmd-pattern.
---@class nvim_clear_autocmds_opts2
---@field event (string|nil) #event name of the triggered event autocmd-events
---@field group (string|integer|nil) #autocommand group name or id to match against.
---@field buffer (integer|nil) #buffer number for buffer-local autocommands autocmd-buflocal. Cannot be used with {pattern}.
---@alias nvim_clear_autocmds_opts nvim_clear_autocmds_opts1|nvim_clear_autocmds_opts2
---@class nvim_create_autocmd_opts
---@field command (string|nil) #Vim command to execute on event. Cannot be used with {callback}
---@field once (boolean|nil) #defaults to false. Run the autocommand only once autocmd-once.
---@field nested (boolean|nil) #defaults to false. Run nested autocommands autocmd-nested.
---@field group (string|integer|nil) #autocommand group name or id to match against.
---@field pattern (string|string[]|nil) #pattern(s) to match literally autocmd-pattern.
---@field buffer (integer|nil) #buffer number for buffer-local autocommands autocmd-buflocal. Cannot be used with {pattern}.
---@field desc (string|nil) #description (for documentation and troubleshooting).
---@field callback ((fun(callback_param):boolean)|string|nil) #Lua function (or Vimscript function name, if string) called when the event(s) is triggered. Lua callback can return true to delete the autocommand, and receives a table argument.
---@alias nvim_event "BufAdd"|"BufDelete"|"BufEnter"|"BufFilePost"|"BufFilePre"|"BufHidden"|"BufLeave"|"BufModifiedSet"|"BufNew"|"BufNewFile"|"BufRead"|"BufWinLeave"|"BufWipeout"|"BufWrite"|"BufWriteCmd"|"BufWritePost"|"ChanInfo"|"ChanOpen"|"CmdUndefined"|"CmdlineChanged"|"CmdlineEnter"|"CmdlineLeave"|"CmdwinEnter"|"CmdwinLeave"|"ColorScheme"|"ColorSchemePre"|"CompleteChanged"|"CompleteDonePre"|"CompleteDone"|"CursorHold"|"CursorHoldI"|"CursorMoved"|"CursorMovedI"|"DiffUpdated"|"DirChanged"|"DirChangedPre"|"ExitPre"|"FileAppendCmd"|"FileAppendPost"|"FileAppendPre"|"FileChangedRO"|"FileChangedShell"|"FocusGained"|"FileChangedShellPost"|"FileReadCmd"|"FileReadPost"|"FileReadPre"|"FileType"|"FileWriteCmd"|"FileWritePost"|"FileWritePre"|"FilterReadPost"|"FilterReadPre"|"FilterWritePost"|"FilterWritePre"|"FocusGained"|"FocusLost"|"FuncUndefined"|"UIEnter"|"UILeave"|"InsertChange"|"InsertCharPre"|"InsertEnter"|"InsertLeavePre"|"InsertLeave"|"MenuPopup"|"ModeChanged"|"OptionSet"|"QuickFixCmdPre"|"QuickFixCmdPost"|"QuitPre"|"RemoteReply"|"SearchWrapped"|"RecordingEnter"|"RecordingLeave"|"SafeState"|"SessionLoadPost"|"ShellCmdPost"|"Signal"|"ShellFilterPost"|"SourcePre"|"SourcePost"|"SourceCmd"|"SpellFileMissing"|"StdinReadPost"|"StdinReadPre"|"SwapExists"|"Syntax"|"TabEnter"|"TabLeave"|"TabNew"|"TabNewEntered"|"TabClosed"|"TermOpen"|"TermEnter"|"TermLeave"|"TermClose"|"TermResponse"|"TextChanged"|"TextChangedI"|"TextChangedP"|"TextChangedT"|"TextYankPost"|"User"|"UserGettingBored"|"VimEnter"|"VimLeave"|"VimLeavePre"|"VimResized"|"VimResume"|"VimSuspend"|"WinClosed"|"WinEnter"|"WinLeave"|"WinNew"|"WinScrolled"|"WinResized"|"LspAttach"
---@alias nvim_autocmd_event nvim_event|nvim_event