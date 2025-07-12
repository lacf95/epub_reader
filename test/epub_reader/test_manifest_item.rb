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
