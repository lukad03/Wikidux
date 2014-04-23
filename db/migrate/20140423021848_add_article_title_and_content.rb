class AddArticleTitleAndContent < ActiveRecord::Migration
  def change
      add_column :articles, :title, :string
      add_column :articles, :content, :string
  end
end
