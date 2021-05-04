require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do
  #SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can click link to a product page" do
    visit root_path
    within('article.product', match: :first) {
      find('a', match: :first).click
    }
    expect(page).to have_css 'article.product-detail'
  end
end
