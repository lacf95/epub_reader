# frozen_string_literal: true

module EpubReader
  class ManifestItem
    attr_accessor :id, :reference, :media_type

    def initialize(id: nil, reference: nil, media_type: nil)
      @id = id
      @reference = reference
      @media_type = media_type
    end

    def to_h
      {
        id: id,
        reference: reference,
        media_type: media_type
      }
    end
  end
end
