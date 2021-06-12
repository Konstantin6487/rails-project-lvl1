# frozen_string_literal: true

module HexletCode
  # Form data wrapper
  class Form
    attr_accessor :form_data, :state

    INPUT_TYPES = %w[
      button checkbox color date datetime-local
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
      label_data = {
        tag_name: 'label',
        tag_options: { for: name },
        tag_body: name
      }

      unless options.key? :as
        add_tag({ tag_name: 'input', tag_options: tag_options, tag_label: label_data })
        return
      end

      option_as = options[:as]

      if option_as.eql? :text
        add_tag({ tag_name: 'textarea', tag_options: tag_options.except(:as, :type), tag_label: label_data })
        return
      end

      tag_options[:type] = INPUT_TYPES.find { |type| type.to_sym.eql? option_as }
      add_tag({ tag_name: 'input', tag_options: tag_options.except(:as), tag_label: label_data })
    end

    def submit(label = 'Save')
      tag_options = { type: 'submit', value: label }
      add_tag({ tag_name: 'input', tag_options: tag_options })
    end

    private :add_tag
  end
end
