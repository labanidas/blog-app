require "x"

x_credentials = {
  api_key:             ENV["API_KEY"],
  api_key_secret:      ENV["API_KEY_SECRET"],
  access_token:        ENV["ACCESS_TOKEN"],
  access_token_secret: ENV["ACCESS_TOKEN_SECRET"],
}

# Initialize an X API client with your OAuth credentials
x_client = X::Client.new(**x_credentials)

# Get data about yourself
x_client.get("users/me")
# {"data"=>{"id"=>"1667481226494742529", "name"=>"Labani Das", "username"=>"LabaniD56543256"}}

# Post a tweet
post = x_client.post("tweets", '{"text":"Hello, World!"}')
# {"data"=>{"edit_history_tweet_ids"=>["1760289591808974946"], "id"=>"1760289591808974946", "text"=>"Hello, World!"}}

# Delete the post
x_client.delete("tweets/#{post["data"]["id"]}")
# {"data"=>{"deleted"=>true}}

# Initialize an API v1.1 client
v1_client = X::Client.new(base_url: "https://api.twitter.com/1.1/", **x_credentials)

# Define a custom response object
Language = Struct.new(:code, :name, :local_name, :status, :debug)

# Parse a response with custom array and object classes
languages = v1_client.get("help/languages.json", object_class: Language, array_class: Set)
# #<Set: {#<struct Language code="ur", name="Urdu", local_name="اردو", status="beta", debug=false>, …

# Access data with dots instead of brackets
languages.first.local_name

# Initialize an Ads API client
ads_client = X::Client.new(base_url: "https://ads-api.twitter.com/12/", **x_credentials)

# Get your ad accounts
ads_client.get("accounts")