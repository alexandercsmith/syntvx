# S Y N T V X

[SYNTVX](http://www.syntvx.com)

Created by: Alexander Smith

A Developer Resource Directory Project.

## Specs & Services

* Framework: Rails 5.2.2
* Language:  Ruby 2.5.1
* Database:  PostgreSQL
* Hosting:   Heroku
* Cache:     Heroku Redis
* Analytics: Google Analytics
* Ads:       Google AdSense
* Storage:   AWS S3 - 'https://assets.syntvx.com/'
* Domain:    AWS Route53

## Development Start

Install Dependencies & Database

```
# Install Dependencies
$ bundle install

# Create Database - If First Session
$ rails db:create

# Migrate Database - If First Session
$ rails db:migrate
```

## Development Server

```
# Check Developer Notes and Tasks
$ rails notes

# Start Development Cache
$ rails dev:cache

# Start Rails Server
$ rails server
```

## Development Console

```
# Access Console
$ rails console

# View Routing
$ rails routes

# View Application Stats
$ rails stats

# View Developer Notes
$ rails notes
```

## Deployment

```
# Check Notes for Config Tasks
$ rails notes

# Stage Git
$ git add .
$ git commit -m "{message}"
```

## Github

```
$ git push -u origin master
```


## Heroku

```
# Deploy
$ git push heroku master

# Database Migration
$ heroku run rails db:migrate

# Console
$ heroku run rails console

# Bash
$ heroku run bash

# Dynos
$ heroku ps

# Database
$ heroku pg

# Redis Stats
# heroku redis:info

# Logs
$ heroku logs --tail
```
