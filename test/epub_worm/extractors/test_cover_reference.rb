# frozen_string_literal: true

require "test_helper"

class TestExtractorsCoverReference < Minitest::Test
  def test_extract
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    cover_reference = ::EpubWorm::Extractors::CoverReference.extract(epub_path)

    assert_equal "716671940892739718_cover.jpg", cover_reference
  end

  def test_extract_without_cover_reference
    epub_path = "test/fixtures/v3_no_cover_reference.epub"
    cover_reference = ::EpubWorm::Extractors::CoverReference.extract(epub_path)

    assert_nil cover_reference
  end
end
