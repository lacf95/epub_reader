# frozen_string_literal: true

module EpubReader
  class Spine
    include Enumerable

    attr_accessor :spine_items

    def initialize(spine_items: [])
      @spine_items = spine_items
    end

    def each(&block)
      spine_items.each(&block)
    end
  end
end
