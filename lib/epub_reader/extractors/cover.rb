# frozen_string_literal: true

module EpubReader
  module Extractors
    class Cover
      # ------------------------------------------------------------------------
      # Extends
      # ------------------------------------------------------------------------
      extend EpubReader::Extractors::Base

      ns_entry :opf, "http://www.idpf.org/2007/opf"

      def self.extract(path)
        open_opf(path) do |opf_doc, opf_doc_path, zip_file|
          # Find the cover id otherwise use the default cover
          cover_id = element_at(opf_doc, "//opf:metadata/opf:meta[@name='cover']")&.[]("content")
          item_xpath = if cover_id
                         "//opf:manifest/opf:item[@id='#{cover_id}']"
                       else
                         "//opf:manifest/opf:item[contains(@href, 'cover') and contains(@media-type, 'image')]"
                       end

          item_href = element_at(opf_doc, item_xpath)&.[]("href")
          return unless item_href

          cover_file_path = File.join(File.dirname(opf_doc_path), item_href)
          cover_file = zip_file.find_entry cover_file_path
          return unless cover_file

          basename = File.basename cover_file_path
          tempfile = Tempfile.new [basename]
          tempfile.binmode
          tempfile.write cover_file.get_input_stream.read
          tempfile.rewind
          ::EpubReader::Cover.new(name: basename, file: tempfile)
        end
      end
    end
  end
end
