# frozen_string_literal: true

module EpubReader
  module Extractors
    class Spine
      extend ::EpubReader::Extractors::Base

      ns_entry :opf, "http://www.idpf.org/2007/opf"

      def self.extract(path)
        open_opf(path) do |opf_doc|
          spine_items = elements_at(opf_doc, "//opf:spine/opf:itemref")
          build_spine(spine_items, opf_doc)
        end
      end

      def self.build_spine(spine_items, opf_doc)
        ::EpubReader::Spine.new(
          manifest_items: spine_items.map { |e| as_manifest_item(e, opf_doc) }
        )
      end

      def self.as_manifest_item(spine_entry, opf_doc)
        id_reference = spine_entry["idref"]
        manifest_entry = element_at(opf_doc, "//opf:manifest/opf:item[@id='#{id_reference}']")
        ::EpubReader::ManifestItem.new(
          id: manifest_entry["id"],
          reference: manifest_entry["href"],
          media_type: manifest_entry["media-type"]
        )
      end

      private_class_method :build_spine
      private_class_method :as_manifest_item
    end
  end
end
