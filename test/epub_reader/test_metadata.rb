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

    assert_equal "My Book", metadata.title
    assert_equal ["Luis Adrian Chávez Fregoso"], metadata.authors
    assert_equal "en", metadata.language
    assert_equal "Adrian's Publishing", metadata.publisher
    assert_equal "Ópera prima from renowed author Adrián", metadata.description
    assert_equal Date.parse("2023-07-11"), metadata.published_at
    assert_equal ["Fantasy"], metadata.subjects
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

    assert_equal({
      title: "My Book",
      authors: ["Luis Adrian Chávez Fregoso"],
      language: "en",
      publisher: "Adrian's Publishing",
      description: "Ópera prima from renowed author Adrián",
      published_at: Date.parse("2023-07-11"),
      subjects: ["Fantasy"]
    }, metadata.to_h)
  end
end
