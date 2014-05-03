require 'spec_helper'
include RequestHelpers

describe ArticlesController do

  describe 'GET #show' do
    context "when an article does not exist" do
      it "returns a 404 error" do
        assert_raises(ActiveRecord::RecordNotFound) do
          get :show, :id => 3005
        end
      end
    end

    context "when an article does exist" do
      it "returns the article" do
        create_article
        get :show, {id: create_article.id, title: create_article.title, content: create_article.content}
        expect(response).to be_success
      end
    end
  end

  describe 'POST #create' do

    context "when a user is not logged in" do

      it "returns an error" do
        post_article
        response.should_not be_success
      end

      it "redirects to articles index" do
        post_article
        response.should redirect_to(articles_path)
      end

      pending "creates a flash error" do
        expect( post_article.request.flash[:error] ).to_not be_nil
      end
    end

    context "when a user is logged in" do

      it "creates an article" do
        create_logged_in_user
        expect{ post_article }.to change( Article, :count ).by(1)
      end

      it "redirects to article" do
        create_logged_in_user
        post_article

        response.should redirect_to(articles_path)
      end

      pending "creates a flash notice" do
        expect( post_article.request.flash[:notice] ).to_not be_nil
      end
    end
  end

  describe 'PUT #edit' do
    context "when a user is not logged in" do

      it "returns an error" do
        create_article
        edit_article
        response.should_not be_success
      end

      it "redirects to edit path" do
        create_article
        edit_article
        response.should redirect_to(articles_path)
      end

      it "creates a flash error" do
        create_article
        edit_article
        expect( edit_article.request.flash[:error] ).to_not be_nil
      end
    end
  end

  def create_article
    create(:article)
  end

  def post_article
    post :new, article: create_article
  end

  def edit_article
    put :edit, { id: create_article.id, title: "Smoked Sausage", content: create_article.content}
  end
end
