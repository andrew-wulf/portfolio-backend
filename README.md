# Welcome!

## This is the backend API for my portfolio page, created with Ruby on Rails.
At the moment there are two projects which will utilize this backend, the main one being my twitter clone, 
and the second being Movie Battle, a multiplayer game I'm working on. This is to reduce the number of separate services I have up and running,
and 99% of the actual database usage comes from my twitter app.

So, for all intents and purposes, view this as my Twitter API!


## Twitter


# Usage

**Note: All requests must end with ".json"


## Logging In
Many of the controller actions first require user authentication. 

To create a new user, send a post request to '/users'.
This request takes in a number of required and optional parameters.

The following params are required:
- username (must be unique)
- email (must be unique)
- password
- password_confirmation (must be the same as password)
- display_name

These are optional:
- bio
- avi (image url)
- banner (image url)
- 

To "Log In" as a user:

`POST "/sessions.json

params: {email, password}`

If successful, you will recieve a jwt token.
To make requests as the user, put the following in each request header:

`{Authorization: Bearer [insert jwt here]}`







