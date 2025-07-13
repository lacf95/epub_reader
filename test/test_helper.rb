# frozen_string_literal: true

require "simplecov"

SimpleCov.external_at_exit = true

SimpleCov.start do
  add_filter "/test/"
  add_group "Extractors", "lib/epub_worm/extractors"
  enable_coverage :branch
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "epub_worm"

require "minitest/autorun"
