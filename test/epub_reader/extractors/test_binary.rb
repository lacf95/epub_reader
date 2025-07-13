# frozen_string_literal: true

require "test_helper"

class TestExtractorsBinary < Minitest::Test
  def test_extract
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    reference = "716671940892739718_cover.jpg"
    binary = ::EpubReader::Extractors::Binary.extract(epub_path, reference)

    assert_instance_of Tempfile, binary
  end

  def test_extract_without_matching_file
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    reference = "no_matching.jpg"

    assert_raises ::EpubReader::Error do
      ::EpubReader::Extractors::Binary.extract(epub_path, reference)
    end
  end
end
