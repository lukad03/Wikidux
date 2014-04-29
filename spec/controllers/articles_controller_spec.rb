require 'spec_helper'

describe ArticlesController do

  describe 'GET #show' do
    context "when an article does not exist" do
      it "returns a 404 error" do
        assert_raises(ActiveRecord::RecordNotFound) do
          get :show, :id => 3005
        end
      end
    end
  end

  describe 'POST #create' do
    context "when a user is not logged in" do
      it "redirects to index and returns an error" do
        post :new, article: create(:article)

        response.should_not be_success
        expect redirect_to(articles_path)
        expect(flash[:error])
      end
    end

    pending "when a user is logged in" do
      it "creates the article" do
        user = create(:user)
        login_as(user, :scope => :user)

        expect{
          post :new, article: create(:article)
        }.to change(Article,:count).by(1)

        expect redirect_to(articles_path)
        expect(flash[:notice])
      end
    end
  end

  pending 'PUT #edit' do
    context "when a user is not logged in" do
      it "redirects to index and returns an error" do
        article = create(:article)

        put :edit, { id: article.id, title: "Smoked Sausage", content: article.content}

        response.should_not be_success
        expect redirect_to(articles_path)
        expect(flash[:error])
      end
    end
  end
end
