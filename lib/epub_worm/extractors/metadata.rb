# frozen_string_literal: true

require "date"

module EpubWorm
  module Extractors
    class Metadata
      SUBJECT_SEPARATOR = " -- "

      extend ::EpubWorm::Extractors::Base

      ns_entry :dc, "http://purl.org/dc/elements/1.1/"

      def self.extract(path)
        open_opf(path) do |opf_doc|
          ::EpubWorm::Metadata.new(
            title: text_at(opf_doc, "//dc:title"),
            authors: elements_at(opf_doc, "//dc:creator").map(&:text).map(&:strip).reject(&:empty?),
            language: text_at(opf_doc, "//dc:language"),
            publisher: text_at(opf_doc, "//dc:publisher"),
            description: text_at(opf_doc, "//dc:description"),
            published_at: text_at(opf_doc, "//dc:date") && Date.parse(text_at(opf_doc, "//dc:date")),
            subjects: elements_at(opf_doc, "//dc:subject").reduce([]) do |subjects, subject|
              subjects += subject.text.split(SUBJECT_SEPARATOR).map(&:strip).reject(&:empty?)
              subjects.uniq
            end
          )
        end
      end
    end
  end
end
