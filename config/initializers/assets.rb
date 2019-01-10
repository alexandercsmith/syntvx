# TODO |CONFIG| Production : Update Asset Version & Notes if Changes before Deployment
# TODO [CONFIG] Production : Changes: /assets & /public & /vendor - Ext: .css .scss .js .coffee .json .jpg .jpeg .png

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
# 01-08-2018 : 10:00 PM : v1.30
# Format: '#.##' | after #.#9 Increment to New Decedant | if .99 = New Full Version
Rails.application.config.assets.version = '1.30'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
