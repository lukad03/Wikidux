class AddCategoryIdToArticleCategories < ActiveRecord::Migration
  def change
    add_column :article_categories, :category_id, :integer
  end
end
