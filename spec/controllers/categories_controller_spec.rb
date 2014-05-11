require 'spec_helper'
include RequestHelpers

describe CategoriesController do

  describe 'GET #show' do

    context 'when a category does exist' do
      it "returns the category" do
        category
        get :show, {id: category.id, name: category.name}
        response.should be_success
      end
    end

    context "when a category does not exist" do
      it "returns a 404 error" do
        assert_raises(ActiveRecord::RecordNotFound) do
          get :show, :id => 3005
        end
      end
    end
  end

  describe 'POST #create' do

    context "when a user is logged in" do

      before(:each) do
        create_logged_in_user
      end

      it "creates a category" do
        expect{ post_category }.to change( Category, :count ).by(1)
      end

      it "redirects to categories index" do
        cat = create(:category)
        expect{ post :category, { id: cat } }.to redirect_to(categories_path)
      end

      it "creates a flash notice" do
        expect{ post_category.request.flash[:success] }.to_not be_nil
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

  describe 'PATCH #update' do
    context "when a user is not logged in" do

      it "returns an error" do
        edit_category
        response.should_not be_success
      end

      it "redirects to edit path" do
        edit_category
        response.should redirect_to(categories_path)
      end

      it "creates a flash error" do
        edit_category
        expect( edit_category.request.flash[:error] ).to_not be_nil
      end
    end
  end

  describe 'POST #destroy' do
    context "when a user is not logged in" do

      before(:each) do
        destroy_category
      end

      it "returns an error" do
        response.should_not be_success
      end

      it "redirects to category" do
        response.should redirect_to(categories_path)
      end

      it "creates a flash error" do
        expect( destroy_category.request.flash[:error] ).to_not be_nil
      end
    end

    context "when a user is logged in" do

      before(:each) do
        create_logged_in_user
      end

      it "deletes the category" do
        cat = create(:category)
        expect{ delete :destroy, { id: cat } }.to change(Category, :count).by(-1)
      end

      it "redirects to category" do
        destroy_category
        response.should redirect_to(categories_path)
      end

      it "creates a flash error" do
        expect( destroy_category.request.flash[:success] ).to_not be_nil
      end
    end
  end

  def category
    create(:category)
  end

  def build_category
    build(:category)
  end

  def post_category
    post :create, category: {id: category}
  end

  def edit_category
    category
    patch :update, { id: category.id, category: { :name => 'Bollocks' } }
  end

  def destroy_category
    delete :destroy, { id: category }
  end

end
