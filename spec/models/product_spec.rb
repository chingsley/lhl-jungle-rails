require 'rails_helper'
require 'pp'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @cat = Category.find_or_create_by! name: 'Apparel'
  end

  describe 'Validations' do

    it 'is created successfully with all required fields specified' do
      @product = @cat.products.new({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      })
      @product.save!
      # pp @product
      expect(@product.id).to be_present  
    end

    it 'validates :name, presence: true' do
      @product = @cat.products.new({
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      })
      @product.save
      # pp @product.errors.full_messages
      expect(@product.errors.full_messages[0]).to eq("Name can't be blank")  
    end

    it 'validates :price, presence: true' do
      @product = @cat.products.new({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
      })
      @product.save
      errors = @product.errors.full_messages
      expect(errors).to include("Price cents is not a number")
      expect(errors).to include("Price is not a number")
      expect(errors).to include("Price can't be blank")
    end

    it 'validates :quantity, presence: true' do
      @product = @cat.products.new({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        price: 64.99
      })
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates :category, presence: true' do
      @product = Product.new({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        price: 64.99,
        quantity: 10,
        category_id: nil
      })
      @product.save
      # expect(true).to be true
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
