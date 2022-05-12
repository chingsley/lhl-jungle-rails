class OrdersController < ApplicationController

  # Add a before_filter to any controller that you want to secure. 
  # This will force user’s to login before they can see the actions 
  # in this controller. I’ve created a gif controller below which
  # I’m going to secure. The routes for this controller were added
  # to the routes.rb in the beginning of this tutorial.

  # before_filter :authorize

  def show
    @order = Order.find(params[:id])
    
    # puts "\n\naldalfaljflajfa\n\n",  @order
    # render :json => @order
    # render :json => @order.line_items
    # render :json => @order.line_items[0].product
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

end
