# frozen_string_literal: true

def parse(tag_name, attrs)
  {
    tag_name: tag_name,
    attrs: attrs,
    body: block_given? ? yield : ''
  }
end
