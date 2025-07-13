# frozen_string_literal: true

module EpubWorm
  class ManifestItem
    attr_accessor :id, :reference, :media_type

    def initialize(id: nil, reference: nil, media_type: nil, path: nil)
      @id = id
      @reference = reference
      @media_type = media_type
      @path = path
    end

    def file
      ::EpubWorm::Extractors::File.extract(path, reference)
    end

    def to_h
      {
        id: id,
        reference: reference,
        media_type: media_type
      }
    end

    private

    attr_reader :path
  end
end
