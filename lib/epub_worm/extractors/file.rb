# frozen_string_literal: true

module EpubWorm
  module Extractors
    class File
      extend ::EpubWorm::Extractors::Base

      ns_entry :opf, "http://www.idpf.org/2007/opf"

      def self.extract(path, reference)
        open_opf(path) do |_opf_doc, opf_file_path, zip_file|
          file_path = ::File.join(::File.dirname(opf_file_path), reference)
          file = zip_file.find_entry file_path
          raise ::EpubWorm::Error, "#{reference} file not found" unless file

          file_basename = ::File.basename file_path
          copy_to_temp_file(file, file_basename)
        end
      end

      def self.copy_to_temp_file(file, file_name)
        tempfile = Tempfile.new [file_name]
        tempfile.binmode
        tempfile.write file.get_input_stream.read
        tempfile.rewind
        tempfile
      end

      private_class_method :copy_to_temp_file
    end
  end
end
