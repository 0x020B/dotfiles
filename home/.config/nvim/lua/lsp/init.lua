require('mason').setup {
    github = {
        download_url_template = "https://ghproxy.com/https://github.com/%s/releases/download/%s/%s"
    },
    ui = {
        check_outdated_packages_on_open = true
    }
}

require('mason-lspconfig').setup { automatic_installation = true }
require('mason-lspconfig').setup_handlers {
	function (server_name)
		require('lspconfig')[server_name].setup {}
	end
}
