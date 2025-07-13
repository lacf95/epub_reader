# frozen_string_literal: true

require "test_helper"

class TestManifest < Minitest::Test
  def test_attributes
    manifest = ::EpubWorm::Manifest.new(manifest_items: [])

    assert_equal [], manifest.manifest_items
  end

  def test_default_attributes
    manifest = ::EpubWorm::Manifest.new

    assert_equal [], manifest.manifest_items
  end

  def test_each_yields_manifest_items
    manifest_item = Struct.new(:id)
    manifest = ::EpubWorm::Manifest.new(manifest_items: [manifest_item.new(id: "A"), manifest_item.new(id: "B")])

    result = manifest.map(&:id)

    assert_equal ["A", "B"], result
  end
end
