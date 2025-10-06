class User < ApplicationRecord
  has_many :products
end
gem 'active_model_serializers', '~> 0.10.0'