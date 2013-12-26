json.array!(@performers) do |performer|
  json.extract! performer, :id
  json.url performer_url(performer, format: :json)
end
