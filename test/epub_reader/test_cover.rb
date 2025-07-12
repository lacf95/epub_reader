# frozen_string_literal: true

require "test_helper"

class TestCover < Minitest::Test
  def test_attributes
    name = "file.jpg"
    file = Tempfile.new([name])
    cover = ::EpubReader::Cover.new(
      name: name,
      file: file
    )

    assert_equal "file.jpg", cover.name
    assert_equal file, cover.file
    assert_equal file.path, cover.path
  end
end
