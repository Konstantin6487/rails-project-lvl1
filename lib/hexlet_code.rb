# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative './parsers'
require_relative './render'

# main Module
module HexletCode
  @tags_data = []
  class Error < StandardError; end

  def self.add_methods(hash) # rubocop:disable Metrics/AbcSize
    hash.define_singleton_method(:tags_data) do
      HexletCode.instance_variable_get(:@tags_data)
    end

    hash.define_singleton_method(:tags_data_push) do |value|
      tags = HexletCode.instance_variable_get(:@tags_data)
      tags.push(value)
    end

    hash.define_singleton_method(:tags_data_clear) do
      HexletCode.instance_variable_set(:@tags_data, [])
    end

    hash.define_singleton_method(:input) do |attr, **options|
      mapping = {
        text: 'textarea',
        input: 'input'
      }
      tag_type = options.fetch(:as, :input)
      tag_name = mapping[tag_type]
      default_tag_options = tag_name.eql?('input') ? { type: 'text' } : {}
      tag_options = { name: attr, value: hash[attr] }
                    .merge(options)
                    .reject { |key| key.eql?(:as) }
      input = {
        tag_name: tag_name,
        tag_options: default_tag_options.merge(tag_options)
      }

      label = {
        tag_name: 'label',
        tag_options: { for: 'name' },
        tag_body: tag_options[:name]
      }
      tags_data_push(label)
      tags_data_push(input)
    end

    hash.define_singleton_method(:submit) do |label = 'Save'|
      tag_name = 'input'
      tag_options = { type: 'submit', value: label }
      submit = { tag_name: tag_name, tag_options: tag_options }
      tags_data_push(submit)
    end
  end

  def self.form_for(user, url: '#')
    HexletCode.add_methods(user)
    block_given? && (yield user)
    stringified_fields = user.tags_data
                             .map { |tag| HexletCode::Tag.build(tag[:tag_name], tag[:tag_options], tag[:tag_body]) }
                             .join
    generated_form = "<form action=\"#{url}\" method=\"post\">#{stringified_fields}</form>"
    user.tags_data_clear
    generated_form
  end

  # Tag builder
  class Tag
    def self.build(*tag_data)
      parsed = parse(tag_data)
      render parsed
    end
  end
end
