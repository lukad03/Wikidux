require 'spec_helper'
include RequestHelpers

describe CategoriesController do

  describe 'GET #show' do
    context "when a category does not exist" do
      it "returns a 404 error" do
        assert_raises(ActiveRecord::RecordNotFound) do
          get :show, :id => 3005
        end
      end
    end

    context 'when a category does exist' do
      it "returns the category" do
          category = create(:category)

          get :show, {id: category.id, name: category.name}
          response.should be_success
      end
    end
  end

  describe 'POST #create' do
    context "when a user is not logged in" do

      it "returns an error" do
        post_category
        response.should_not be_success
      end

      it "redirects to categories index" do
        post_category
        response.should redirect_to(categories_path)
      end

      it "creates a flash error" do
        expect( post_category.request.flash[:error] ).to_not be_nil
      end
    end
  end

  def post_category
    post :new, category: create(:category)
  end
end
