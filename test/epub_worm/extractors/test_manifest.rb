# frozen_string_literal: true

require "test_helper"

class TestExtractorsManifest < Minitest::Test
  def test_extract
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"
    manifest = ::EpubWorm::Extractors::Manifest.extract(epub_path)

    assert_equal "id-8980823985225580435", manifest.first.id
    assert_equal "716671940892739718_cover.jpg", manifest.first.reference
    assert_equal "image/jpeg", manifest.first.media_type
  end
end
