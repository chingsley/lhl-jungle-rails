class Admin::SalesController < ApplicationController

  def index
    @sales = Sale.order(id: :desc).all
    # @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end


  def create
    @sale = Sale.new(sale_params)

    if @sale.save
      redirect_to [:admin, :sales], notice: 'Product created!'
    else
      render :new
    end
  end


  private

  def sale_params
    params.require(:sale).permit(
      :name,
      :starts_on,
      :ends_on,
      :percent_off
    )
  end

end
