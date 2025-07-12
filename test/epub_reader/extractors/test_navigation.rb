# frozen_string_literal: true

require "test_helper"

class TestExtractorsNavigation < Minitest::Test
  def test_extract
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    navigation = ::EpubReader::Extractors::Navigation.extract(epub_path, version: 3.0)
    assert_instance_of ::EpubReader::Navigation, navigation
  end

  def test_extractor_for_version_3
    extractor = ::EpubReader::Extractors::Navigation.extractor_for(3.0)
    assert_equal ::EpubReader::Extractors::XhtmlNavigation, extractor
  end

  def test_extractor_for_version_2
    extractor = ::EpubReader::Extractors::Navigation.extractor_for(2.0)
    assert_equal ::EpubReader::Extractors::NcxNavigation, extractor
  end

  def test_extractor_for_unhandled_version
    assert_raises ::EpubReader::Error do
      ::EpubReader::Extractors::Navigation.extractor_for(1.0)
    end
  end
end
