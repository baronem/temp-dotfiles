return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	config = function()
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		local ufo = require("ufo")

		vim.keymap.set("n", "zo", "<cmd>foldopen<CR>", { desc = "Open this fold" })
		vim.keymap.set("n", "zO", ufo.openAllFolds, { desc = "Open folds" })

		vim.keymap.set("n", "zc", "<cmd>foldclose<CR>", { desc = "Close this fold" })
		vim.keymap.set("n", "zC", ufo.closeAllFolds, { desc = "Close folds" })

		vim.keymap.set("n", "zk", function()
			local win_id = ufo.peekFoldedLinesUnderCursor()
			if not win_id then
				vim.lsp.buf.hover()
			end
		end, { desc = "Peek fold" })

		ufo.setup({
			provider_selector = function(_, _, _)
				return { "lsp", "indent" }
			end,
		})
	end,
}
