fx_version 'cerulean'
games { 'gta5' }
author 'TacoTheDev'

lua54 'yes'

client_scripts {
    "client.lua"
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "server.lua"
}