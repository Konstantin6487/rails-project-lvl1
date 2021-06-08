# frozen_string_literal: true

module HexletCode
  # Tag builder
  class Tag
    def self.build(tag_name, tag_options = {}, &block)
      tag_render = TagRenderer.new
      tag_render.render tag_name, tag_options, &block
    end
  end
end
