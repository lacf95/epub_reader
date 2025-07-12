# frozen_string_literal: true

module EpubReader
  class Reader
    attr_reader :path

    def initialize(path:)
      @path = path
    end

    def metadata
      @metadata ||= ::EpubReader::Extractors::Metadata.extract(path)
    end

    def cover
      @cover ||= ::EpubReader::Extractors::Cover.extract(path)
    end

    def version
      @version ||= ::EpubReader::Extractors::Version.extract(path)
    end

    def navigation
      @navigation ||= ::EpubReader::Extractors::Navigation.extract(path, version: version)
    end
  end
end
