# frozen_string_literal: true

module EpubReader
  class Metadata
    attr_accessor :title, :authors, :language, :publisher, :description, :published_at, :subjects

    def initialize(
      title: nil,
      authors: [],
      language: nil,
      publisher: nil,
      description: nil,
      published_at: nil,
      subjects: []
    )
      @title = title
      @authors = authors
      @language = language
      @publisher = publisher
      @description = description
      @published_at = published_at
      @subjects = subjects
    end

    def to_h
      {
        title: title,
        authors: authors,
        language: language,
        publisher: publisher,
        description: description,
        published_at: published_at,
        subjects: subjects
      }
    end
  end
end
