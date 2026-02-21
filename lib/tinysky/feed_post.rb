module Tinysky
  class FeedPost
    def initialize(text, options)
      @text = text
      @options = options
    end

    def to_hash
      hsh = {
        "$type" => Tinysky::Lexicon::FEED_POST,
        "createdAt" => created_at,
        "langs" => ["en-US"],
        "text" => @text
      }

      hsh["embed"] = embed.to_hash unless embed.nil?
      hsh["facets"] = facets.map(&:to_hash) if facets.any?

      hsh
    end

    private

    def created_at
      as_of = @options[:as_of] || DateTime.now
      as_of.iso8601
    end

    def embed
      @options[:embed]
    end

    def facets
      return [] if @options[:facets].nil?

      @options[:facets]
    end
  end
end
