# frozen_string_literal: true

module HexletCode
  # Form data parsers
  class Parsers
    def parse(tag_name, attrs)
      {
        tag_name: tag_name,
        attrs: attrs,
        body: block_given? ? yield : ''
      }
    end
  end
end
