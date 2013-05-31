require "spec_helper"

describe Jacaranda do

  describe "predicate methods" do

    describe "respond to created methods" do

      it "with model with single validation" do
        post = PostWithJacaranda.create(status: "published")
        expect(post.respond_to?(:published?)).to be_true
      end

      it "with model with multiple validations" do
        post = PostWithJacarandaAndTitleValidation.create(title: "Title", status: "published")
        expect(post.respond_to?(:draft?)).to be_true
      end

      it "with param scoped" do
        post = PostWithJacarandaScoped.create(status: "published")
        expect(post.respond_to?(:status_published?)).to be_true
      end
    end

    describe "return correct values" do

      let(:post) do
        PostWithJacaranda.create(status: "published")
      end

      it "when is true" do
        expect(post).to be_published
      end

      it "when is false" do
        expect(post).to_not be_draft
      end
    end
  end

  describe "scopes" do

    it "have the scopes" do
      expect(PostWithJacaranda.respond_to?(:published)).to be_true
    end

    it "create scoped scopes" do
      expect(PostWithJacarandaScoped.respond_to?(:published_status)).to be_true
    end

    it "is a relation" do
      expect(PostWithJacaranda.published).to be_kind_of(ActiveRecord::Relation)
    end

    describe "returned values" do

      let!(:post_published) do
        PostWithJacaranda.create(status: "published")
      end

      let!(:post_not_published) do
        PostWithJacaranda.create(status: "draft")
      end

      it "return correct values" do
        expect(PostWithJacaranda.published).to include(post_published)
      end

      it "not return incorrect values" do
        expect(PostWithJacaranda.published).to_not include(post_not_published)
      end
    end
  end

  describe "errors" do

    it "when included before the validations definitions" do
      expect do
        class PostWithJacarandaBeforeValidation < Post
          acts_as_jacaranda
          validates :status, inclusion: { in: %w{published unpublished draft} }
        end
      end.to raise_error(Jacaranda::JacarandaError, /Model PostWithJacarandaBeforeValidation has no validation of inclusion/)
    end

    it "raise error when has 2 inclusion with same name" do
      expect do
        class PostWithJacarandaDuplicateInclusionValue < Post
          validates :status, inclusion: { in: %w{published unpublished draft} }
          validates :kind, inclusion: { in: %w{report unpublished draft} }
          acts_as_jacaranda
        end
      end.to raise_error(Jacaranda::JacarandaError, /The following validators are in more than one field: unpublished and draft/)
    end

    it "raise a Jacaranda::JacarandaError when has a unknown error" do
      Post.stub(:create_predicate_methods).and_raise(StandardError)
      expect do
        class PostWithUnknownError < Post
          validates :status, inclusion: { in: %w{published unplubished draft} }
          acts_as_jacaranda
        end
      end.to raise_error(Jacaranda::JacarandaError, "Maybe you found a bug, you got a not expected exception. Report this on https://github.com/maurogeorge/jacaranda/issues")
    end
  end
end

