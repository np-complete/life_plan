json.array! @programs do |program|
  json.id program.id
  json.title do
    json.extract! program.title, :id, :name
  end
  json.watch @title_ids && @title_ids.include?(program.title.id)
  json.story do
    json.number program.no
    json.subtitle program.subtitle
  end
  json.start_at program.start_at.to_i
  json.channel do
    json.extract! program.channel, :id, :name
    json.watch @channel_ids && @channel_ids.include?(program.channel.id)
  end
end
