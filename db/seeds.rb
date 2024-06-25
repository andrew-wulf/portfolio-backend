# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# generate fake content here -----

images = ["https://img.freepik.com/free-photo/abstract-nature-painted-with-watercolor-autumn-leaves-backdrop-generated-by-ai_188544-9806.jpg", "https://www.epidemicsound.com/blog/content/images/size/w2000/2023/05/what-is-royalty-free-music-header.webp", "https://www.poynter.org/wp-content/uploads/2019/02/2.Journalism-Fundamentals-June-2022.png", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT0XanS-zY2amtRDJ3gPw5jo2KbRhCVAh8xQ&s", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz09fAl5_eoIvPeL-TMX_UoUgkx9pJaqD0VA&s", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsLiY8nDX3q-95uvIK_QoD1ve0KO9OxHbEiA&s", "https://jetpackcomics.com/wp-content/uploads/2018/10/stacks-of-comic-books.png", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRX4VNKCg0WkEnPaG3PzaNPgYhhl03XaqJeww&s", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAxrpbb-pzxj3EcG4e6_YgojhBohwf8imqew&s", "https://images.unsplash.com/photo-1582845512747-e42001c95638?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"]

banner = "https://images.unsplash.com/photo-1506765515384-028b60a970df?q=80&w=1469&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"


# ---------- make admin account & a tweet
admin = User.new(username: 'andrew_wulf', email: 'awulf@gmail.com', password: 'password', password_confirmation: 'password', display_name: 'The Architect', avi: images[rand(0...images.length)], 
banner: banner, bio: "Literally God", verified: true, admin: true)
admin.save

tweet = Tweet.new(user_id: 1, text: "Bringing twitter back.")
tweet.save

tweet = Tweet.new(user_id: 1, image: "https://hips.hearstapps.com/hmg-prod/images/2s9cjb-1548710537.jpg?crop=1xw:0.9523809523809523xh;center,top&resize=1200:*")
tweet.save

tweet = Tweet.new(user_id: 1, text: "Check this out!", video: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ')
tweet.save

# ----------- make fake users
user = User.create(username: 'luke_skywalker',
display_name: 'The Chosen One', 
email: "luke@gmail.com", 
password: "password",
password_confirmation: "password",
avi: "https://images.gr-assets.com/characters/1264613782p8/1783.jpg",
admin: false, banner: banner, bio: "test bio")
user.save

t = Tweet.new(user_id: user.id, text: 'This is a subtweet!', is_subtweet: true)
t.save
subtweet = Subtweet.new(tweet_id: 1, sub_id: t.id)
subtweet.save

user = User.create(username: 'john_wick',
display_name: 'John',
email: "john@gmail.com", 
password: "password",
password_confirmation: "password",
avi: "https://upload.wikimedia.org/wikipedia/en/thumb/d/d0/John_Wick_-_Chapter_4_promotional_poster.jpg/220px-John_Wick_-_Chapter_4_promotional_poster.jpg",
admin: false, banner: banner, bio: "test bio")
user.save

t2 = Tweet.new(user_id: user.id, text: 'This is a subtweet!', is_subtweet: true)
t2.save
subtweet = Subtweet.new(tweet_id: 1, sub_id: t2.id)
subtweet.save

user = User.create(username: 'harley_quinn',
display_name: 'Harlene Quinzel, MD.',
email: "harley@gmail.com", 
password: "password",
password_confirmation: "password",
avi: "https://i.guim.co.uk/img/media/70336afc112f7ec7d2e7fb67273f5bfb02791235/0_209_1202_721/master/1202.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=c7aac128b81f030d470b6118a57ea68e",
admin: false, banner: banner, bio: "test bio")
user.save

t3 = Tweet.new(user_id: user.id, text: 'This is a subtweet!', is_subtweet: true)
t3.save
subtweet = Subtweet.new(tweet_id: t2.id, sub_id: t3.id)
subtweet.save

user = User.create(username: 'james_kirk',
display_name: 'Admiral James T. Kirk',
email: "jim@gmail.com", 
password: "password",
password_confirmation: "password",
avi: "https://imageio.forbes.com/blogs-images/alexknapp/files/2012/11/JamesTKirk.jpg?height=380&width=300&fit=bounds",
admin: false, banner: banner, bio: "test bio")
user.save

t4 = Tweet.new(user_id: user.id, text: 'This is a subtweet!', is_subtweet: true)
t4.save
subtweet = Subtweet.new(tweet_id: t3.id, sub_id: t4.id)
subtweet.save

user = User.create(username: 'bruce_wayne',
display_name: 'Big Daddy Bruce',
email: "bruce@gmail.com", 
password: "password",
password_confirmation: "password",
avi: "https://upload.wikimedia.org/wikipedia/en/1/19/Bruce_Wayne_%28The_Dark_Knight_Trilogy%29.jpg",
admin: false, banner: banner, bio: "test bio")
user.save

t5 = Tweet.new(user_id: user.id, text: 'This is a subtweet!', is_subtweet: true)
t5.save
subtweet = Subtweet.new(tweet_id: t3.id, sub_id: t5.id)
subtweet.save


# ------------ make user accounts and some tweets for each
30.times do
  first, last = Faker::Name.first_name, Faker::Name.last_name
  username = "#{first}#{last}"
  email = "#{first}#{last}@gmail.com"
  password = "password"
  display_name = "#{first} #{last}"
  bio = "Fire tweets only. \nvenmo @#{first}.#{last}\nkik @#{first}.#{last}"

  user = User.new(username: username, email: email, password: password, password_confirmation: password, display_name: display_name, avi: images[rand(0...images.length)], banner: banner, bio: bio)
  
  if user.save
    3.times do
      tweet = Tweet.new(user_id: user.id, text: "example tweet")
      tweet.save
    end
    tweet = Tweet.new(user_id: user.id, image: "https://hips.hearstapps.com/hmg-prod/images/2s9cjb-1548710537.jpg?crop=1xw:0.9523809523809523xh;center,top&resize=1200:*")
    tweet.save

    tweet = Tweet.new(user_id: user.id, text: "Check this out!", video: 'https://youtube.com/embed/dQw4w9WgXcQ?autoplay=0')
    tweet.save
  else
    pp user.errors
  end

end

count = Tweet.all.length
user_count = User.all.length
# ------------- each user gives likes, retweets, and follows

User.all.each do |user|

  15.times do
    tweet = Tweet.find_by(id: (rand(1...count)))
    if tweet.user_id != user.id
      like = Like.new(tweet_id: tweet.id, user_id: user.id)
      like.save

      t = Tweet.new(user_id: user.id, text: 'This is a subtweet!', is_subtweet: true)
      t.save
      subtweet = Subtweet.new(tweet_id: tweet.id, sub_id: t.id)
      subtweet.save

      t2 = Tweet.new(user_id: user.id, text: 'This tweet is crazy lmaoo', is_quote: true)
      t2.save
      quote = Quote.new(tweet_id: t2.id, quoted_id: tweet.id)
      quote.save
    end
  end

  5.times do
    tweet = Tweet.find_by(id: (rand(1...count)))
    if tweet.user_id != user.id
      rt = Retweet.new(tweet_id: tweet.id, user_id: user.id)
      rt.save
    end
  end

  10.times do
    follow = Follow.new(follower_id: user.id, followed_id: (rand(1...user_count)))
    follow.save
  end
end

