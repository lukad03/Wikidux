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

  describe 'GET #new' do
    context "when a user is not logged in" do
      it "redirects to index and returns an error" do
        get 'new'

        response.should_not be_success
        expect redirect_to(articles_path)
        expect(flash[:error])
      end
    end
  end
end
