# frozen_string_literal: true

def render(parsed)
  single_tags_list = %w[area base br col embed hr img input link meta param source track wbr]
  tag_name, attrs, body = parsed.values_at(:tag_name, :attrs, :body)
  build_attrs = lambda { |attrs_hash|
    attrs_hash.keys.map { |attr| " #{attr}=\"#{attrs_hash[attr]}\"" }.join
  }
  built_attrs = build_attrs.call(attrs)
  built_body = body&.capitalize
  if single_tags_list.include?(tag_name)
    "<#{tag_name}#{built_attrs}>"
  else
    "<#{tag_name}#{built_attrs}>#{built_body}</#{tag_name}>"
  end
end
