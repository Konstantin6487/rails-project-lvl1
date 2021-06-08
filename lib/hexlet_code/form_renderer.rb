# frozen_string_literal: true

module HexletCode
  # Form state render
  class FormRenderer
    attr_reader :options

    def initialize(options)
      default_options = {
        action: options.fetch(:url, '#')
      }
      collected_options = default_options.merge options.except(:url)
      @options = collected_options
    end

    def render(state)
      stringified_options = options.reduce('') { |memo, (key, val)| memo + " #{key}=\"#{val}\"" }
      stringified_inner_tags = state.map do |tag_data|
        Tag.build tag_data[:tag_name], **tag_data[:tag_options], &tag_data[:tag_body]
      end.join
      "<form#{stringified_options} method=\"post\">#{stringified_inner_tags}</form>"
    end
  end
end
