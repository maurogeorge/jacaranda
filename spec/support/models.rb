class Post < ActiveRecord::Base
end

class PostWithMetaValidation < Post 
  validates :status, inclusion: { in: %w{published unplubished draft} }
  acts_as_meta_validation 
end

class PostWithMetaValidationAndTitleValidation < Post
  validates :title, presence: true
  validates :status, inclusion: { in: %w{published unplubished draft} }
  acts_as_meta_validation 
end

class PostWithMetaValidationScoped < Post 
  validates :status, inclusion: { in: %w{published unpublished draft} }
  acts_as_meta_validation scoped: true
end

