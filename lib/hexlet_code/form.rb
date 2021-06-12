# frozen_string_literal: true

module HexletCode
  # Form data wrapper
  class Form
    attr_accessor :form_data, :state

    INPUT_TYPES = %w[
      text button checkbox color date datetime-local
      email file hidden image month number password
      radio range reset search tel time url week
    ].freeze

    def initialize(form_data)
      @state = []
      @form_data = form_data
    end

    def add_tag(tag_data)
      state.push tag_data
    end

    def input(name, **options)
      tag_options = { type: 'text', name: name, value: form_data[name] }.merge(options)
      label('label', for: name) { name }

      unless options.key? :as
        add_tag({ tag_name: 'input', tag_options: tag_options })
        return
      end

      option_as = options[:as]

      if option_as.eql? :text
        add_tag({ tag_name: 'textarea', tag_options: tag_options.except(:as, :type) })
        return
      end

      tag_options[:type] = INPUT_TYPES.find { |type| type.to_sym.eql? option_as }
      add_tag({ tag_name: 'input', tag_options: tag_options.except(:as) })
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
