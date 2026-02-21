module Tinysky
  class FeedPost
    def initialize(text)
      @text = text
    end

    def to_hash
      {
        "$type" => Tinysky::Lexicon::FEED_POST,
        "createdAt" => DateTime.now.iso8601,
        "langs" => ["en-US"],
        "text" => @text
      }
    end
  end
end
