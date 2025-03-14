class Product < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :stock
    validates :image
  end
  # 画像データとproductテーブルの紐付け
  has_one_attached :image

  scope :price_high_to_low, -> { order(price: :desc) }
  scope :price_low_to_high, -> { order(price: :asc) }

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  # Ransackの検索可能なカラムを指定
  def self.ransackable_attributes(auth_object = nil)
    [ "name", "description", "price", "stock", "created_at", "updated_at" ]
  end
end
