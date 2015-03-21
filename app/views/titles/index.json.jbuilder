json.array!(@titles) do |title|
  json.extract! title, :id, :name
  json.watch @watching_ids.include?(title.id)
end
