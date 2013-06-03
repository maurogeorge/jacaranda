# Jacaranda
[![RubyGems][gem_version_badge]][ruby_gems]
[![Travis CI][travis_ci_badge]][travis_ci]
[![Coveralls][coveralls_badge]][coveralls]
[![Code Climate][code_climate_badge]][code_climate]
[![Gemnasium][gemnasium_badge]][gemnasium]


Generates helper methods based on your model validations creating common methods and scopes.

## Installation

Add this line to your application's Gemfile:

    gem 'jacaranda'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jacaranda

## Usage

### Basic

Simply add the following line **after the validations**:

    acts_as_jacaranda

like that

    class Post < ActiveRecord::Base
      validates :status, inclusion: { in: %w{published unpublished draft} }
      acts_as_jacaranda
    end

Now your model Post received some powers, we see them.

#### Predicate methods

Ask `@post` if it was published with `@post.published?` or it is a draft with `@post.draft?`.

#### Scopes

Find the posts based on column `status` using the generated scopes like `Post.published` e `Post.draft`.

### Scoped

Perhaps model has 2 validations of inclusion that have valid values repeated

    class Post < ActiveRecord::Base
      validates :status, inclusion: { in: %w{published unpublished draft} }
      validates :kind, inclusion: { in: %w{report unpublished draft} }
      acts_as_jacaranda
    end

in this case use Jacaranda with the param `scoped`:

    acts_as_jacaranda scoped: true

which will generate methods based on column like `#unpublished_status?` and `#unpublished_kind?`.

## Versioning

Jacaranda follow the [Semantic Versioning](http://semver.org/).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[gem_version_badge]: https://badge.fury.io/rb/jacaranda.png
[ruby_gems]: http://rubygems.org/gems/jacaranda
[code_climate]: https://codeclimate.com/github/maurogeorge/jacaranda
[code_climate_badge]: https://codeclimate.com/github/maurogeorge/jacaranda.png
[travis_ci]: http://travis-ci.org/maurogeorge/jacaranda
[travis_ci_badge]: https://secure.travis-ci.org/maurogeorge/jacaranda.png
[gemnasium]: https://gemnasium.com/maurogeorge/jacaranda
[gemnasium_badge]: https://gemnasium.com/maurogeorge/jacaranda.png
[coveralls]: https://coveralls.io/r/maurogeorge/jacaranda
[coveralls_badge]: https://coveralls.io/repos/maurogeorge/jacaranda/badge.png?branch=master
