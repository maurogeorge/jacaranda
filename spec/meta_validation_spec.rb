require "spec_helper"

describe MetaValidation do

  describe "with meta_validation" do

    describe "respond to created methods" do 
      
      it "with model with single validation" do
        post = PostWithMetaValidation.create(status: "published")
        post.respond_to?(:published?).should be_true
      end

      it "with model with multiple validations" do
        post = PostWithMetaValidationAndTitleValidation.create(title: "Title", status: "published")
        post.respond_to?(:draft?).should be_true
      end
    end

    describe "return correct values" do

      let(:post) do
        PostWithMetaValidation.create(status: "published")
      end

      it "when is true" do
        post.should be_published
      end

      it "when is false" do
        post.should_not be_draft
      end
    end

    describe "errors" do
      
      it "when included before the validations definitions" do
        expect do
          class PostWithMetaValidationBeforeValidation < Post 
            acts_as_meta_validation 
            validates :status, inclusion: { in: %w{published unpublished draft} }
          end
        end.to raise_error(MetaValidation::MetaValidationError, "Model PostWithMetaValidationBeforeValidation has no validation of inclusion")
      end
 
      it "raise error when has 2 inclusion with same name" do
        expect do
          class PostWithMetaValidationDuplicateInclusionValue < Post 
            validates :status, inclusion: { in: %w{published unpublished draft} }
            validates :kind, inclusion: { in: %w{report unpublished draft} }
            acts_as_meta_validation 
          end
        end.to raise_error(MetaValidation::MetaValidationError, "The following validators are in more than one field: unpublished and draft")
      end

      it "raise a MetaValidation::MetaValidationError when has a unknown error" do
        Post.stub(:create_predicate_methods).and_raise(StandardError)
        expect do
          class PostWithUnknownError < Post
            validates :status, inclusion: { in: %w{published unplubished draft} }
            acts_as_meta_validation 
          end
        end.to raise_error(MetaValidation::MetaValidationError, "Maybe you found a bug, you got a not expected exception. Report this on https://github.com/maurogeorge/meta_validation/issues")
      end
    end
  end 

  xit "should be possible create role_admin? methods like" do
    class PostWithMetaValidationScoped < Post 
      validates :status, inclusion: { in: %w{published unpublished draft} }
      acts_as_meta_validation :scoped
    end

  end
 
end

