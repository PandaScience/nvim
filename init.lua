-- vim: noet ai ci pi sts=0 sw=4 ts=4

local modules = {
	"core.lazy",
	"core.settings",
	"core.mappings",
	"core.autocmds",
}

if vim.g.vscode then
	-- TODO https://medium.com/@nikmas_dev/vscode-neovim-setup-keyboard-centric-powerful-reliable-clean-and-aesthetic-development-582d34297985
	-- require("core.settings")
else
	for _, module in ipairs(modules) do
		local ok, err = pcall(require, module)
		if not ok then error("Error loading " .. module .. "\n\n" .. err) end
	end
end
