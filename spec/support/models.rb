class Post < ActiveRecord::Base
end

class PostWithJacaranda < Post 
  validates :status, inclusion: { in: %w{published unplubished draft} }
  acts_as_jacaranda 
end

class PostWithJacarandaAndTitleValidation < Post
  validates :title, presence: true
  validates :status, inclusion: { in: %w{published unplubished draft} }
  acts_as_jacaranda 
end

class PostWithJacarandaScoped < Post 
  validates :status, inclusion: { in: %w{published unpublished draft} }
  acts_as_jacaranda scoped: true
end

