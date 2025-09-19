return {
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				size = 15,
				direction = "horizontal", -- open at the bottom
				shade_terminals = true,
			})

			local Terminal = require("toggleterm.terminal").Terminal
			local python_runner = Terminal:new({
				hidden = true,
				direction = "horizontal",
			})

			-- Function to run current Python file
			function _RUN_PYTHON()
				local file = vim.fn.expand("%:p") -- full path of current file
				python_runner:toggle()
				if python_runner:is_open() then
					python_runner:send("python " .. file)
				end
			end

			-- Alt+y → run Python file in bottom terminal
			vim.keymap.set("n", "<A-y>", _RUN_PYTHON, { noremap = true, silent = true })

			-- Alt+p → close the Python terminal
			vim.keymap.set("n", "<A-p>", function()
				if python_runner:is_open() then
					python_runner:close()
				end
			end, { noremap = true, silent = true })
		end,
	},
}
