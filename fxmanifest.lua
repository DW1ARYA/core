fx_version 'cerulean'
game 'gta5'

description 'DWAS-Core'
version '1.0.0'

shared_scripts {
    'config.lua',
    'shared/*.lua',
    'locale/en.lua',
    'locale/*.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

dependency 'oxmysql'

provide 'dwas-core'

lua54 'yes'
use_experimental_fxv2_oal 'yes'