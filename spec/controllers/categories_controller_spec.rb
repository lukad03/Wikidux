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
        create_category
        get :show, {id: create_category.id, name: create_category.name}
        response.should be_success
      end
    end
  end

  describe 'POST #create' do

    context "when a user is logged in" do

      before(:all) do
        create_logged_in_user
      end

      it "creates the category" do
        post_category
        expect(response).to be_success
      end

      it "redirects to categories index" do
        post_category
        expect(response).to redirect_to(categories_path)
      end

      pending "creates a flash notice" do
        expect( post_category.request.flash[:notice] ).to_not be_nil
      end
    end

    context "when a user is not logged in" do

      it "returns an error" do
        post_category
        response.should_not be_success
      end

      it "redirects to categories index" do
        post_category
        expect(response).to redirect_to(categories_path)
      end

      it "creates a flash error" do
        expect( post_category.request.flash[:error] ).to_not be_nil
      end
    end
  end

  describe 'PUT #edit' do
    context "when a user is not logged in" do

      it "returns an error" do
        create_category
        edit_category
        response.should_not be_success
      end

      it "redirects to edit path" do
        create_category
        edit_category
        response.should redirect_to(categories_path)
      end

      it "creates a flash error" do
        create_category
        edit_category
        expect( edit_category.request.flash[:error] ).to_not be_nil
      end
    end
  end

  def create_category
    create(:category)
  end

  def post_category
    post :new, category: create(:category)
  end

  def edit_category
    post :edit, { id: create_category.id, name: "Deli Meats"}
  end

end
