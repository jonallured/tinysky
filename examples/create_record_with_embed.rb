require "bundler/setup"
require "tinysky"

BlogPost = Struct.new(:url, :title, :description, :image_url)

blog_post = BlogPost.new(
  "https://www.jonallured.com/posts/2026/02/14/upgrading-to-ruby-four-oh.html",
  "Upgrading to Ruby 4.0",
  "Ruby 4.0 was released a couple months ago on Christmas and I had been meaning to upgrade for a while. I noticed that version 4.0.1 came out too so that's always a good sign that things are stable and ready for prime time.",
  "https://www.jonallured.com/images/post-95/social-share.png"
)

credentials_path = "/Users/jon/Desktop/tinysky_credentials.json"
credentials = JSON.load_file(credentials_path, symbolize_names: true)
client = Tinysky::Client.new(credentials)

blob_data = Faraday.get(blog_post.image_url).body
content_type = "image/png"
upload_response = client.upload_blob(blob_data, content_type)
thumb = upload_response.body["blob"]

embed = Tinysky::ExternalEmbed.new(
  description: blog_post.description,
  thumb: thumb,
  title: blog_post.title,
  uri: blog_post.url
)

message = "New blog post: https://www.jonallured.com/posts/2026/02/14/upgrading-to-ruby-four-oh.html"
facets = Tinysky::FacetParser.for(message)

record_options = {
  embed: embed,
  facets: facets
}

client.create_record(message, record_options)
