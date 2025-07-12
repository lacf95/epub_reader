# frozen_string_literal: true

require "test_helper"

class TestExtractorsVersion < Minitest::Test
  def test_extract
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    version = ::EpubReader::Extractors::Version.extract(epub_path)
    assert_equal 3.0, version
  end
end
