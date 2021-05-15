# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def setup
    @builder = HexletCode::Tag
  end

  def test_single_tag_build
    assert_equal('<br>', @builder.build('br'))
    assert_equal('<input type="submit" value="Save">', @builder.build('input', type: 'submit', value: 'Save'))
  end

  def test_paired_tag_build
    assert_equal('<label>Email</label>', @builder.build('label') { 'Email' })
    assert_equal('<label for="email">Email</label>', @builder.build('label', for: 'email') { 'Email' })
  end
end
