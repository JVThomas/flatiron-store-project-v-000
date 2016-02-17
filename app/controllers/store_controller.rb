class StoreController < ApplicationController

  def index
    @categories = Category.all
    @items = Item.available_items
    binding.pry
  end
  
end
