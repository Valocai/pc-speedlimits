fx_version 'cerulean'
game {'gta5'}

Author 'PickleCord'
description 'a dynamic speed limit display to your FiveM server. It shows a speed limit sign when players exceed the speed limit for the street they're driving on.'
version '1.0.0'

client_scripts {
    'client/client.lua'
}

shared_scripts {
    'shared/config.lua'
}

ui_page {
    'client/html/index.html'
}


files({
    'client/html/index.html',
    'client/html/assets/speed_limit_sign.png',
})
