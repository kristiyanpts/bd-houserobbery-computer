fx_version 'cerulean'
game 'gta5'

author 'kristiyanpts'
description 'FiveM House Robbery Script - Computer Version'
version '1.0.0'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua'
}

client_scripts {
    'client/**/*.lua',
}

server_scripts {
    'server/**/*.lua',
}

files {
    "languages/*.json"
}

escrow_ignore {
    "shared/*.lua",
    "languages/*.json",
    "client/**/*.lua",
    "server/**/*.lua",
}
