# README

# WHAT IS THE APPLICATION?
This application is meant to service the Human Environment and Animal Team. This keeps track of all their events and meetings, allowing them to create, modify, and delete them as they please.
It also keeps track of organization members and their attendance which awards them points. Additionally, there are available links to relevent sites such as social media.

# Requirements
Environment
  - Docker Engine v24.0.7

Program
  - Ruby V3.1.2
  - Rails V7.0.2

Tools
  - GitHub Main Branch: https://github.com/JNC909/heat
  - Jira
  - Heroku

# External Deps
- Docker - Download latest version at https://www.docker.com/products/docker-desktop
- Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli
- Git - Downloat latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

# Documentation
Our product and sprint backlog can be found in Jira, with organization name [heatcsce431] and project name [heatproject]

Document
•	Data Design Sprint 3 v2

# Downloading code
In a terminal of your choice (PowerShell, for example), type "git clone https://github.com/JNC909/heat.git"

# Setting up data base and installations
Type the following in the terminal
  (optional) "rails db:drop"
  "rails db:create"
  "rails db:migrate"
  "bundle install"

# I
Anytime you modify the database, you will need to run "rails db:migrate again" or you can do all 3 rails commands if it makes you feel better.
Any time you modify the gemfile to add something, you will need to run "bundle install"

# Running the application
Type in "rails server --binding=0.0.0.0"
If you're on windows, go on to a browser and type "localhost" in the search bar (Not google's search bar)
