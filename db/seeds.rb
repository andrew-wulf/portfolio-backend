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


def rand_range(num)

  list = *0..num
  return list.shuffle

end


# generate fake content here -----

images = ["https://img.freepik.com/free-photo/abstract-nature-painted-with-watercolor-autumn-leaves-backdrop-generated-by-ai_188544-9806.jpg", "https://www.epidemicsound.com/blog/content/images/size/w2000/2023/05/what-is-royalty-free-music-header.webp", "https://www.poynter.org/wp-content/uploads/2019/02/2.Journalism-Fundamentals-June-2022.png", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT0XanS-zY2amtRDJ3gPw5jo2KbRhCVAh8xQ&s", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz09fAl5_eoIvPeL-TMX_UoUgkx9pJaqD0VA&s", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsLiY8nDX3q-95uvIK_QoD1ve0KO9OxHbEiA&s", "https://jetpackcomics.com/wp-content/uploads/2018/10/stacks-of-comic-books.png", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRX4VNKCg0WkEnPaG3PzaNPgYhhl03XaqJeww&s", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAxrpbb-pzxj3EcG4e6_YgojhBohwf8imqew&s", "https://images.unsplash.com/photo-1582845512747-e42001c95638?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"]

banner = "https://images.unsplash.com/photo-1506765515384-028b60a970df?q=80&w=1469&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"



# ---------- make admin account & a tweet
admin = User.new(username: 'andrew_wulf', email: 'awulf@gmail.com', password: 'password', password_confirmation: 'password', display_name: 'The Architect', avi: images[rand(0...images.length)], 
banner: banner, bio: "I made all of this!", verified: true, admin: true)
admin.save

tweet = Tweet.new(user_id: 1, text: "Bringing twitter back.")
tweet.save

tweet = Tweet.new(user_id: 1, text: "Memes are supported on this platform! Observe:", image: "https://hips.hearstapps.com/hmg-prod/images/2s9cjb-1548710537.jpg?crop=1xw:0.9523809523809523xh;center,top&resize=1200:*")
tweet.save

tweet = Tweet.new(user_id: 1, text: "Introducing: Embedded videos!", video: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ')
tweet.save

# ----------- make fake users



# ------------ make user accounts
primary_users = []

20.times do
  first, last = Faker::Name.first_name, Faker::Name.last_name
  username = "#{first}#{last}"
  email = "#{first}#{last}@gmail.com"
  password = "password"
  display_name = "#{first} #{last}"
  bio = "placeholder bio"

  user = User.new(username: username, email: email, password: password, password_confirmation: password, display_name: display_name, avi: images[rand(0...images.length)], banner: banner, bio: bio)
  
  if user.save
    primary_users.push(user)
  else
    pp user.errors
  end

end

# Make sure admin is following some of the primary users
(primary_users.length / 4).to_i.times do
  user = primary_users[rand(0...primary_users.length)]
  follow = Follow.new(follower_id: 1, followed_id: user.id)
  follow.save
  
end





180.times do
  first, last = Faker::Name.first_name, Faker::Name.last_name
  username = "#{first}#{last}"
  email = "#{first}#{last}@gmail.com"
  password = "password"
  display_name = "#{first} #{last}"
  bio = "placeholder bio"

  user = User.new(username: username, email: email, password: password, password_confirmation: password, display_name: display_name, avi: images[rand(0...images.length)], banner: banner, bio: bio)
  
  if user.save === false
    pp user.errors
  end
end




# Generate followers

User.all.each do |user|

  rand(10..30).times do
    follow = Follow.new(follower_id: user.id, followed_id: (rand(1...User.all.length)))
    follow.save
  end
  # Everyone follows admin
  follow = Follow.new(follower_id: user.id, followed_id: 1)
  follow.save
end


# Generate a bunch of random tweets with responses. Random users tweet them out, interspersed with randomly placed quote tweets and retweets (which are guaranteed to be a smaller percentage of content).

# When a tweet is made, random followers of the user will tweet the subtweets in a random order.


rand_tweets = tweet_generator()
rand_tweet_ids = rand_range(rand_tweets.length)

rt_count = (rand_tweets.length / 4).to_i
quote_count = (rand_tweets.length / 15).to_i

rt_count.times do
  rand_tweets.push('rt')
end

quote_count.times do
  rand_tweets.push('quote')
end

rand_tweets = rand_tweets.shuffle

i = 0

while i < rand_tweets.length
  curr = rand_tweets[i]

  user = primary_users[rand(0...primary_users.length)]

  if curr == 'rt'
    tweet = Tweet.find_by(id: (rand(1...Tweet.all.length)))
    if tweet.user_id != user.id
      rt = Retweet.new(tweet_id: tweet.id, user_id: user.id)
      rt.save
    end

  elsif curr == 'quote'
    tweet = Tweet.find_by(id: (rand(1...Tweet.all.length)))

    if tweet.user_id != user.id
      t = Tweet.new(user_id: user.id, text: 'This really made me think!', is_quote: true)
      t.save
      q = Quote.new(tweet_id: t.id, quoted_id: tweet.id)
      q.save
    end

  else
    tweet = Tweet.new(user_id: user.id, text: curr[0], is_subtweet: false)
    tweet.save
    
    followers = user.followers

    subtweets = curr[1...curr.length].shuffle

    subtweets.each do |st|

      follower = followers[rand(0...followers.length)]

      t = Tweet.new(user_id: follower.id, text: st, is_subtweet: true)
      if t.save == false
        pp t.errors
      end

      subtweet = Subtweet.new(tweet_id: tweet.id, sub_id: t.id)
      if subtweet.save == false
        pp subtweet.errors
      end

    end

  end

  i +=1

end



# After everything else is done, everyone likes a ton of random tweets.

User.all.each do |user|

  50.times do
    tweet = Tweet.find_by(id: (rand(1...Tweet.all.length)))
    if tweet.user_id != user.id
      like = Like.new(tweet_id: tweet.id, user_id: user.id)
      like.save
    end
  end
end

