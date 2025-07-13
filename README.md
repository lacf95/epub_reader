# EpubReader

EpubReader is just another EPUB parser gem, with only two dependencies: "rubyzip" and "nokogiri".

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add epub_reader

Or add this line to your Gemfile:

```ruby
gem "epub_reader"
```

And run

    $ bundle install

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install epub_reader

## Usage

To read EPUB files:

```ruby
require "epub_reader"

epub = EpubReader::Reader.new(path: "your_file.epub")
```

### Metadata

```ruby
epub.metadata.title        # => "Alice's Adventures in Wonderland"
epub.metadata.authors      # => ["Lewis Carroll"]
epub.metadata.language     # => "en"
epub.metadata.publisher    # => "Project Gutenberg"
epub.metadata.published_at # => Date or nil
epub.metadata.subjects     # => ["Fantasy", "Children’s literature"]
```

### EPUB version

```ruby
epub.version # => 2.0 or 3.0
```

### Cover image

Returns a ManifestItem that includes .file to access the image as a tempfile.

```ruby
cover_item = epub.cover
cover_item.media_type # => "image/jpeg"
File.open("cover.jpg", "wb") { |f| f.write(cover_item.file.read) }
```

### Manifest

The manifest lists all items in the EPUB: XHTML pages, CSS files, images, fonts, etc.

```ruby
epub.manifest.each do |manifest_item|
  puts "#{manifest_item.id}: #{manifest_item.reference} (#{manifest_item.media_type})"
end
```

### Spine (Reading Order)

The spine lists the linear reading order of content documents.

```ruby
epub.spine.each do |manifest_item|
  puts item.reference # => e.g., "chapter1.xhtml"
end
```

### Navigation (Table of Contents)

The navigation object provides a tree structure of headings.

```ruby
epub.navigation.each do |entry|
  puts entry.title
  puts entry.reference
end
```

You can also recursively access nested entries:

```ruby
epub.navigation.each do |top|
  puts top.title
  top.children.each do |child|
    puts "  - #{child.title}"
  end
end
```

### Extract Content

You can fetch a specific file by its navigation or spine reference:

```ruby
doc = epub.content("chapter1.xhtml")
doc.at_css("h1").text # => "Chapter 1"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lacf95/epub_reader. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/lacf95/epub_reader/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the EpubReader project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lacf95/epub_reader/blob/master/CODE_OF_CONDUCT.md).
