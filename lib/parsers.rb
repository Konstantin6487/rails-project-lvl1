# frozen_string_literal: true

def parse(raw)
  tag_name, attrs, body = raw
  {
    tag_name: tag_name,
    attrs: attrs || {},
    body: body
  }
end
