module Tinysky
  class ExternalEmbed
    def initialize(attrs)
      @description = attrs[:description]
      @thumb = attrs[:thumb]
      @title = attrs[:title]
      @uri = attrs[:uri]
    end

    def to_hash
      {
        "$type" => Tinysky::Lexicon::EXTERNAL_EMBED,
        "external" => {
          "description" => @description,
          "thumb" => @thumb,
          "title" => @title,
          "uri" => @uri
        }
      }
    end
  end
end
