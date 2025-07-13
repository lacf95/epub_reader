# frozen_string_literal: true

require "test_helper"

class TestExtractorsNavigation < Minitest::Test
  def test_extract
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    navigation = ::EpubWorm::Extractors::Navigation.extract(epub_path, version: 3.0)

    assert_instance_of ::EpubWorm::Navigation, navigation
  end

  def test_extractor_for_version_3
    extractor = ::EpubWorm::Extractors::Navigation.extractor_for(3.0)

    assert_equal ::EpubWorm::Extractors::XhtmlNavigation, extractor
  end

  def test_extractor_for_version_2
    extractor = ::EpubWorm::Extractors::Navigation.extractor_for(2.0)

    assert_equal ::EpubWorm::Extractors::NcxNavigation, extractor
  end

  def test_extractor_for_unhandled_version
    assert_raises ::EpubWorm::Error do
      ::EpubWorm::Extractors::Navigation.extractor_for(1.0)
    end
  end
end
