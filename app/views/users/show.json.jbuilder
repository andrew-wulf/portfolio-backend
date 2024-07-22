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


if @current
  json.followed_by_user @user.followed_by_user(@current)
  json.follows_user @user.follows_user(@current)
else
  json.followed_by_user nil
  json.follows_user nil
end