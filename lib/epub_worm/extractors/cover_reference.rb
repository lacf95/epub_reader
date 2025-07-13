# frozen_string_literal: true

module EpubWorm
  module Extractors
    class CoverReference
      extend ::EpubWorm::Extractors::Base

      ns_entry :opf, "http://www.idpf.org/2007/opf"

      def self.extract(path)
        open_opf(path) do |opf_doc, opf_file_path, zip_file|
          cover_id = element_at(opf_doc, "//opf:metadata/opf:meta[@name='cover']")&.[]("content")
          item_xpath = if cover_id
            "//opf:manifest/opf:item[@id='#{cover_id}']"
          else
            "//opf:manifest/opf:item[contains(@href, 'cover') and contains(@media-type, 'image')]"
          end

          element_at(opf_doc, item_xpath)&.[]("href")
        end
      end
    end
  end
end
