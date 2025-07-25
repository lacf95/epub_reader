# frozen_string_literal: true

require "test_helper"

class TestExtractorsMetadata < Minitest::Test
  def test_extract
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    metadata = ::EpubWorm::Extractors::Metadata.extract(epub_path)

    assert_equal "Alice's Adventures in Wonderland", metadata.title
  end

  def test_extract_without_authors
    epub_path = "test/fixtures/v3_no_authors.epub"
    metadata = ::EpubWorm::Extractors::Metadata.extract(epub_path)

    assert_equal [], metadata.authors
  end
end
