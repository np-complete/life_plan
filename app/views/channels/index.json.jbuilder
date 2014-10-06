@channel_groups.each do |group|
  json.set! group.name do
    json.array! group.channels do |channel|
      json.extract! channel, :id, :name
    end
  end
end
