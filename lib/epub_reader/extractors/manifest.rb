# frozen_string_literal: true

module EpubReader
  module Extractors
    class Manifest
      extend ::EpubReader::Extractors::Base

      ns_entry :opf, "http://www.idpf.org/2007/opf"

      def self.extract(path)
        open_opf(path) do |opf_doc|
          manifest_items = elements_at(opf_doc, "//opf:manifest/opf:item")
          build_manifest(manifest_items)
        end
      end

      def self.build_manifest(manifest_items)
        ::EpubReader::Manifest.new(
          manifest_items: manifest_items.map { |e| as_manifest_item(e) }
        )
      end

      def self.as_manifest_item(manifest_entry)
        ::EpubReader::ManifestItem.new(
          id: manifest_entry["id"],
          reference: manifest_entry["href"],
          media_type: manifest_entry["media-type"]
        )
      end

      private_class_method :build_manifest
      private_class_method :as_manifest_item
    end
  end
end
