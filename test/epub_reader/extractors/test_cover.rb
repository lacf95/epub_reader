# frozen_string_literal: true

require "test_helper"

class TestExtractorsCover < Minitest::Test
  def test_extract
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    cover = ::EpubReader::Extractors::Cover.extract(epub_path)

    assert_equal "716671940892739718_cover.jpg", cover.name
  end

  def test_extract_without_cover_reference
    epub_path = "test/fixtures/no_cover_reference.epub"
    cover = ::EpubReader::Extractors::Cover.extract(epub_path)

    assert_nil cover
  end

  def test_extract_with_cover_reference_and_no_file
    epub_path = "test/fixtures/cover_id_reference.epub"
    cover = ::EpubReader::Extractors::Cover.extract(epub_path)

    assert_nil cover
  end

  def test_extract_without_cover_file
    epub_path = "test/fixtures/no_cover.epub"
    cover = ::EpubReader::Extractors::Cover.extract(epub_path)

    assert_nil cover
  end
end
