# frozen_string_literal: true

module EpubReader
  module Extractors
    class Cover
      extend ::EpubReader::Extractors::Base

      ns_entry :opf, "http://www.idpf.org/2007/opf"

      def self.extract(path)
        open_opf(path) do |opf_doc, opf_doc_path, zip_file|
          cover_file_name = cover_reference(opf_doc)
          return unless cover_file_name

          cover_file_path = File.join(File.dirname(opf_doc_path), cover_file_name)
          cover_file = zip_file.find_entry cover_file_path
          return unless cover_file

          cover_basename = File.basename cover_file_path
          tempfile = copy_to_temp_file(cover_file, cover_basename)
          ::EpubReader::Cover.new(name: cover_basename, file: tempfile)
        end
      end

      def self.cover_reference(opf_doc)
        cover_id = element_at(opf_doc, "//opf:metadata/opf:meta[@name='cover']")&.[]("content")
        item_xpath = if cover_id
          "//opf:manifest/opf:item[@id='#{cover_id}']"
        else
          "//opf:manifest/opf:item[contains(@href, 'cover') and contains(@media-type, 'image')]"
        end

        element_at(opf_doc, item_xpath)&.[]("href")
      end

      def self.copy_to_temp_file(file, file_name)
        tempfile = Tempfile.new [file_name]
        tempfile.binmode
        tempfile.write file.get_input_stream.read
        tempfile.rewind
        tempfile
      end

      private_class_method :cover_reference
      private_class_method :copy_to_temp_file
    end
  end
end
