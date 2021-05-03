require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should be able to create a product' do
      @category = Category.new(name: "Test Cat")
      @category.save!
      @product = Product.new(name: "Product", price: "1000", quantity: "2", category: @category)
      @product.save!
      expect(@product.id).to be_present
    end

    it 'should return an error for name validation' do
      @category = Category.new(name: "Test Cat")
      @category.save!
      @product = Product.new(price: "1000", quantity: "2", category: @category)
      @product.save
      expect(@product.errors.full_messages).not_to be_empty
    end

    it 'should return an error for price validation' do
      @category = Category.new(name: "Test Cat")
      @category.save!
      @product = Product.new(name: "Product", quantity: "2", category: @category)
      @product.save
      expect(@product.errors.full_messages).not_to be_empty
    end

    it 'should return an error for quantity validation' do
      @category = Category.new(name: "Test Cat")
      @category.save!
      @product = Product.new(name: "Product", price: "1000", category: @category)
      @product.save
      expect(@product.errors.full_messages).not_to be_empty
    end

    it 'should return an error for category validation' do
      @category = Category.new(name: "Test Cat")
      @category.save!
      @product = Product.new(name: "Product", price: "1000", quantity: "2")
      @product.save
      expect(@product.errors.full_messages).not_to be_empty
    end
  end
end
