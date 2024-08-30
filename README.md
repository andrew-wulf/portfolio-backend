
## Welcome! This is the backend API for my portfolio page, created with Ruby on Rails.
At the moment there are two projects which will utilize this backend, the main one being my twitter clone, 
and the second being Movie Battle, a multiplayer game I'm working on. This is to reduce the number of separate services I have up and running,
and 99% of the actual database usage comes from my twitter app.

So, for all intents and purposes, view this as my Twitter API!


# Twitter


## Breakdown

The goal of the API is to give all the basic functionality of twitter.

You can create as many users as you like. Each user can have a bio, avatar and profile banner, and can follow other users.

Each user can also create tweets. Tweets exist on their own, but can additionally be made as a "quote" or "subtweet".
Quotes and subtweets connect two tweet objects in a one-to-one relationship, one tweet being the "subtweeted" or "quoted", and the other being the "subtweet" or "quote".

Retweets are a special case, as they **don't create a new tweet object.** They only connect a user to a tweet, similar to a "Like".

Tweets do not intrinsically store who liked or retweed them, only keeping the count stored. In addition to likes and retweets, tweets also track views, increasing the count by 1 any time a tweet is loaded by the api.


Most content is viewed via two pages:

1. For the user's main timeline, populate it with tweets/retweets from the accounts they follow or recommended tweets with the following api calls:
- `get "tweets/timeline.json"`
- `get "tweets/suggested.json"`

3. When viewing another user's page, you can see their tweets/retweets, likes and replies through the following calls:
- `get "/tweets/users/:username/replies.json"`
- `get "/tweets/users/:username/likes.json"`
- `get "/tweets/users/:username.json"`


### The Seed File
The API features an extensive **seed file, which populates the database with all the essential content you could want right out the gate.** 

By default the seed file will populate the database with 200 users, each with fake names and a profile picture. 100 of these users will recieve a custom display name, bio and 5 pre-made tweets relating to their main personality trait (ChatGPT generated).

Additionally, random users are given status updates with pre-generated ChatGPT responses to create instances of subtweets.

Each user will follow 10-30 random users, with the admin and guest account guaranteed to follow 20 of the accounts that contain more content.
Users will also randomly like and retweet tweets from the accounts they now follow (this can take a while, so increasing or decreasing the amount of likes per person in the seed file could have a large affect on startup time).
Even the occasional quote tweet will be thrown in!

Finally, the timestamps for all pre-made tweets are fabricated and randomized, ranging from the current date to 9 months prior.
Now you have a user base, and a timeline full of varied tweets, retweets, subtweets and quotes from different users!


## Requests

### Logging In
Many of the controller actions first require user authentication. 

To create a new user, send a post request to '/users.json'.
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

To "Log In" as a user:

`POST "/sessions.json`
`params: {email, password}`

If successful, you will recieve a jwt token.
To make requests as the user, put the following in each request header:

`{Authorization: Bearer [insert jwt here]} `


### The Timeline
This API contains two key functions designed to continuously feed content into a user's timeline.

The first is called with `get '/tweets/timeline.json`,
and the second is called with `get '/tweets/suggested.json`.

Both require a session token, and take in two optional params: `{limit, offset}`

By default, the timeline function finds the most recent tweets or retweets made by any users followed by the user you're logged in as.
It returns each as a tweet object, ordered by timestamp. (Retweets have a different timestamp, so an older tweet that was retweeted later might appear to be out of order if you're looking at the timestamp of the tweet itself.)

The limit and offset are set to 20 and 0 respectively, returning the 20 most recent tweets. If you wanted to find the 151st - 200th most recent tweets/retweets, you'd set the limit to 50 and offset to 150.


The suggested search operates the exact same way, but instead of finding tweets/retweets by followed accounts, it will only return tweets from accounts the user doesn't follow, ordered by view count.

The combination of these controller actions with sucessive calls from the front end via user scroll creates an "infinite scroll" effect, continually supplying the timeline with content without loading more data than necessary.





