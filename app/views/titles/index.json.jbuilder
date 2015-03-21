json.array!(@titles) do |title|
  json.name title.name
  json.watch? @watching_ids.include?(title.id)
end
