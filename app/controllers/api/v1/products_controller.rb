module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: [:show, :update, :destroy]

      # GET /api/v1/products
      def index
        @products = Product.all
        render json: @products
      end
      
      # <-- TAMBAHKAN METHOD INI
      # GET /api/v1/users/:user_id/products
      def index_by_user
        @user = User.find(params[:user_id])
        # Render user dan sertakan relasi products-nya
        render json: @user.as_json(include: { products: { except: [:user_id] } }), status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end

      # GET /api/v1/products/:id (READ - Show)
      def show
        render json: @product, status: :ok
      end

      # POST /api/v1/products (CREATE)
#       def create
#         @product = Product.new(product_params)
#         if @product.save
#           render json: @product, status: :created
#         else
#           render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
#         end
#       end

        def create
          # Temukan user berdasarkan user_id yang dikirim
          @user = User.find(product_params[:user_id])

          # Buat produk yang langsung berelasi dengan user tersebut
          @product = @user.products.build(product_params)

          if @product.save
            render json: @product, status: :created
          else
            render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
          end
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'User not found' }, status: :not_found
        end




      # PUT /api/v1/products/:id (UPDATE)
      def update
        if @product.update(product_params)
          render json: @product, status: :ok
        else
          render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/products/:id (DELETE)
      def destroy
        @product.destroy
        head :no_content
      end

      private

      def set_product
        @product = Product.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Product not found' }, status: :not_found
      end
      
#       def product_params
#         params.require(:product).permit(:name, :description, :price)
#       end
        def product_params
          # Tambahkan :user_id ke strong parameters
          params.require(:product).permit(:name, :description, :price, :user_id)
        end

    end
  end
end