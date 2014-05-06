class ArticleCategory < ActiveRecord::Base
  belongs_to :category, inverse_of: :article_categories
  belongs_to :article, inverse_of: :article_categories
end
