json.array!(@environments) do |environment|
  json.extract! environment, :id, :servername, :location
  json.url environment_url(environment, format: :json)
end
