# frozen_string_literal: true

require "test_helper"

class DummyExtractor
  extend ::EpubReader::Extractors::Base

  ns_entry :dc, "http://purl.org/dc/elements/1.1/"
end

class TestExtractorsBase < Minitest::Test
  def test_opf_doc_read
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"

    DummyExtractor.open_opf(epub_path) do |opf_doc|
      assert_instance_of Nokogiri::XML::Document, opf_doc
    end
  end

  def test_opf_doc_read_without_block
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"

    assert_nil DummyExtractor.open_opf(epub_path)
  end

  def test_raise_error_when_no_container_file_found
    epub_path = "test/fixtures/no_container_file.epub"

    assert_raises ::EpubReader::Error do
      DummyExtractor.open_opf(epub_path)
    end
  end

  def test_raise_error_when_no_content_file_found
    epub_path = "test/fixtures/no_content_file.epub"

    assert_raises ::EpubReader::Error do
      DummyExtractor.open_opf(epub_path)
    end
  end

  def test_text_at
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"

    DummyExtractor.open_opf(epub_path) do |opf_doc|
      assert_equal "Alice's Adventures in Wonderland", DummyExtractor.text_at(opf_doc, "//dc:title")
    end
  end

  def test_text_at_without_matching_element
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"

    DummyExtractor.open_opf(epub_path) do |opf_doc|
      assert_nil DummyExtractor.text_at(opf_doc, "//dc:title_two")
    end
  end

  def test_elements_at
    epub_path = "test/fixtures/alices_adventures_in_wonderland.epub"

    DummyExtractor.open_opf(epub_path) do |opf_doc|
      assert_equal ["Lewis Carroll"], DummyExtractor.elements_at(opf_doc, "//dc:creator").map(&:text)
    end
  end
end
