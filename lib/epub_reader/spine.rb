# frozen_string_literal: true

module EpubReader
  class Spine
    include Enumerable

    attr_accessor :manifest_items

    def initialize(manifest_items: [])
      @manifest_items = manifest_items
    end

    def each(&block)
      manifest_items.each(&block)
    end
  end
end
