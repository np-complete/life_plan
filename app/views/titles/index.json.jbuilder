json.pages @titles.total_pages
json.options @options
json.titles @titles.map do |title|
  json.extract! title, :id, :name
  json.watch @watching_ids.include?(title.id)
end
