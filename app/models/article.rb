class Article < ActiveRecord::Base
    belongs_to :user
    has_many :article_categories
    has_many :categories, through: :article_categories
    validates :title, presence: true
    validates :content, presence: true

    accepts_nested_attributes_for :article_categories, :allow_destroy => true
end
