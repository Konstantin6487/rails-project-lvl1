# frozen_string_literal: true

require_relative 'hexlet_code/version'

def parse(raw)
  tag_name, attrs = raw
  {
    tag_name: tag_name,
    attrs: attrs || {},
    body: block_given? ? yield : ''
  }
end

def render(parsed)
  single_tags_list = %w[area base br col embed hr img input link meta param source track wbr]
  tag_name, attrs, body = parsed.values_at(:tag_name, :attrs, :body)
  build_attrs = lambda { |attrs_hash|
    attrs_hash.keys.map { |attr| " #{attr}=\"#{attrs_hash[attr]}\"" }.join
  }
  if single_tags_list.include?(tag_name)
    "<#{tag_name}#{build_attrs.call(attrs)}>"
  else
    "<#{tag_name}#{build_attrs.call(attrs)}>#{body}</#{tag_name}>"
  end
end

module HexletCode
  class Error < StandardError; end

  # Tag builder
  class Tag
    def self.build(*tag, &block)
      parsed = parse(tag, &block)
      render parsed
    end
  end
end
