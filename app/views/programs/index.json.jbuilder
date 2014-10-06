json.array! @programs do |program|
  json.title do
    json.extract! program.title, :id, :name
  end
  json.story do
    json.number program.no
    json.subtitle program.subtitle
  end
  json.start_at program.start_at
  json.channel do
    json.extract! program.channel, :id, :name
  end
end
