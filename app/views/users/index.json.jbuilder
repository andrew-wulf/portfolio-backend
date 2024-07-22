json.array! @users do |user|

  json.id user.id

  json.username user.username
  json.display_name user.display_name
  json.avi user.avi

  json.verified user.verified

  json.bio user.bio
  json.followers user.follower_count
  json.following user.following_count

  if @current
    json.followed_by_user user.followed_by_user(@current)
    json.follows_user user.follows_user(@current)
  else
    json.followed_by_user nil
    json.follows_user nil
  end

end