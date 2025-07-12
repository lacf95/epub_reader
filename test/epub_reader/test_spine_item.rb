# frozen_string_literal: true

require "test_helper"

class TestSpineItem < Minitest::Test
  def test_attributes
    spine_item = ::EpubReader::SpineItem.new(
      id: "A",
      reference: "file.xhtml#A",
      media_type: "application/xhtml+xml"
    )

    assert_equal "A", spine_item.id
    assert_equal "file.xhtml#A", spine_item.reference
    assert_equal "application/xhtml+xml", spine_item.media_type
  end

  def test_default_attributes
    spine_item = ::EpubReader::SpineItem.new

    assert_nil spine_item.id
    assert_nil spine_item.reference
    assert_nil spine_item.media_type
  end

  def test_to_h
    spine_item = ::EpubReader::SpineItem.new(
      id: "A",
      reference: "file.xhtml#A",
      media_type: "application/xhtml+xml"
    )

    assert_equal({
      id: "A",
      reference: "file.xhtml#A",
      media_type: "application/xhtml+xml"
    }, spine_item.to_h)
  end
end
