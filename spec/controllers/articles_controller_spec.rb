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

    context "when a user is logged in" do

      before(:each) do
        create_logged_in_user
      end

      it "creates an article" do
        expect{ post_article }.to change( Article, :count ).by(1)
      end

      pending "redirects to article" do
        post_article
        response.should redirect_to(articles_path)
      end

      it "shows a flash success" do
        expect{ post_article.request.flash[:success] }.to_not be_nil
      end
    end

    context "when a user is not logged in" do

      it "returns an error" do
        post_article
        response.should_not be_success
      end

      it "redirects to articles index" do
        expect(post_article).to redirect_to(articles_path)
      end

      it "creates a flash error" do
        expect{ post_article.request.flash[:error] }.to_not be_nil
      end
    end
  end

  describe 'PATCH #update' do
    context "when a user is not logged in" do

      before(:each) do
        create_article
        edit_article
      end

      it "returns an error" do
        response.should_not be_success
      end

      it "redirects to articles path" do
        response.should redirect_to(articles_path)
      end

      it "creates a flash error" do
        expect( edit_article.request.flash[:error] ).to_not be_nil
      end
    end
  end

  describe 'POST #destroy' do
    context "when a user is not logged in" do

      before(:each) do
        destroy_article
      end

      it "returns an error" do
        response.should_not be_success
      end

      it "redirects to article" do
        response.should redirect_to(articles_path)
      end

      it "creates a flash error" do
        expect{ destroy_article.request.flash[:error] }.to_not be_nil
      end
    end

    context "when a user is logged in" do

      before(:each) do
        create_logged_in_user
        create_article
      end

      it "deletes the article" do
        article = create(:article)
        expect{ delete :destroy, { id: article } }.to change(Article, :count).by(-1)
      end

      it "redirects to article" do
        destroy_article
        response.should redirect_to(articles_path)
      end

      it "creates a flash error" do
        expect{ destroy_article.request.flash[:success] }.to_not be_nil
      end
    end
  end

  def create_article
    create(:article)
  end

  def post_article
    post :new, article: { id: create_article.id }
  end

  def edit_article
    patch :update, { id: create_article.id, article: { title: "Smoked Sausage", content: create_article.content } }
  end

  def destroy_article
    delete :destroy, { id: create_article }
  end
end
