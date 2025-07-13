# frozen_string_literal: true

module EpubWorm
  class Navigation
    include Enumerable

    attr_accessor :title, :reference, :children

    def initialize(title: nil, reference: nil, children: [])
      @title = title
      @reference = reference
      @children = children
    end

    def each(&block)
      children.each(&block)
    end
  end
end
