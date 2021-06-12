# frozen_string_literal: true

module HexletCode
  # Form state render
  class FormRenderer
    attr_reader :options

    SINGLE_TAGS_LIST = %w[area base br col embed hr img input link meta param source track wbr].freeze

    def initialize(options)
      default_options = {
        action: options.fetch(:url, '#'),
        method: 'post'
      }
      collected_options = default_options.merge options.except(:url)
      @options = collected_options
    end

    def build_attrs(attrs_data)
      return '' if attrs_data.empty?

      attrs_data.keys.map { |attr| " #{attr}=\"#{attrs_data[attr]}\"" }.join
    end

    def render_tag(tag_data)
      return '' if tag_data.empty?

      tag_name = tag_data[:tag_name]
      tag_options = tag_data[:tag_options] || {}
      tag_body = tag_data[:tag_body] || ''
      tag_label_data = tag_data[:tag_label] || {}

      stringified_attrs = build_attrs tag_options
      stringified_body = tag_name.eql?('label') ? tag_body.capitalize : tag_body
      stringified_label = render_tag tag_label_data

      if SINGLE_TAGS_LIST.include? tag_name
        "#{stringified_label}<#{tag_name}#{stringified_attrs}>"
      else
        "#{stringified_label}<#{tag_name}#{stringified_attrs}>#{stringified_body}</#{tag_name}>"
      end
    end

    def render(state)
      stringified_options = options.reduce('') { |acc, (key, val)| acc + " #{key}=\"#{val}\"" }
      stringified_children = state.empty? ? '' : state.map(&method(:render_tag)).join
      "<form#{stringified_options}>#{stringified_children}</form>"
    end
  end
end
