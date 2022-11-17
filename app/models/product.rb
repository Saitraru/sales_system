class Product < ApplicationRecord
    include PgSearch::Model
    pg_search_scope :search_full_text, against: {
        title: 'A',
        description: 'B',
       
    }

    ORDER_BY = {
      newest: "created_at DESC",
      expensive: "price DESC",
      cheapest: "price ASC"
    }
    
    belongs_to :category
    has_one_attached :photo

    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true
end
