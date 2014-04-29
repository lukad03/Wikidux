class AddArticleCategoriesToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :article_categories, :integer
  end
end
