# frozen_string_literal: true

module HexletCode
  # Form state render
  class FormRenderer
    attr_reader :options

    def initialize(options)
      default_options = {
        action: options.fetch(:url, '#'),
        method: 'post'
      }
      collected_options = default_options.merge options.except(:url)
      @options = collected_options
    end

    def render_tag(tag_data)
      return '' if tag_data.empty?

      field = FieldRenderer.new
      field.render tag_data
    end

    def render(state)
      stringified_options = options.reduce('') { |acc, (key, val)| acc + " #{key}=\"#{val}\"" }
      stringified_children = state.empty? ? '' : state.map(&method(:render_tag)).join
      "<form#{stringified_options}>#{stringified_children}</form>"
    end
  end
end
