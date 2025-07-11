# frozen_string_literal: true

require "test_helper"

class TestReader < Minitest::Test
  def test_metadata
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    epub = ::EpubReader::Reader.new(path: epub_path)
    assert_instance_of ::EpubReader::Metadata, epub.metadata
  end
end
