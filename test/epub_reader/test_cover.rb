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

    assert_equal cover.name, "file.jpg"
    assert_equal cover.file, file
    assert_equal cover.path, file.path
  end
end
