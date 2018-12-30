# S Y N T V X

Created by: Alexander Smith

A Developer Resource Directory Project.

## Specs & Services

* Rails 5.2.2
* Ruby 2.5.1
* PostgreSQL
* Heroku
* Google Analytics
* Google AdSense

## Development

Install Dependencies & Database

```
$ bundle install

$ rails db:create

$ rails db:migrate
```

Initiate Server & Cache

```
$ rails dev:cache

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
# Check Notes for Config Points
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
