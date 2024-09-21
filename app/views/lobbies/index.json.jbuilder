json.array! @lobbies do |lobby|

  json.id lobby.id
  json.code lobby.code
  json.active lobby.active
  json.full lobby.full

  json.players lobby.players
end
