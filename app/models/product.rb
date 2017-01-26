class Product < ActiveRecord::Base
  validates :sku, uniqueness: true
  validates :price, :title, :sku, presence: true
  validates :price, format: { with: /\A\d{1,6}(\.\d{0,2})?\z/ }, numericality: { greater_than: 0 }
end