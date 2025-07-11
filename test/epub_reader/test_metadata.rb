# frozen_string_literal: true

require "test_helper"

class TestMetadata < Minitest::Test
  def test_attributes
    metadata = ::EpubReader::Metadata.new(
      title: "My Book",
      authors: ["Luis Adrian Chávez Fregoso"],
      language: "en",
      publisher: "Adrian's Publishing",
      description: "Ópera prima from renowed author Adrián",
      published_at: Date.parse("2023-07-11"),
      subjects: ["Fantasy"]
    )

    assert_equal metadata.title, "My Book"
    assert_equal metadata.authors, ["Luis Adrian Chávez Fregoso"]
    assert_equal metadata.language, "en"
    assert_equal metadata.publisher, "Adrian's Publishing"
    assert_equal metadata.description, "Ópera prima from renowed author Adrián"
    assert_equal metadata.published_at, Date.parse("2023-07-11")
    assert_equal metadata.subjects, ["Fantasy"]
  end

  def test_to_h
    metadata = ::EpubReader::Metadata.new(
      title: "My Book",
      authors: ["Luis Adrian Chávez Fregoso"],
      language: "en",
      publisher: "Adrian's Publishing",
      description: "Ópera prima from renowed author Adrián",
      published_at: Date.parse("2023-07-11"),
      subjects: ["Fantasy"]
    )

    assert_equal metadata.to_h, {
      title: "My Book",
      authors: ["Luis Adrian Chávez Fregoso"],
      language: "en",
      publisher: "Adrian's Publishing",
      description: "Ópera prima from renowed author Adrián",
      published_at: Date.parse("2023-07-11"),
      subjects: ["Fantasy"]
    }
  end

  def test_default_attributes
    metadata = ::EpubReader::Metadata.new

    assert_nil metadata.title
    assert_equal [], metadata.authors
    assert_nil metadata.language
    assert_nil metadata.publisher
    assert_nil metadata.description
    assert_nil metadata.published_at
    assert_equal [], metadata.subjects
  end
end
