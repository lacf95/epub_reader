# frozen_string_literal: true

require "test_helper"

class TestEpubWorm < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::EpubWorm::VERSION
  end
end
