# frozen_string_literal: true

require 'test_helper'
require 'rails/dom/testing/assertions/dom_assertions'

class HexletCodeTest < Minitest::Test
  include Rails::Dom::Testing::Assertions::DomAssertions

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_empty_tags
    user = Struct.new(:name, :job, keyword_init: true)
    init_user = user.new name: 'rob', job: 'hexlet'
    actual = HexletCode.form_for init_user
    expected = '<form action="#" method="post"></form>'
    assert_dom_equal expected, actual
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
    assert_dom_equal expected, actual
  end

  def test_tags_with_email
    user = Struct.new(:name, :job, :email, keyword_init: true)
    init_user = user.new name: 'rob', job: 'hexlet', email: 'ya@ya.ru'
    actual = HexletCode.form_for init_user, url: '/me' do |f|
      f.input :email, as: :email
      f.input :job, as: :text
    end
    expected = '<form action="/me" method="post">'\
    '<label for="email">Email</label>'\
    '<input type="email" name="email" value="ya@ya.ru">'\
    '<label for="job">Job</label>'\
    '<textarea name="job" value="hexlet"></textarea>'\
    '</form>'
    assert_dom_equal expected, actual
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
    assert_dom_equal expected, actual
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
    assert_dom_equal expected, actual
  end
end
