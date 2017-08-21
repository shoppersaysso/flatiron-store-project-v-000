class CartsController < ApplicationController
  before_action :set_cart, only: [:show]

  def index
    @carts = current_user.carts
  end

  def show
  end

  def checkout
    @cart = current_user.current_cart
    if @cart.nil?
      redirect_to store_path
    else
    @cart.status = "submitted"
    @cart.line_items.each do |l|
      l.item.inventory -= l.quantity
      l.item.save
      current_user.current_cart = nil
      end
    end
    if @cart.save && current_user.save
      respond_to do |format|
        format.html { redirect_to cart_path(@cart), notice: "Your order has been placed!"}
      end
    end
  end


private

  def set_cart
    @cart = Cart.find(params[:id])
  end


end
