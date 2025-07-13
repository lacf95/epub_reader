# frozen_string_literal: true

module EpubReader
  class Reader
    attr_reader :path

    def initialize(path:)
      @path = path
    end

    def content(reference)
      ::EpubReader::Extractors::Content.extract(path, reference)
    end

    def cover
      manifest.find { |manifest_item| manifest_item.reference == cover_reference }
    end

    def cover_reference
      @cover_reference ||= ::EpubReader::Extractors::CoverReference.extract(path)
    end

    def manifest
      @manifest ||= ::EpubReader::Extractors::Manifest.extract(path)
    end

    def metadata
      @metadata ||= ::EpubReader::Extractors::Metadata.extract(path)
    end

    def navigation
      @navigation ||= ::EpubReader::Extractors::Navigation.extract(path, version: version)
    end

    def spine
      @spine ||= ::EpubReader::Extractors::Spine.extract(path)
    end

    def version
      @version ||= ::EpubReader::Extractors::Version.extract(path)
    end
  end
end
