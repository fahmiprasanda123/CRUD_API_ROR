# app/controllers/api/v1/products_controller.rb

module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: [:show, :update, :destroy]

      # GET /api/v1/products (READ - Index)
      def index
        @products = Product.all
        render json: @products, status: :ok
      end

      # GET /api/v1/products/:id (READ - Show)
      def show
        render json: @product, status: :ok
      end

      # POST /api/v1/products (CREATE)
      def create
        @product = Product.new(product_params)
        if @product.save
          render json: @product, status: :created
        else
          render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
        end
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
      
      def product_params
        params.require(:product).permit(:name, :description, :price)
      end
    end
  end
end