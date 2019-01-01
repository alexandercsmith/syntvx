# S Y N T V X

[SYNTVX](http://www.syntvx.com)

Created by: Alexander Smith

A Developer Resource Directory Project.

## Specs & Services

* Rails 5.2.2
* Ruby 2.5.1
* PostgreSQL
* Heroku
* Memcachier
* Google Analytics
* Google AdSense

## To-Do

1. Implement Advertising and Analytics
    [X] - Google Analytics
    [ ] - Google AdSense - Need more Content
2. Feature: Comments
  * Implement: Terms & Conditions | Privacy Policy
  * $ rails g scaffold Comment
    * email:string:uniq
    * first_name
    * last_name
    * message:string
    * published:boolean(false)
    * published_at:datetime
    * admin_made:boolean(false)
  * Implement: Email Check
    * return if Contact.blocked
  * Admin - Comment Management
    * Articles 'admins/articles#show' -> Comments
    * Tools 'admins/tools#show' -> Comments
    * Query: All | Published | Admin
    * Action: Publish | Destroy
  * Callback: after_create : create_contact
    * $ rails g scaffold Contact
      * first_name
      * last_name
      * email:string:uniq
      * blocked:boolean(false)
      * terms:boolean(false)
      * terms_date:datetime
    * Admin - Contact Management
      * Block - Email -> Blocked
      * Delete All Comments of Contact
  * $ rails g model ArticleComment
    * article:references
    * comment:references
  * $ rails g model ToolComment
    * tool:references
    * comment:references
  * Implement: Form -> Captcha

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
