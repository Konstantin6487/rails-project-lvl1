# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative './parsers'
require_relative './render'

# main Module
module HexletCode
  @stringified_tags = []
  class Error < StandardError; end

  def self.add_methods(hash) # rubocop:disable Metrics/AbcSize
    hash.define_singleton_method(:stringified_tags) do
      HexletCode.instance_variable_get(:@stringified_tags)
    end

    hash.define_singleton_method(:stringified_tags_push) do |value|
      tags = HexletCode.instance_variable_get(:@stringified_tags)
      tags.push(value)
    end

    hash.define_singleton_method(:stringified_tags_clear) do
      HexletCode.instance_variable_set(:@stringified_tags, [])
    end

    hash.define_singleton_method(:input) do |*attrs, **options|
      mapping = {
        text: 'textarea',
        input: 'input'
      }
      tag_type = options.fetch(:as, :input)
      tag_name = mapping[tag_type]
      tag_options = to_h
                    .select { |attr| attrs.include? attr }
                    .merge(options)
                    .reject { |key| key.eql?(:as) }
      value = HexletCode::Tag.build(tag_name, tag_options)
      stringified_tags_push(value)
    end

    hash.define_singleton_method(:submit) do |label = 'Save'|
      tag_type = 'input'
      tag_options = { type: 'submit', value: label }
      value = HexletCode::Tag.build(tag_type, tag_options)
      stringified_tags_push(value)
    end
  end

  def self.form_for(user, url: '#')
    HexletCode.add_methods(user)
    block_given? && (yield user)
    generated_form = "<form action=\"#{url}\" method=\"post\">#{user.stringified_tags.join}</form>"
    user.stringified_tags_clear
    generated_form
  end

  # Tag builder
  class Tag
    def self.build(*tag, &block)
      parsed = parse(tag, &block)
      render parsed
    end
  end
end
