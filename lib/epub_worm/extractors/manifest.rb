# frozen_string_literal: true

module EpubWorm
  module Extractors
    class Manifest
      extend ::EpubWorm::Extractors::Base

      ns_entry :opf, "http://www.idpf.org/2007/opf"

      def self.extract(path)
        open_opf(path) do |opf_doc|
          manifest_items = elements_at(opf_doc, "//opf:manifest/opf:item")
          build_manifest(manifest_items, path)
        end
      end

      def self.build_manifest(manifest_items, path)
        ::EpubWorm::Manifest.new(
          manifest_items: manifest_items.map { |e| as_manifest_item(e, path) }
        )
      end

      def self.as_manifest_item(manifest_entry, path)
        ::EpubWorm::ManifestItem.new(
          id: manifest_entry["id"],
          reference: manifest_entry["href"],
          media_type: manifest_entry["media-type"],
          path: path
        )
      end

      private_class_method :build_manifest
      private_class_method :as_manifest_item
    end
  end
end
