# S Y N T V X

[SYNTVX](http://www.syntvx.com)

Created by: Alexander Smith

A Developer Resource Directory Project.

## Specs & Services

* Framework: Rails 5.2.2
* Language: Ruby 2.5.1
* Database: PostgreSQL
* Hosting: Heroku
* Cache: Memcachier
* Analytics: Google Analytics
* Advertising: Google AdSense
* Storage: AWS S3
* Domain: AWS Route53

## Development

Install Dependencies & Database

```
# Install Dependencies
$ bundle install

# Create Database - If First Session
$ rails db:create

# Migrate Database - If First Session
$ rails db:migrate
```

Initiate Server & Cache after Check

```
# Check Developer Notes and Tasks
$ rails notes

# Start Development Cache
$ rails dev:cache

# Start Rails Server
$ rails server
```

Console Commands

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

Prep App Deployment

```
# Check Notes for Config Tasks
$ rails notes

# Stage Git
$ git add .
$ git commit -m "{message}"
```

Push to Github Repository

```
$ git push -u origin master
```

Deploy App to Heroku

```
$ git push heroku master
```

Migrate Database if Schema Updates

```
$ heroku run rails db:migrate
```

## Server Operations

```
# Console
$ heroku run rails console

# Bash
$ heroku run bash

# Dynos
$ heroku ps

# Database
$ heroku pg

# Logs
$ heroku logs --tail
```
