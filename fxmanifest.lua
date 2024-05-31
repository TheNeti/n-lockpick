fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'n-lockpick'
author 'TheNeti'
version '1.0.0'
description 'lockpick only for closed cars'
repository 'https://github.com/TheNeti/n-lockpick'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

client_script 'client/client.lua'

server_scripts {
    'server/server.lua',
    'server/version.lua'
}

dependency {
    'ox_target',
    'ox_lib',
    'ox_inventory'
}