# frozen_string_literal: true

require "test_helper"

class TestNavigation < Minitest::Test
  def test_attributes
    navigation = ::EpubWorm::Navigation.new(
      title: "Chapter 1",
      reference: "chapter1.xhtml",
      children: []
    )

    assert_equal "Chapter 1", navigation.title
    assert_equal "chapter1.xhtml", navigation.reference
    assert_equal [], navigation.children
  end

  def test_default_attributes
    navigation = ::EpubWorm::Navigation.new

    assert_nil navigation.title
    assert_nil navigation.reference
    assert_equal [], navigation.children
  end

  def test_each_yields_children
    child_one = ::EpubWorm::Navigation.new(title: "A")
    child_two = ::EpubWorm::Navigation.new(title: "B")
    navigation = ::EpubWorm::Navigation.new(children: [child_one, child_two])

    result = navigation.map(&:title)

    assert_equal ["A", "B"], result
  end
end
