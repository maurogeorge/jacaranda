# Jacaranda

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

Simplesmente adicione a seguinte linha **após as suas validações**:

    acts_as_jacaranda

Ficando assim

    class Post < ActiveRecord::Base
      validates :status, inclusion: { in: %w{published unpublished draft} }
      acts_as_jacaranda
    end

Agora seu model post recebeu alguns poderes, veremos eles.

#### Métodos predicados

Pergunte a seu `@post` se ele foi published com `@post.published?` ou se é um draft com `@post.draft?`.

#### Scopes

Encontre os posts baseado no status com utilizando os scopes criados como `Post.published` e `Post.draft`.

### Scoped

Pode ser que o seu model possua 2 validações de inclusão que possuam os valores válidos repetidos

    class Post < ActiveRecord::Base
      validates :status, inclusion: { in: %w{published unpublished draft} }
      validates :kind, inclusion: { in: %w{report unpublished draft} }
      acts_as_jacaranda
    end

Neste caso utilizamos o Jacaranda com o paramêtro `scoped`:

    acts_as_jacaranda scoped: true

Que gerará os métodos baseado na coluna como `#unpublished_status?` e `#unpublished_kind?`.

## Versioning

Jacaranda utiliza o [Semantic Versioning](http://semver.org/).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request