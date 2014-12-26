json.array!(@users) do |user|
  json.extract! user, :id, :email_address, :admin
  json.url user_url(user, format: :json)
end
