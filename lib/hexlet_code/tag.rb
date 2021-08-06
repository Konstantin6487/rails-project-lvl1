# frozen_string_literal: true

module HexletCode
  # Tag render
  class Tag
    SINGLE_TAGS_LIST = %w[area base br col embed hr img input link meta param source track wbr].freeze

    def build_attrs(attrs_data)
      return '' if attrs_data.empty?

      attrs_data.map { |key, value| " #{key}=\"#{value}\"" }.join
    end

    def render_single_tag(tag_data)
      tag_name = tag_data[:tag_name]
      stringified_attrs = build_attrs(tag_data[:tag_options] || {})
      "<#{tag_name}#{stringified_attrs}>"
    end

    def render_paired_tag(tag_data)
      tag_name = tag_data[:tag_name]
      tag_body = tag_data[:tag_body] || ''
      stringified_attrs = build_attrs(tag_data[:tag_options] || {})
      stringified_body = tag_name.eql?('label') ? tag_body.capitalize : tag_body
      "<#{tag_name}#{stringified_attrs}>#{stringified_body}</#{tag_name}>"
    end

    def render(tag_data)
      return '' if tag_data.empty?

      tag_name = tag_data[:tag_name]
      if SINGLE_TAGS_LIST.include? tag_name
        render_single_tag tag_data
      else
        render_paired_tag tag_data
      end
    end

    private :build_attrs, :render_single_tag, :render_paired_tag
  end
end
