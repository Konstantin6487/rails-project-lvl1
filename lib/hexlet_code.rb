# frozen_string_literal: true

require_relative 'hexlet_code/version'

# main Module
module HexletCode
  autoload :Parsers, 'hexlet_code/parsers'
  autoload :Render, 'hexlet_code/render'
  autoload :Tag, 'hexlet_code/tag'
  autoload :Form, 'hexlet_code/form'

  def self.fold_form(inner, url)
    "<form action=\"#{url}\" method=\"post\">#{inner}</form>"
  end

  def self.form_for(form_data, url: '#')
    tags = Form.new(form_data)
    block_given? && yield(tags)
    fold_form(tags, url)
  end

  private_class_method :fold_form
end
