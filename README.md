# MetaValidation

Utilize os meta-dados de suas validações do [Active Record](https://github.com/rails/rails/tree/master/activerecord) para criar métodos útilitários.

Normalmente quando temos validações de inclusão acabamos fazendo algo assim:

    class Post < ActiveRecord::Base
      validates :status, inclusion: { in: %w{published unpublished draft} }

      def published?
        status == "published"
      end

      def unpublished?
        status == "unpublished"
      end
    end

Afinal, você não expõe sua interface fazendo algo assim né:

    if @post.status == "published"

quando pode fazer:

    if @post.published?

é aí que o MetaValidation entra, gerando estes métodos para você.

## Installation

Add this line to your application's Gemfile:

    gem 'meta_validation'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install meta_validation

## Usage

### Basic

Simplesmente adicione a seguinte linha **após as suas validações**:

    acts_as_meta_validation

Ficando assim

    class Post < ActiveRecord::Base
      validates :status, inclusion: { in: %w{published unpublished draft} }
      acts_as_meta_validation
    end

### Scoped

Pode ser que o seu model possua 2 validações de inclusão que possuam os valores válidos repetidos

    class Post < ActiveRecord::Base
      validates :status, inclusion: { in: %w{published unpublished draft} }
      validates :kind, inclusion: { in: %w{report unpublished draft} }
      acts_as_meta_validation
    end

Neste caso utilizamos o MetaValidation com o paramêtro `scoped`:

    acts_as_meta_validation scoped: true

Que gerará os métodos baseado na coluna como `status_unpublished?` e `kind_unpublished?`.

## Versioning

MetaValidation utiliza o [Semantic Versioning](http://semver.org/).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
