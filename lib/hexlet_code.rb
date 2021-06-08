# frozen_string_literal: true

require_relative 'hexlet_code/version'

# main Module
module HexletCode
  autoload :TagRenderer, 'hexlet_code/tag_renderer'
  autoload :FormRenderer, 'hexlet_code/form_renderer'
  autoload :Tag, 'hexlet_code/tag'
  autoload :Form, 'hexlet_code/form'

  class Error < StandardError; end

  def self.form_for(form_data, **options)
    form_container = Form.new form_data
    block_given? && (yield form_container)

    state = form_container.state
    tags_render = FormRenderer.new options
    tags_render.render state
  end
end
