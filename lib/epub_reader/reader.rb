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
  end
end
