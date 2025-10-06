# config/routes.rb

Rails.application.routes.draw do
  # Gunakan namespace untuk versioning API (http://.../api/v1/)
  namespace :api do
    namespace :v1 do

      # Rute untuk User
      # Dibatasi hanya untuk action yang sudah kita buat di UsersController
      resources :users, only: [:index, :create, :show] do
        # Rute Nested: Untuk mendapatkan semua produk milik user tertentu.
        # GET /api/v1/users/:user_id/products
        get 'products', to: 'products#index_by_user'
      end

      # Rute untuk Product
      # Menyediakan semua endpoint CRUD standar untuk produk secara umum.
      resources :products, only: [:index, :show, :create, :update, :destroy]

    end
  end
end