# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "./db/fake_tweets"
require "./db/fake_user_data"
require "./db/avatars"
require "./db/banners"


user_data = user_generator


def rand_range(num)

  list = *0..num
  return list.shuffle

end


# generate fake content here -----

images = ["https://img.freepik.com/free-photo/abstract-nature-painted-with-watercolor-autumn-leaves-backdrop-generated-by-ai_188544-9806.jpg", "https://www.epidemicsound.com/blog/content/images/size/w2000/2023/05/what-is-royalty-free-music-header.webp", "https://www.poynter.org/wp-content/uploads/2019/02/2.Journalism-Fundamentals-June-2022.png", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT0XanS-zY2amtRDJ3gPw5jo2KbRhCVAh8xQ&s", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz09fAl5_eoIvPeL-TMX_UoUgkx9pJaqD0VA&s", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsLiY8nDX3q-95uvIK_QoD1ve0KO9OxHbEiA&s", "https://jetpackcomics.com/wp-content/uploads/2018/10/stacks-of-comic-books.png", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRX4VNKCg0WkEnPaG3PzaNPgYhhl03XaqJeww&s", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAxrpbb-pzxj3EcG4e6_YgojhBohwf8imqew&s", "https://images.unsplash.com/photo-1582845512747-e42001c95638?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"]

banners = banners()
men = men()
women = women()

banner_index = 0
men_index = 0
women_index = 0

puts "Creating users..."

# ---------- make admin account & a tweet

banner = 'https://images.unsplash.com/photo-1516331138075-f3adc1e149cd?q=80&w=2108&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
avi = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRX4VNKCg0WkEnPaG3PzaNPgYhhl03XaqJeww&s"

admin = User.new(username: 'andrew_wulf', email: 'awulf@gmail.com', password: 'password', password_confirmation: 'password', display_name: 'The Architect', avi: avi, 
banner: banner, bio: "I made all of this!", verified: true, admin: true,)
admin.save

tweet = Tweet.new(user_id: 1, text: "Bringing twitter back.", views: 1500000, timestamp: Time.new(2024, 4, 1, 12, 0, 0))
tweet.save

tweet = Tweet.new(user_id: 1, text: "Memes are supported on this platform! Observe:", image: "https://hips.hearstapps.com/hmg-prod/images/2s9cjb-1548710537.jpg?crop=1xw:0.9523809523809523xh;center,top&resize=1200:*", views: 310000, timestamp: Time.new(2024, 4, 1, 2, 30, 0))
tweet.save

tweet = Tweet.new(user_id: 1, text: "Introducing: Embedded videos!", video: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', views: 24500, timestamp: Time.new(2024, 4, 1, 4, 0, 0))
tweet.save

# ----------- make fake users



# ------------ make user accounts
primary_users = []


curr = 'women'

user_data.each do |row|

  username = row[0]
  email = "#{row[0]}@gmail.com"
  password = "password"
  display_name = row[1]
  bio = row[2]

  banner = banners[banner_index]
  banner_index +=1

  if curr == 'men'
    avi = men[men_index]
    curr = 'women'
    men_index +=1
  else
    avi = women[women_index]
    curr = 'men'
    women_index +=1
  end

  user = User.new(username: username, email: email, password: password, password_confirmation: password, display_name: display_name, avi: avi, banner: banner, bio: bio)
  
  if user.save
    primary_users.push(user)
  else
    pp user.errors
  end

  
  
  if men_index >= men.length
    men_index = 0
  end
  if women_index >= women.length
    women_index = 0
  end
  if banner_index >= banners.length
    banner_index = 0
  end
end

main_users = primary_users[0..20]
# Make sure admin is following some of the primary users
main_users.each do |user|

  follow = Follow.new(follower_id: 1, followed_id: user.id)
  follow.save

  admin.following_count +=1
  admin.save

  user.follower_count +=1
  user.save
end



curr = 'men'
50.times do
  first1, last1 = Faker::Name.male_first_name, Faker::Name.last_name
  first2, last2 = Faker::Name.female_first_name, Faker::Name.last_name

  [[first1, last1], [first2, last2]].each do |arr|
    first, last = arr[0], arr[1]

    username = "#{first}#{last}"
    email = "#{first}#{last}@gmail.com"
    password = "password"
    display_name = "#{first} #{last}"
    bio = "placeholder bio"

    banner = banners[banner_index]

    if curr == 'men'
      avi = men[men_index]
      curr = 'women'
      men_index +=1
    else
      avi = women[women_index]
      curr = 'men'
      women_index +=1
    end

    user = User.new(username: username, email: email, password: password, password_confirmation: password, display_name: display_name, avi: avi, banner: banner, bio: bio)
  
    if user.save === false
      pp user.errors
    end

    if men_index >= men.length
      men_index = 0
    end
    if women_index >= women.length
      women_index = 0
    end

    banner_index +=1
    if banner_index >= banners.length
      banner_index = 0
    end
  end
end


puts "Adding follows..."

# Generate followers
all_users = User.all

all_users.each do |user|

  rand(10..30).times do
    followed = all_users[rand(1...all_users.length)]
    follow = Follow.new(follower_id: user.id, followed_id: followed.id)
    follow.save

    user.following_count +=1
    user.save

    followed.follower_count +=1
    followed.save
  end
  # Everyone follows admin
  follow = Follow.new(follower_id: user.id, followed_id: admin.id)
  follow.save

  user.following_count +=1
  user.save

  admin.follower_count +=1
  admin.save

end


puts "writing tweets..."
# First, generate primary user tweets. These don't have any responses at the moment.
time = DateTime.now.advance(months: -3, days: -1)
limit = DateTime.now.advance(months: -9)
timestamps = []
n = user_data.length * 5
n.times do
  timestamps.push(Faker::Time.between(from: limit, to: time))
end
timestamps.sort

timestamp_index = 0

j = 0
while j < 5
  i = 0
  while i < user_data.length
    curr = user_data[i]
    user = User.find_by(username: curr[0])
    if user
      tweets = curr[3]
      view_count = rand(900)

      tweet = Tweet.new(user_id: user.id, text: tweets[j], views: view_count, timestamp: timestamps[timestamp_index])
      tweet.save

      timestamp_index +=1
    end

    i+=1
  end

  j +=1
end


puts "halfway done, adding more tweets and retweets..."
# Generate a bunch of random tweets with responses. Random users tweet them out, interspersed with randomly placed quote tweets and retweets (which are guaranteed to be a smaller percentage of content).

# When a tweet is made, random followers of the user will tweet the subtweets in a random order.


rand_tweets = tweet_generator()
rand_tweet_ids = rand_range(rand_tweets.length)

rt_count = (rand_tweets.length / 2).to_i
quote_count = (rand_tweets.length / 15).to_i

rt_count.times do
  rand_tweets.push('rt')
end

quote_count.times do
  rand_tweets.push('quote')
end

rand_tweets = rand_tweets.shuffle

time = DateTime.now.advance(days: -1)
limit = DateTime.now.advance(months: -3)
timestamps = []
n = rand_tweets.length + rt_count
n.times do
  timestamps.push(Faker::Time.between(from: limit, to: time))
end
timestamps.sort

i = 0

while i < rand_tweets.length
  curr = rand_tweets[i]

  user = main_users[rand(0...main_users.length)]

  view_count = rand(900)

  if curr == 'rt'
    tweet = Tweet.find_by(id: (rand(1...Tweet.all.length)))
    if tweet.user_id != user.id
      rt = Retweet.new(tweet_id: tweet.id, user_id: user.id, timestamp: timestamps[i])
      rt.save
      
      tweet.retweet_count +=1
      tweet.save
    end

  elsif curr == 'quote'
    tweet = Tweet.find_by(id: (rand(1...Tweet.all.length)))

    if tweet.user_id != user.id
      t = Tweet.new(user_id: user.id, text: 'I feel this.', is_quote: true, views: view_count, timestamp: timestamps[i])
      t.save
      q = Quote.new(tweet_id: t.id, quoted_id: tweet.id)
      q.save
    end

  else
    tweet = Tweet.new(user_id: user.id, text: curr[0], is_subtweet: false, views: view_count, timestamp: timestamps[i])
    tweet.save
    
    followers = user.followers

    if followers.length > 4

      subtweets = curr[1...curr.length].shuffle

      subtweets.each do |st|

        follower = followers[rand(0...followers.length)]

        t = Tweet.new(user_id: follower.id, text: st, is_subtweet: true, views: rand((view_count / 2).to_i), timestamp: timestamps[i])
        t.save

        subtweet = Subtweet.new(tweet_id: tweet.id, sub_id: t.id)
        subtweet.save

        t.reply_count +=1
        t.save


      end
    end

  end

  i +=1

end


puts "generating likes..."
# After everything else is done, everyone likes a ton of random tweets.

User.all.each do |user|

  200.times do
    tweet = Tweet.find_by(id: (rand(1...Tweet.all.length)))
    if tweet.user_id != user.id && tweet.liked_by_user(user) == false
      like = Like.new(tweet_id: tweet.id, user_id: user.id)
      like.save

      tweet.like_count +=1
      tweet.save
    end
  end
end





puts "done!"







#ChatGPT prompts

# part 1
# Imagine a social media with a user base of 100 unique people, each with a distinct hobby or interest. The names of these individuals are contained in the array of 100 names I gave you. Then, give me an array with 100 items in it. Each item corresponds to an individual user in the user base. Each array item is an array with the following content: first entry = a twitter username, which is just the full name of the person with spaces removed. Second entry = a twitter display name, using one of three formats: 1) the user's first name, followed by a space and then 1 or more emojis relating to them. 2) a nickname for the user based on their name and interests. 3) a nickname or title not including their name at all, and includes at least one emoji. Any display name with multiple words puts a space between them. Third entry = a twitter bio, giving 1-3 short statements expressing the person's personality. Bios should usually contain an emoji. 



# #part 2

# Using the array of 100 user profiles you generated as a user base, give me a ruby hash of 100 key-value pairs, each pair corresponding to a distinct user in the user base. Each key in the hash is a string of the user's username, and the value is an array with ten items in it. Each item in the array is another array: the first array entry is a distinct tweet the person might make as they go about their life, using their personality, opinions and interests as inspiration. Tweets can contain any emotion or tone. Variety is ideal, but more often than not, tweets should skew towards being either humorous or self-expressive. Tweets can contain emojis! Then, add 2-8 replies to the array, each written from the perspective of other users in the user base. These responses should also have variety and can contain any emotion or tone. Here are some potential response options: 1) find the tweet funny, 2) relate the tweet to their own experiences, 3) not understand what the original tweet was trying to convey, 4) be hostile or mocking, 5) relate the tweet to something totally unrelated. When writing a tweet response, keep in mind the personality of the user responding. Each reply should be an array with the reply text as the first item, and the username replying as the second item. If it's the last reply, and it's the final tweet for the 10 item array, then append a third item to the reply array, containing an array with two items: the first is the text of another user replying to the reply, and the second item is the username of the second replier.