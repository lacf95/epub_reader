# frozen_string_literal: true

require_relative "epub_reader/version"
require_relative "epub_reader/metadata"
require_relative "epub_reader/cover"
require_relative "epub_reader/extractors/base"
require_relative "epub_reader/extractors/cover"
require_relative "epub_reader/extractors/metadata"
require_relative "epub_reader/extractors/version"
require_relative "epub_reader/reader"

module EpubReader
  class Error < StandardError; end
end
