# frozen_string_literal: true

require "test_helper"

class TestExtractorsXhtmlNavigation < Minitest::Test
  def test_extract
    epub_path = "test/fixtures/v3.epub"
    navigation = ::EpubReader::Extractors::XhtmlNavigation.extract(epub_path)

    assert_nil navigation.title
    assert_nil navigation.reference
    assert_equal "Section 1", navigation.children.first.title
  end

  def test_extract_without_toc_reference
    epub_path = "test/fixtures/v3_no_nav_reference.epub"

    assert_raises ::EpubReader::Error do
      ::EpubReader::Extractors::XhtmlNavigation.extract(epub_path)
    end
  end

  def test_extract_without_toc_file
    epub_path = "test/fixtures/v3_no_nav_file.epub"

    assert_raises ::EpubReader::Error do
      ::EpubReader::Extractors::XhtmlNavigation.extract(epub_path)
    end
  end
end
