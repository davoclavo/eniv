json.array!(@vines) do |vine|
  json.extract! vine, 
  json.url vine_url(vine, format: :json)
end
