# frozen_string_literal: true

require "test_helper"

class TestReader < Minitest::Test
  def test_metadata
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    epub = ::EpubReader::Reader.new(path: epub_path)

    assert_instance_of ::EpubReader::Metadata, epub.metadata
  end

  def test_cover
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    epub = ::EpubReader::Reader.new(path: epub_path)

    assert_instance_of ::EpubReader::Cover, epub.cover
  end

  def test_version
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    epub = ::EpubReader::Reader.new(path: epub_path)

    assert_instance_of Float, epub.version
  end

  def test_navigation
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    epub = ::EpubReader::Reader.new(path: epub_path)

    assert_instance_of ::EpubReader::Navigation, epub.navigation
  end
end
