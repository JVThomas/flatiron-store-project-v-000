class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def add_item(item_id)
    line_item = LineItem.where(cart_id: self.id, item_id: item_id).first
    if !!line_item
      line_item.quantity += 1
    else
      line_item = self.line_items.build(item_id: item_id)
    end
    line_item
  end

  def total
    total = Cart.joins(items: :line_items).select('SUM(line_items.quantity * items.price) as checkout_total').where(line_items:{cart_id: self.id}).first.checkout_total
  end

  def checkout
    line_items.each do |line_item|
      remove_inventory(line_item)
    end    
  end

  def remove_inventory(line_item)
    line_item.item.inventory -= line_item.quantity
    line_item.item.save
  end

end
