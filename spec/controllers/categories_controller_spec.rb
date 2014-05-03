require 'spec_helper'

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
      it "returns the categor" do
          category = create(:category)

          get :show, {id: category.id, name: category.name}
          expect(response).to be_success
      end
    end
  end
end
