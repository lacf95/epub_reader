# frozen_string_literal: true

require "test_helper"

class TestExtractorsSpine < Minitest::Test
  def test_extract
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    spine = ::EpubWorm::Extractors::Spine.extract(epub_path)

    assert_equal "coverpage-wrapper", spine.first.id
    assert_equal "wrap0000.xhtml", spine.first.reference
    assert_equal "application/xhtml+xml", spine.first.media_type
  end
end
