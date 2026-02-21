describe Tinysky::FacetParser do
  describe ".for" do
    context "with a text that is nil" do
      it "returns an empty array" do
        text = nil
        facets = Tinysky::FacetParser.for(text)
        expect(facets).to eq []
      end
    end

    context "with a text that is an empty string" do
      it "returns an empty array" do
        text = ""
        facets = Tinysky::FacetParser.for(text)
        expect(facets).to eq []
      end
    end

    context "with a text that has no facets" do
      it "returns an empty array" do
        text = "hello world!"
        facets = Tinysky::FacetParser.for(text)
        expect(facets).to eq []
      end
    end

    context "with a text that has a link" do
      it "returns a facet for that link" do
        text = "Check out this site: https://www.jonallured.com"
        facets = Tinysky::FacetParser.for(text)
        expect(facets.first.to_hash).to eq(
          {
            "index" => {
              "byteStart" => 21,
              "byteEnd" => 47
            },
            "features" => [
              {
                "$type" => Tinysky::Lexicon::LINK_FACET,
                "uri" => "https://www.jonallured.com"
              }
            ]
          }
        )
      end
    end

    context "with a text that has an emoji and a link" do
      it "returns a facet for that link" do
        text = "Check out 🎉 this site: https://www.jonallured.com"
        facets = Tinysky::FacetParser.for(text)
        expect(facets.first.to_hash).to eq(
          {
            "index" => {
              "byteStart" => 26,
              "byteEnd" => 52
            },
            "features" => [
              {
                "$type" => Tinysky::Lexicon::LINK_FACET,
                "uri" => "https://www.jonallured.com"
              }
            ]
          }
        )
      end
    end

    context "with a text that has a multi-byte character and a link" do
      it "returns a facet for that link" do
        text = "Check out my résumé: https://www.jonallured.com/resume.html"
        facets = Tinysky::FacetParser.for(text)
        expect(facets.first.to_hash).to eq(
          {
            "index" => {
              "byteStart" => 23,
              "byteEnd" => 61
            },
            "features" => [
              {
                "$type" => Tinysky::Lexicon::LINK_FACET,
                "uri" => "https://www.jonallured.com/resume.html"
              }
            ]
          }
        )
      end
    end
  end
end
