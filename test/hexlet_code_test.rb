# frozen_string_literal: true

require 'test_helper'
require 'rails/dom/testing/assertions/selector_assertions'

class HexletCodeTest < Minitest::Test
  include Rails::Dom::Testing::Assertions::SelectorAssertions

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_empty_tags
    user = Struct.new(:name, :job, keyword_init: true)
    init_user = user.new name: 'rob', job: 'hexlet'
    content = HexletCode.form_for init_user
    html = Nokogiri::HTML::Document.parse(content)
    assert_select html, 'form'
  end

  def test_tags
    user = Struct.new(:name, :job, keyword_init: true)
    init_user = user.new name: 'rob', job: 'hexlet'
    content = HexletCode.form_for init_user, url: '/me' do |f|
      f.input :name
      f.input :job, as: :text
    end
    html = Nokogiri::HTML::Document.parse(content)
    assert_select html, 'form' do
      assert_select 'form[action="/me"][method="post"]'
      assert_select 'label[for="name"]', 'Name'
      assert_select 'input[type="text"][name="name"][value="rob"]'
      assert_select 'label[for="job"]', 'Job'
      assert_select 'textarea[name="job"][value="hexlet"]'
    end
  end

  def test_tags_with_email
    user = Struct.new(:name, :job, :email, keyword_init: true)
    init_user = user.new name: 'rob', job: 'hexlet', email: 'ya@ya.ru'
    content = HexletCode.form_for init_user, url: '/me' do |f|
      f.input :email, as: :email
      f.input :job, as: :text
    end
    html = Nokogiri::HTML::Document.parse(content)
    assert_select html, 'form' do
      assert_select 'form[action="/me"][method="post"]'
      assert_select 'label[for="email"]', 'Email'
      assert_select 'input[type="email"][name="email"][value="ya@ya.ru"]'
      assert_select 'label[for="job"]', 'Job'
      assert_select 'textarea[name="job"][value="hexlet"]'
    end
  end

  def test_tags_with_textarea_attrs
    user = Struct.new(:name, :job, :email, keyword_init: true)
    init_user = user.new name: 'rob', job: 'hexlet', email: 'ya@ya.ru'
    content = HexletCode.form_for init_user, url: '/me' do |f|
      f.input :email, as: :email
      f.input :job, as: :text, rows: 50, cols: 50
    end
    html = Nokogiri::HTML::Document.parse(content)
    assert_select html, 'form' do
      assert_select 'form[action="/me"][method="post"]'
      assert_select 'label[for="email"]', 'Email'
      assert_select 'input[type="email"][name="email"][value="ya@ya.ru"]'
      assert_select 'label[for="job"]', 'Job'
      assert_select 'textarea[name="job"][value="hexlet"][rows="50"][cols="50"]'
    end
  end

  def test_tags_with_submit
    user = Struct.new(:name, :job, keyword_init: true)
    init_user = user.new name: 'rob', job: 'hexlet'
    content = HexletCode.form_for init_user do |f|
      f.input :name
      f.input :job
      f.submit
    end
    html = Nokogiri::HTML::Document.parse(content)
    assert_select html, 'form' do
      assert_select 'form[action="#"][method="post"]'
      assert_select 'label[for="name"]', 'Name'
      assert_select 'input[type="text"][name="name"][value="rob"]'
      assert_select 'label[for="job"]', 'Job'
      assert_select 'input[type="text"][name="job"][value="hexlet"]'
      assert_select 'input[type="submit"][value="Save"]'
    end
  end

  def test_tags_with_submit_label
    user = Struct.new(:name, :job, keyword_init: true)
    init_user = user.new name: 'rob', job: 'hexlet'
    content = HexletCode.form_for init_user do |f|
      f.input :name
      f.input :job
      f.submit 'Add'
    end
    html = Nokogiri::HTML::Document.parse(content)
    assert_select html, 'form' do
      assert_select 'form[action="#"][method="post"]'
      assert_select 'label[for="name"]', 'Name'
      assert_select 'input[type="text"][name="name"][value="rob"]'
      assert_select 'label[for="job"]', 'Job'
      assert_select 'input[type="text"][name="job"][value="hexlet"]'
      assert_select 'input[type="submit"][value="Add"]'
    end
  end
end
