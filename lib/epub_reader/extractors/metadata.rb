# frozen_string_literal: true

require "date"

module EpubReader
  module Extractors
    class Metadata
      # ------------------------------------------------------------------------
      # Constants
      # ------------------------------------------------------------------------
      SUBJECT_SEPARATOR = " -- "

      # ------------------------------------------------------------------------
      # Extends
      # ------------------------------------------------------------------------
      extend EpubReader::Extractors::Base

      ns_entry :dc, "http://purl.org/dc/elements/1.1/"

      def self.extract(path)
        open_opf(path) do |opf_doc|
          ::EpubReader::Metadata.new(
            title: text_at(opf_doc, "//dc:title"),
            authors: element_at(opf_doc, "//dc:creator").map(&:text).map(&:strip).reject(&:empty?),
            language: text_at(opf_doc, "//dc:language"),
            publisher: text_at(opf_doc, "//dc:publisher"),
            description: text_at(opf_doc, "//dc:description"),
            published_at: text_at(opf_doc, "//dc:date") && Date.parse(text_at(opf_doc, "//dc:date")),
            subjects: element_at(opf_doc, "//dc:subject").reduce([]) do |subjects, subject|
              subjects += subject.text.split(SUBJECT_SEPARATOR).map(&:strip).reject(&:empty?)
              subjects.uniq
            end
          )
        end
      end
    end
  end
end
