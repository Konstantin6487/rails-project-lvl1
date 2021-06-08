# frozen_string_literal: true

module HexletCode
  # Form data parsers
  class TagRenderer
    def render(tag_name, tag_options)
      single_tags_list = %w[area base br col embed hr img input link meta param source track wbr]
      build_attrs = lambda { |attrs_hash|
        attrs_hash.keys.map { |attr| " #{attr}=\"#{attrs_hash[attr]}\"" }.join
      }
      stringified_attrs = tag_options.empty? ? '' : build_attrs.call(tag_options)
      body = block_given? ? yield : ''
      stringified_body = tag_name == 'label' ? body.capitalize : body
      if single_tags_list.include? tag_name
        "<#{tag_name}#{stringified_attrs}>"
      else
        "<#{tag_name}#{stringified_attrs}>#{stringified_body}</#{tag_name}>"
      end
    end
  end
end
