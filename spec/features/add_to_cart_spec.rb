require 'rails_helper'

RSpec.feature "Visitor can add products to cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    # 2.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    # end
  end

  scenario "They see the cart count update from 0 to 1" do
    visit root_path
    # save_and_open_screenshot

    within('#navbar') do
      expect(page).to have_content("My Cart (0)")
    end

    product = page.first('article.product')
    # puts page.html # will log the html content of the page
    # button = product.find_link('Add') # not working!
    button = page.find('form.button_to button:first-child')
    # puts "button>>>>>>>>>>>>>>>>>>>>>>>>", button
    button.click

    # save_and_open_screenshot # not working
    # save_screenshot # works

    within('#navbar') do
      expect(page).to have_content("My Cart (1)")
    end

  end

end