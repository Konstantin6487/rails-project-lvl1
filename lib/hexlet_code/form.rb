# frozen_string_literal: true

module HexletCode
  # Form data wrapper
  class Form
    attr_accessor :form_data, :state

    MAPPING_TAGS = { text: 'textarea', input: 'input' }.freeze

    def initialize(form_data)
      @state = []
      @form_data = form_data
    end

    def add_tag(tag_data)
      state.push tag_data
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

      label('label', for: name) { tag_options[:name] }
      add_tag input_data
    end

    def label(tag_name, **options, &block)
      label_data = {
        tag_name: tag_name,
        tag_options: options,
        tag_body: block
      }
      add_tag label_data
    end

    def submit(label = 'Save')
      tag_name = 'input'
      tag_options = { type: 'submit', value: label }
      submit_data = { tag_name: tag_name, tag_options: tag_options }
      add_tag submit_data
    end

    private :add_tag
  end
end
