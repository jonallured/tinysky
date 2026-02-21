module Tinysky
  class FacetParser
    URL_PATTERN = /https?:\/\/\S+/

    def self.for(text)
      parser = new(text)
      parser.find_facets
    end

    def initialize(text)
      @text = text || ""
    end

    def find_facets
      scan_enumerator = @text.enum_for(:scan, URL_PATTERN)

      scan_enumerator.map do |url|
        char_start = Regexp.last_match.begin(0)
        byte_start = @text[0, char_start].bytesize
        byte_end = byte_start + url.bytesize
        LinkFacet.new(byte_start, byte_end, url)
      end
    end
  end
end
