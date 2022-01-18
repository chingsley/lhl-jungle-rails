class Admin::DashboardController < ApplicationController
  def show
    @prodcucts_count = Product.count
    @categories_count = Category.count
  end
end
