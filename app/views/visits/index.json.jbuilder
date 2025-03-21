json.array! @visitors do |visitor|
    json.visitor_id visitor.id

    json.visits visitor.visits

end
