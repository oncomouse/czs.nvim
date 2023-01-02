if vim.opt.cmdheight:get() == 0 then
	require("czs").setup()
	if not vim.g.czs_do_not_map then
		vim.keymap.set("n", "n", "<Plug>(czs-move-n)")
		vim.keymap.set("n", "N", "<Plug>(czs-move-N)")
	end
end
