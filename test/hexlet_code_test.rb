# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_empty_tags
    user = Struct.new(:name, :job, keyword_init: true)
    init_user = user.new name: 'rob', job: 'hexlet'
    actual = HexletCode.form_for init_user
    expected = '<form action="#" method="post"></form>'
    assert_equal(expected, actual)
  end

  def test_tags
    user = Struct.new(:name, :job, keyword_init: true)
    init_user = user.new name: 'rob', job: 'hexlet'
    actual = HexletCode.form_for init_user, url: '/me' do |f|
      f.input :name
      f.input :job, as: :text
    end
    expected = '<form action="/me" method="post">'\
    '<label for="name">Name</label>'\
    '<input type="text" name="name" value="rob">'\
    '<label for="job">Job</label>'\
    '<textarea name="job" value="hexlet"></textarea>'\
    '</form>'
    assert_equal(expected, actual)
  end

  def test_tags_with_submit
    user = Struct.new(:name, :job, keyword_init: true)
    init_user = user.new name: 'rob', job: 'hexlet'
    actual = HexletCode.form_for init_user do |f|
      f.input :name
      f.input :job
      f.submit
    end
    expected = '<form action="#" method="post">'\
    '<label for="name">Name</label>'\
    '<input type="text" name="name" value="rob">'\
    '<label for="job">Job</label>'\
    '<input type="text" name="job" value="hexlet">'\
    '<input type="submit" value="Save">'\
    '</form>'
    assert_equal(expected, actual)
  end

  def test_tags_with_submit_label
    user = Struct.new(:name, :job, keyword_init: true)
    init_user = user.new name: 'rob', job: 'hexlet'
    actual = HexletCode.form_for init_user do |f|
      f.input :name
      f.input :job
      f.submit 'Add'
    end
    expected = '<form action="#" method="post">'\
    '<label for="name">Name</label>'\
    '<input type="text" name="name" value="rob">'\
    '<label for="job">Job</label>'\
    '<input type="text" name="job" value="hexlet">'\
    '<input type="submit" value="Add">'\
    '</form>'
    assert_equal(expected, actual)
  end
end
