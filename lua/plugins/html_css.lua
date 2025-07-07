return {
	"Jezda1337/nvim-html-css",
	dependencies = {
		"hrsh7th/nvim-cmp",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		enable_on = {
			"html",
			"htmldjango",
			"tsx",
			"jsx",
			"erb",
			"svelte",
			"vue",
			"blade",
			"php",
			"templ",
			"astro",
			"heex", -- Phoenix LiveView templates
			"leex", -- Legacy Phoenix templates
		},
		handlers = {
			definition = {
				bind = "gd",
			},
			hover = {
				bind = "K",
				wrap = true,
				border = "none",
				position = "cursor",
			},
		},
		documentation = {
			auto_show = true,
		},
		style_sheets = {
			"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
			"https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
			"./assets/css/app.css", -- adjust to your Phoenix project's actual compiled CSS path
		},
	},
}
