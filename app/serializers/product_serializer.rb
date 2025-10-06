class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price

  # (Opsional) Definisikan bahwa produk milik seorang user
  # Ini berguna jika Anda ingin menampilkan user saat mengakses endpoint produk
  belongs_to :user
end