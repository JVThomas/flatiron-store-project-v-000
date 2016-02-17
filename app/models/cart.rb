class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def add_item(item_id)
    line_item = LineItem.find_by(cart_id: self.id, item_id: item_id)
    if !!line_item
      line_item.quantity += 1
    else
      line_item = self.line_items.build(item_id: item_id, cart_id: self.id)
    end
    line_item
  end

  def total
    total = 0
    line_items.each do |line_item|
      total += line_item.quantity * line_item.item.price
    end
    total
  end

end
