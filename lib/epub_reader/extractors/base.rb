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
          raise ::EpubReader::Error.new("container.xml not found") unless container_file

          # Read the container file to get opf file path.
          container_doc = Nokogiri::XML(container_file.get_input_stream.read)
          opf_file_path = container_doc.at_xpath("//container:rootfile", ns)["full-path"]

          # Read the opf file to get metadata.
          opf_file = zip_file.find_entry opf_file_path
          raise ::EpubReader::Error.new("opf file not found") unless opf_file

          opf_doc = Nokogiri::XML(opf_file.get_input_stream.read)
          yield opf_doc if block_given?
        end
      end

      def text_at(doc, path)
        doc.at_xpath(path, ns)&.text
      end

      def element_at(doc, path)
        doc.xpath(path, ns)
      end
    end
  end
end
