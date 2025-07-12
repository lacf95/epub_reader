# frozen_string_literal: true

require "test_helper"

class TestSpine < Minitest::Test
  def test_attributes
    spine = ::EpubReader::Spine.new(spine_items: [])

    assert_equal [], spine.spine_items
  end

  def test_default_attributes
    spine = ::EpubReader::Spine.new

    assert_equal [], spine.spine_items
  end

  def test_each_yields_spine_items
    spine_item = Struct.new(:id)
    spine = ::EpubReader::Spine.new(spine_items: [spine_item.new(id: "A"), spine_item.new(id: "B")])

    result = spine.map(&:id)

    assert_equal ["A", "B"], result
  end
end
