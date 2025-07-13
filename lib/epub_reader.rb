# frozen_string_literal: true

require_relative "epub_reader/manifest"
require_relative "epub_reader/manifest_item"
require_relative "epub_reader/metadata"
require_relative "epub_reader/navigation"
require_relative "epub_reader/spine"
require_relative "epub_reader/version"

require_relative "epub_reader/extractors/base"
require_relative "epub_reader/extractors/binary"
require_relative "epub_reader/extractors/content"
require_relative "epub_reader/extractors/cover_reference"
require_relative "epub_reader/extractors/manifest"
require_relative "epub_reader/extractors/metadata"
require_relative "epub_reader/extractors/spine"
require_relative "epub_reader/extractors/version"

require_relative "epub_reader/extractors/xhtml_navigation"
require_relative "epub_reader/extractors/ncx_navigation"
require_relative "epub_reader/extractors/navigation"

require_relative "epub_reader/reader"

module EpubReader
  class Error < StandardError; end
end
