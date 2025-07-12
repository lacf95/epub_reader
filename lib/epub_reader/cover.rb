# frozen_string_literal: true

module EpubReader
  class Cover
    attr_reader :name, :file

    def initialize(name: nil, file: nil)
      @name = name
      @file = file
    end

    def path
      file&.path
    end
  end
end
