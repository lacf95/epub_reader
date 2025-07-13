# frozen_string_literal: true

require "test_helper"

class TestManifestItem < Minitest::Test
  def test_attributes
    manifest_item = ::EpubReader::ManifestItem.new(
      id: "A",
      reference: "file.xhtml#A",
      media_type: "application/xhtml+xml"
    )

    assert_equal "A", manifest_item.id
    assert_equal "file.xhtml#A", manifest_item.reference
    assert_equal "application/xhtml+xml", manifest_item.media_type
  end

  def test_default_attributes
    manifest_item = ::EpubReader::ManifestItem.new

    assert_nil manifest_item.id
    assert_nil manifest_item.reference
    assert_nil manifest_item.media_type
  end

  def test_file
    manifest_item = ::EpubReader::ManifestItem.new(
      id: "id-8980823985225580435",
      reference: "716671940892739718_cover.jpg",
      media_type: "image/jpeg",
      path: "test/fixtures/alices_adventures_in_wonderland.epub"
    )

    assert_instance_of Tempfile, manifest_item.file
  end

  def test_to_h
    manifest_item = ::EpubReader::ManifestItem.new(
      id: "A",
      reference: "file.xhtml#A",
      media_type: "application/xhtml+xml"
    )

    assert_equal({
      id: "A",
      reference: "file.xhtml#A",
      media_type: "application/xhtml+xml"
    }, manifest_item.to_h)
  end
end
