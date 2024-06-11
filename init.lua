-- vim: noet ai ci pi sts=0 sw=4 ts=4

local modules = {
	'core.lazy',
	'core.settings',
	'core.mappings',
	'core.autocmds',
}

for _, module in ipairs(modules) do
	local ok, err = pcall(require, module)
	if not ok then
		error("Error loading " .. module .. "\n\n" .. err)
	end
end

-- vim.cmd('runtime autocmds.vim')
