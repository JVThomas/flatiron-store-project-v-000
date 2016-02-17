class CartsController < ApplicationController
  before_action :set_cart, only:[:checkout]

  def show
    current_cart.nil? ? @cart = Cart.find(params[:id]) : @cart = set_cart
  end

  def checkout
    @cart.checkout
    @current_user.current_cart = nil
    current_user.save
    @cart.status = "submitted"
    @cart.save
    redirect_to cart_path(@cart), notice: "Order submitted"
  end

  private

  def set_cart
    @cart = current_cart
  end

end
