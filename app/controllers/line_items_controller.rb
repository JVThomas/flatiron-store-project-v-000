class LineItemsController < ApplicationController

  def create
    if !current_cart
     current_user.current_cart = Cart.create(user_id: current_user.id)
    end
    line_item = current_user.current_cart.add_item(params[:item_id])
    line_item.save
    current_user.save
    redirect_to cart_path(current_cart)
  end

end
