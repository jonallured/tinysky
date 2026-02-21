module Tinysky
  class LinkFacet
    def initialize(byte_start, byte_end, uri)
      @byte_start = byte_start
      @byte_end = byte_end
      @uri = uri
    end

    def to_hash
      {
        "features" => [
          {
            "$type" => Tinysky::Lexicon::LINK_FACET,
            "uri" => @uri
          }
        ],
        "index" => {
          "byteEnd" => @byte_end,
          "byteStart" => @byte_start
        }
      }
    end
  end
end
