# frozen_string_literal: true

module EpubWorm
  class Reader
    attr_reader :path

    def initialize(path:)
      @path = path
    end

    def content(reference)
      ::EpubWorm::Extractors::Content.extract(path, reference)
    end

    def cover
      manifest.find { |manifest_item| manifest_item.reference == cover_reference }
    end

    def cover_reference
      @cover_reference ||= ::EpubWorm::Extractors::CoverReference.extract(path)
    end

    def manifest
      @manifest ||= ::EpubWorm::Extractors::Manifest.extract(path)
    end

    def metadata
      @metadata ||= ::EpubWorm::Extractors::Metadata.extract(path)
    end

    def navigation
      @navigation ||= ::EpubWorm::Extractors::Navigation.extract(path, version: version)
    end

    def spine
      @spine ||= ::EpubWorm::Extractors::Spine.extract(path)
    end

    def version
      @version ||= ::EpubWorm::Extractors::Version.extract(path)
    end
  end
end
