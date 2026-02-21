require "bundler/setup"
require "tinysky"

credentials_path = "/Users/jon/Desktop/tinysky_credentials.json"
credentials = JSON.load_file(credentials_path, symbolize_names: true)
client = Tinysky::Client.new(credentials)

text = "Upgrading to Ruby 4.0 https://www.jonallured.com/posts/2026/02/14/upgrading-to-ruby-four-oh.html"
facets = Tinysky::FacetParser.for(text)
options = {facets: facets}

client.create_record(text, options)
