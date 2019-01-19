# TODO |CONFIG| Production : Update Asset Version & Notes if Changes before Deployment
# TODO [CONFIG] Production : Changes: /assets & /public & /vendor - Ext: .css .scss .js .coffee .json .jpg .jpeg .png

# Version of your assets, change this if you want to expire all your assets.
# 01-19-2018 : 2:00 AM : v1.64
# Format: '#.##' | after #.#9 Increment to New Decedant | if .99 = New Full Version
Rails.application.config.assets.version = '1.64'

Rails.application.config.assets.paths << Rails.root.join('node_modules')

Rails.application.config.assets.paths << Rails.root.join("app", "assets", "fonts")
