json.array! @channel_groups do |group|
  json.name group.name
  json.channels group.channels do |channel|
    json.extract! channel, :id, :name
  end
end
