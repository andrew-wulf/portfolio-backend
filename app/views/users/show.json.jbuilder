json.id @user.id

json.username @user.username
json.email @user.email

json.display_name @user.display_name

json.bio @user.bio
json.avi @user.avi
json.banner @user.banner

json.verified @user.verified
json.admin @user.admin


json.followers @user.follower_count
json.following @user.following_count

likes = @user.likes
json.likes likes.count
json.liked_ids likes.map {|like| like.tweet_id}