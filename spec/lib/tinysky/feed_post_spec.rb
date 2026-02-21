describe Tinysky::FeedPost do
  describe "#to_hash" do
    context "with a basic feed post" do
      it "returns a basic shape" do
        text = "hello world!"
        as_of = DateTime.now
        options = {as_of: as_of}
        feed_post = Tinysky::FeedPost.new(text, options)
        expect(feed_post.to_hash).to eq(
          {
            "$type" => Tinysky::Lexicon::FEED_POST,
            "createdAt" => as_of.iso8601,
            "langs" => ["en-US"],
            "text" => "hello world!"
          }
        )
      end
    end

    context "with nil embed" do
      it "ignores the embed option" do
        text = "hello world!"
        embed = nil
        options = {embed: embed}
        feed_post = Tinysky::FeedPost.new(text, options)
        expect(feed_post.to_hash.keys).to eq(
          ["$type", "createdAt", "langs", "text"]
        )
      end
    end

    context "with an embed" do
      it "returns a shape with that embed" do
        text = "hello world!"
        as_of = DateTime.now
        embed = Tinysky::ExternalEmbed.new({})
        options = {as_of: as_of, embed: embed}
        feed_post = Tinysky::FeedPost.new(text, options)
        expect(feed_post.to_hash).to eq(
          {
            "$type" => Tinysky::Lexicon::FEED_POST,
            "createdAt" => as_of.iso8601,
            "embed" => {
              "$type" => Tinysky::Lexicon::EXTERNAL_EMBED,
              "external" => {
                "description" => nil,
                "thumb" => nil,
                "title" => nil,
                "uri" => nil
              }
            },
            "langs" => ["en-US"],
            "text" => "hello world!"
          }
        )
      end
    end

    context "with nil facets" do
      it "ignores the facets option" do
        text = "hello world!"
        facets = nil
        options = {facets: facets}
        feed_post = Tinysky::FeedPost.new(text, options)
        expect(feed_post.to_hash.keys).to eq(
          ["$type", "createdAt", "langs", "text"]
        )
      end
    end

    context "with empty facets" do
      it "ignores the facets option" do
        text = "hello world!"
        facets = []
        options = {facets: facets}
        feed_post = Tinysky::FeedPost.new(text, options)
        expect(feed_post.to_hash.keys).to eq(
          ["$type", "createdAt", "langs", "text"]
        )
      end
    end

    context "with feed post that has a facet" do
      it "returns a shape with that facet" do
        text = "check it: https://www.jonallured.com"
        as_of = DateTime.now
        link_facet = Tinysky::LinkFacet.new(1, 1, "https://www.jonallured.com")
        facets = [link_facet]
        options = {as_of: as_of, facets: facets}
        feed_post = Tinysky::FeedPost.new(text, options)
        expect(feed_post.to_hash).to eq(
          {
            "$type" => Tinysky::Lexicon::FEED_POST,
            "createdAt" => as_of.iso8601,
            "facets" => [
              {
                "features" => [
                  {
                    "$type" => Tinysky::Lexicon::LINK_FACET,
                    "uri" => "https://www.jonallured.com"
                  }
                ],
                "index" => {
                  "byteEnd" => 1,
                  "byteStart" => 1
                }
              }
            ],
            "langs" => ["en-US"],
            "text" => "check it: https://www.jonallured.com"
          }
        )
      end
    end
  end
end
