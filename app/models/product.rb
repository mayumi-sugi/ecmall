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

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  # Ransackの検索可能なカラムを指定
  def self.ransackable_attributes(auth_object = nil)
    [ "name", "price", "created_at" ]
  end
  #
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
