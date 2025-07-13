# frozen_string_literal: true

module EpubWorm
  module Extractors
    class Version
      extend ::EpubWorm::Extractors::Base

      ns_entry :opf, "http://www.idpf.org/2007/opf"

      def self.extract(path)
        open_opf(path) do |opf_doc|
          element_at(opf_doc, "/opf:package")["version"].to_f
        end
      end
    end
  end
end
