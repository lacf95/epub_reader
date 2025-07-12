# frozen_string_literal: true

module EpubReader
  module Extractors
    class NcxNavigation
      extend ::EpubReader::Extractors::Base

      ns_entry :opf, "http://www.idpf.org/2007/opf"
      ns_entry :ncx, "http://www.daisy.org/z3986/2005/ncx/"

      def self.extract(path)
        open_opf(path) do |opf_doc, opf_file_path, zip_file|
          toc_file_path = File.join(File.dirname(opf_file_path), toc_reference(opf_doc))
          toc_file = zip_file.find_entry toc_file_path
          raise ::EpubReader::Error, "toc file not found" unless toc_file

          toc_doc = as_xml toc_file
          nav_points = elements_at(toc_doc, "//ncx:navMap/ncx:navPoint")
          build_navigation nav_points
        end
      end

      def self.toc_reference(opf_doc)
        id = element_at(opf_doc, "//opf:spine")&.[]("toc")
        raise ::EpubReader::Error, "toc file reference id not found" unless id

        reference = element_at(opf_doc, "//opf:manifest/opf:item[@id='#{id}']")&.[]("href")
        return reference if reference

        raise ::EpubReader::Error, "toc file reference not found"
      end

      def self.build_navigation(nav_points)
        navigation = ::EpubReader::Navigation.new
        nav_points.each do |nav_point|
          navigation.children << as_navigation(nav_point)
        end
        navigation
      end

      def self.as_navigation(nav_point)
        ::EpubReader::Navigation.new(
          title: text_at(nav_point, "ncx:navLabel/ncx:text"),
          reference: element_at(nav_point, "ncx:content")["src"],
          children: elements_at(nav_point, "ncx:navPoint").map { |e| as_navigation(e) }
        )
      end

      private_class_method :toc_reference
      private_class_method :build_navigation
    end
  end
end
