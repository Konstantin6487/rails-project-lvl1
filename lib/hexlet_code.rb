# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative './render'
require_relative './parser'

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
      tag_name = options.fetch(:as, 'input')
      value = HexletCode::Tag.build(tag_name, to_h.select { |attr| attrs.include? attr })
      stringified_tags_push(value)
    end

    hash.define_singleton_method(:submit) do |label = 'Save'|
      tag_name = 'input'
      attrs = { type: 'submit', value: label }
      value = HexletCode::Tag.build(tag_name, attrs)
      stringified_tags_push(value)
    end
  end

  def self.form_for(user)
    HexletCode.add_methods(user)
    block_given? && (yield user)
    generated_form = "<form action=\"#\" method=\"post\">#{user.stringified_tags.join}</form>"
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
