# frozen_string_literal: true

require "test_helper"

class TestSpine < Minitest::Test
  def test_attributes
    spine = ::EpubWorm::Spine.new(manifest_items: [])

    assert_equal [], spine.manifest_items
  end

  def test_default_attributes
    spine = ::EpubWorm::Spine.new

    assert_equal [], spine.manifest_items
  end

  def test_each_yields_manifest_items
    manifest_item = Struct.new(:id)
    spine = ::EpubWorm::Spine.new(manifest_items: [manifest_item.new(id: "A"), manifest_item.new(id: "B")])

    result = spine.map(&:id)

    assert_equal ["A", "B"], result
  end
end
