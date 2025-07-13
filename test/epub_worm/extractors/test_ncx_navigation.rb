# frozen_string_literal: true

require "test_helper"

class TestExtractorsNcxNavigation < Minitest::Test
  def test_extract
    epub_path = "test/fixtures/v2.epub"
    navigation = ::EpubWorm::Extractors::NcxNavigation.extract(epub_path)

    assert_nil navigation.title
    assert_nil navigation.reference
    assert_equal "Section 1", navigation.children.first.title
  end

  def test_extract_without_toc_reference_id
    epub_path = "test/fixtures/v2_no_toc_reference_id.epub"

    assert_raises ::EpubWorm::Error do
      ::EpubWorm::Extractors::NcxNavigation.extract(epub_path)
    end
  end

  def test_extract_without_toc_reference
    epub_path = "test/fixtures/v2_no_toc_reference.epub"

    assert_raises ::EpubWorm::Error do
      ::EpubWorm::Extractors::NcxNavigation.extract(epub_path)
    end
  end

  def test_extract_without_toc_file
    epub_path = "test/fixtures/v2_no_toc_file.epub"

    assert_raises ::EpubWorm::Error do
      ::EpubWorm::Extractors::NcxNavigation.extract(epub_path)
    end
  end
end
