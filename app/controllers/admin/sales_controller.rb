class Admin::SalesController < ApplicationController

  def index
    @sales = Sale.order(id: :desc).all
    # @sales = Sale.all
  end

end
