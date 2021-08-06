# frozen_string_literal: true

module HexletCode
  # Form state render
  class FormRenderer
    attr_reader :options, :tag_render

    def initialize(options)
      default_options = {
        action: options.fetch(:url, '#'),
        method: 'post'
      }
      collected_options = default_options.merge options.except(:url)
      @options = collected_options
      @tag_render = Tag.new
    end

    def render_field(tag_data)
      return '' if tag_data.empty?

      field_label = tag_render.render(tag_data[:tag_label] || {})
      field = tag_render.render tag_data
      "#{field_label}#{field}"
    end

    def render(state)
      form_body = state.empty? ? '' : state.map(&method(:render_field)).join
      form_data = { tag_name: 'form', tag_options: options, tag_body: form_body }
      tag_render.render form_data
    end

    private :render_field
  end
end
