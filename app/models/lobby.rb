class Lobby < ApplicationRecord

  has_many :players


  def add(name)

    if self.players.count < 8

      search = Player.find_by(name: name)
      if search == nil
        player = Player.new(name: name, lobby_id: self.id)
        player.save
      
      else 
        return 1
      end

    else
      return 2
    end

  end


  def remove(name)
    player = Player.find_by(name: name, lobby_id: self.id)

    if player
      player.delete
      return true
    else
      return false
    end
  end

end
