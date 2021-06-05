# frozen_string_literal: true

module HexletCode
  # Form data wrapper
  class Form
    attr_accessor :form_data, :tags_data

    MAPPING_TAGS = { text: 'textarea', input: 'input' }.freeze

    def initialize(form_data)
      @form_data = form_data
      @tags_data = []
    end

    def add_tags(*tags)
      tags.each { |tag| tags_data.push tag }
    end

    def input(name, **options)
      tag_type = options.fetch(:as, :input)
      tag_name = MAPPING_TAGS[tag_type]
      default_tag_options = tag_name.eql?('input') ? { type: 'text' } : {}
      tag_options = { name: name, value: form_data[name] }
                    .merge(options)
                    .reject { |key| key.eql?(:as) }
      input_data = {
        tag_name: tag_name,
        tag_options: default_tag_options.merge(tag_options)
      }
      stringified_input = Tag.build(input_data[:tag_name], **input_data[:tag_options])

      label('label', for: name) { tag_options[:name] }
      add_tags stringified_input
    end

    def label(tag_name, **options, &block)
      stringified_label = Tag.build(tag_name, options, &block)
      add_tags stringified_label
    end

    def submit(label = 'Save')
      tag_name = 'input'
      tag_options = { type: 'submit', value: label }
      submit = { tag_name: tag_name, tag_options: tag_options }
      stringified_submit = Tag.build(submit[:tag_name], **submit[:tag_options])
      add_tags stringified_submit
    end

    def to_s
      tags_data.join
    end

    private :add_tags
  end
end
