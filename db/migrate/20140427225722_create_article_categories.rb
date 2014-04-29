class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|

      t.timestamps
    end
  end
end
