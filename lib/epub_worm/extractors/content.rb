# frozen_string_literal: true

module EpubWorm
  module Extractors
    class Content
      extend ::EpubWorm::Extractors::Base

      def self.extract(path, reference)
        open_opf(path) do |_opf_doc, opf_file_path, zip_file|
          content_file_name, content_fragment = reference.split("#", 2)
          content_file_path = ::File.join(::File.dirname(opf_file_path), content_file_name)
          content_file = zip_file.find_entry(content_file_path)
          raise ::EpubWorm::Error, "#{content_file_name} not found" unless content_file

          content_doc = as_xml(content_file)
          return content_doc unless content_fragment

          fragment_content_doc = element_at(content_doc, "//*[@id='#{content_fragment}']")
          raise ::EpubWorm::Error, "#{content_file_name}#{content_fragment} not found" unless fragment_content_doc

          fragment_content_doc
        end
      end
    end
  end
end
