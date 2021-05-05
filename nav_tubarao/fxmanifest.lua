fx_version 'adamant'

game 'gta5'

ui_page "nui/ui.html"

server_scripts {
	"@vrp/lib/utils.lua",
	'server.lua',
}

client_scripts {
	"@vrp/lib/utils.lua",
	'client.lua',
}

files {
	"nui/ui.html",
	"nui/ui.js",
	"nui/ui.css"
}
