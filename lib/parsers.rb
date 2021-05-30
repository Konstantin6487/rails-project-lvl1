# frozen_string_literal: true

def parse(raw)
  tag_name, attrs = raw
  {
    tag_name: tag_name,
    attrs: attrs || {},
    body: block_given? ? yield : ''
  }
end
