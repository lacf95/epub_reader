# frozen_string_literal: true

module EpubReader
  module Extractors
    class XhtmlNavigation
      extend ::EpubReader::Extractors::Base

      ns_entry :opf, "http://www.idpf.org/2007/opf"
      ns_entry :epub, "http://www.idpf.org/2007/ops"
      ns_entry :xhtml, "http://www.w3.org/1999/xhtml"

      def self.extract(path)
        open_opf(path) do |opf_doc, opf_file_path, zip_file|
          nav_file_path = File.join(File.dirname(opf_file_path), nav_reference(opf_doc))
          nav_file = zip_file.find_entry nav_file_path
          raise ::EpubReader::Error, "nav file not found" unless nav_file

          nav_doc = as_xml nav_file
          nav_points = elements_at(nav_doc, "//xhtml:nav[@epub:type='toc']/xhtml:ol/xhtml:li")
          build_navigation nav_points
        end
      end

      def self.nav_reference(opf_doc)
        reference = element_at(opf_doc, "//opf:manifest/opf:item[@properties='nav']")&.[]("href")
        return reference if reference

        raise ::EpubReader::Error, "nav file reference not found"
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
          title: text_at(nav_point, "xhtml:a"),
          reference: element_at(nav_point, "xhtml:a")["href"],
          children: elements_at(nav_point, "xhtml:ol/xhtml:li").map { |e| as_navigation(e) }
        )
      end

      private_class_method :nav_reference
      private_class_method :build_navigation
    end
  end
end
