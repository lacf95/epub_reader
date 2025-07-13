# frozen_string_literal: true

require "test_helper"

class TestExtractorsContent < Minitest::Test
  def test_extract
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    reference = "2400617320698039998_11-h-1.htm.xhtml"
    content = ::EpubWorm::Extractors::Content.extract(epub_path, reference)

    assert content.document?
  end

  def test_extract_with_fragment
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    reference = "2400617320698039998_11-h-1.htm.xhtml#pgepubid00003"
    content = ::EpubWorm::Extractors::Content.extract(epub_path, reference)

    assert_equal "pgepubid00003", content["id"]
  end

  def test_extract_without_matching
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    reference = "not_matching.htm.xhtml"

    assert_raises ::EpubWorm::Error do
      ::EpubWorm::Extractors::Content.extract(epub_path, reference)
    end
  end

  def test_extract_without_matching_frame
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    reference = "2400617320698039998_11-h-1.htm.xhtml#not_matching"

    assert_raises ::EpubWorm::Error do
      ::EpubWorm::Extractors::Content.extract(epub_path, reference)
    end
  end
end
