# frozen_string_literal: true

require_relative "epub_worm/manifest"
require_relative "epub_worm/manifest_item"
require_relative "epub_worm/metadata"
require_relative "epub_worm/navigation"
require_relative "epub_worm/spine"
require_relative "epub_worm/version"

require_relative "epub_worm/extractors/base"
require_relative "epub_worm/extractors/file"
require_relative "epub_worm/extractors/content"
require_relative "epub_worm/extractors/cover_reference"
require_relative "epub_worm/extractors/manifest"
require_relative "epub_worm/extractors/metadata"
require_relative "epub_worm/extractors/spine"
require_relative "epub_worm/extractors/version"

require_relative "epub_worm/extractors/xhtml_navigation"
require_relative "epub_worm/extractors/ncx_navigation"
require_relative "epub_worm/extractors/navigation"

require_relative "epub_worm/reader"

module EpubWorm
  class Error < StandardError; end
end
