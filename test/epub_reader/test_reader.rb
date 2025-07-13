# frozen_string_literal: true

require "test_helper"

class TestReader < Minitest::Test
  def test_cover
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    epub = ::EpubReader::Reader.new(path: epub_path)

    assert_instance_of Tempfile, epub.cover
  end

  def test_cover_reference
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    epub = ::EpubReader::Reader.new(path: epub_path)

    assert_instance_of String, epub.cover_reference
  end

  def test_content
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    reference = "2400617320698039998_11-h-1.htm.xhtml#pgepubid00003"
    epub = ::EpubReader::Reader.new(path: epub_path)

    assert_instance_of Nokogiri::XML::Element, epub.content(reference)
  end

  def test_manifest
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    epub = ::EpubReader::Reader.new(path: epub_path)

    assert_instance_of ::EpubReader::Manifest, epub.manifest
  end

  def test_metadata
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    epub = ::EpubReader::Reader.new(path: epub_path)

    assert_instance_of ::EpubReader::Metadata, epub.metadata
  end

  def test_navigation
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    epub = ::EpubReader::Reader.new(path: epub_path)

    assert_instance_of ::EpubReader::Navigation, epub.navigation
  end

  def test_spine
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    epub = ::EpubReader::Reader.new(path: epub_path)

    assert_instance_of ::EpubReader::Spine, epub.spine
  end

  def test_version
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    epub = ::EpubReader::Reader.new(path: epub_path)

    assert_instance_of Float, epub.version
  end
end
