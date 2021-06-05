# frozen_string_literal: true

module HexletCode
  # Tag builder
  class Tag
    def self.build(tag_name, tag_options = {}, &block)
      parser = Parsers.new
      tag_render = Render.new

      parsed = parser.parse(tag_name, tag_options, &block)
      tag_render.render(parsed)
    end
  end
end
