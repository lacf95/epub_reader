# frozen_string_literal: true

module EpubWorm
  module Extractors
    class Navigation
      def self.extract(path, version:)
        extractor_for(version).extract(path)
      end

      def self.extractor_for(version)
        case version
        when 3
          ::EpubWorm::Extractors::XhtmlNavigation
        when 2
          ::EpubWorm::Extractors::NcxNavigation
        else
          raise ::EpubWorm::Error, "unsupported epub version: #{version.inspect}"
        end
      end
    end
  end
end
