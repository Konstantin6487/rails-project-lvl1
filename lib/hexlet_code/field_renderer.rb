# frozen_string_literal: true

module HexletCode
  # Field render
  class FieldRenderer
    SINGLE_TAGS_LIST = %w[area base br col embed hr img input link meta param source track wbr].freeze

    def build_attrs(attrs_data)
      return '' if attrs_data.empty?

      attrs_data.keys.map { |attr| " #{attr}=\"#{attrs_data[attr]}\"" }.join
    end

    def render_tag_base(tag_data)
      tag_name = tag_data[:tag_name]
      stringified_attrs = build_attrs(tag_data[:tag_options] || {})
      stringified_label = render(tag_data[:tag_label] || {})
      "#{stringified_label}<#{tag_name}#{stringified_attrs}>"
    end

    def render_single_tag(tag_data)
      render_tag_base tag_data
    end

    def render_paired_tag(tag_data)
      tag_name = tag_data[:tag_name]
      tag_body = tag_data[:tag_body] || ''
      stringified_body = tag_name.eql?('label') ? tag_body.capitalize : tag_body
      "#{render_tag_base tag_data}#{stringified_body}</#{tag_name}>"
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
  end
end
