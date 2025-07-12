# frozen_string_literal: true

module EpubReader
  module Extractors
    class Navigation
      def self.extract(path, version:)
        extractor_for(version).extract(path)
      end

      def self.extractor_for(version)
        case version
        when 3
          ::EpubReader::Extractors::XhtmlNavigation
        when 2
          ::EpubReader::Extractors::NcxNavigation
        else
          raise ::EpubReader::Error, "unsupported epub version: #{version.inspect}"
        end
      end
    end
  end
end
