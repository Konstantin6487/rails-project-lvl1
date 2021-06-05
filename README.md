# HexletCode

![lint](https://github.com/Konstantin6487/rails-project-lvl1/actions/workflows/linter-check.yml/badge.svg) ![test](https://github.com/Konstantin6487/rails-project-lvl1/actions/workflows/testing-check.yml/badge.svg)


Simple form generator

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hexlet_code'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hexlet_code

## Usage

```
User = Struct.new(:name, :job, keyword_init: true)
user = User.new job: 'hexlet'

HexletCode.form_for user do |f|
  f.input :name
  f.input :job
  f.submit
end

# <form action="#" method="post">
#   <label for="name">Name</label>
#   <input type="text" name="name">
#   <label for="job">Job</label>
#   <input type="text" name="job" value="hexlet">
#   <input type="submit" value="Save" name="commit">
# </form>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Konstantin6487/rails-project-lvl1. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Konstantin6487/rails-project-lvl1/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
