# frozen_string_literal: true

require "nokogiri"
require "zip"

module EpubReader
  module Extractors
    module Base
      DEFAULT_NS = {
        "container" => "urn:oasis:names:tc:opendocument:xmlns:container"
      }.freeze

      def self.extended(base)
        base.instance_variable_set(:@ns, DEFAULT_NS.dup)
      end

      def ns_entry(prefix, uri)
        @ns ||= {}
        @ns[prefix.to_s] = uri
      end

      def ns
        @ns || {}
      end

      def open_opf(path)
        Zip::File.open(path) do |zip_file|
          # Get the container.xml file to get the opf file path.
          container_file = zip_file.find_entry "META-INF/container.xml"
          raise ::EpubReader::Error, "container.xml not found" unless container_file

          # Read the container file to get opf file path.
          container_doc = Nokogiri::XML(container_file.get_input_stream.read)
          opf_file_path = element_at(container_doc, "//container:rootfile")["full-path"]

          # Read the opf file to get metadata.
          opf_file = zip_file.find_entry opf_file_path
          raise ::EpubReader::Error, "opf file not found" unless opf_file

          opf_doc = Nokogiri::XML(opf_file.get_input_stream.read)
          yield(opf_doc, opf_file_path, zip_file) if block_given?
        end
      end

      def as_xml(file)
        Nokogiri::XML(file.get_input_stream.read)
      end

      def element_at(doc, path)
        doc.at_xpath(path, ns)
      end

      def elements_at(doc, path)
        doc.xpath(path, ns)
      end

      def text_at(doc, path)
        element_at(doc, path)&.text&.strip
      end
    end
  end
end
