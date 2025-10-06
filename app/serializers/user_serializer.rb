class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  # Definisikan bahwa user punya banyak produk
  has_many :products
end