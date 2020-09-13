class CartController < ApplicationController
  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    flash[:success] = "#{item.name} was successfully added to your cart"
    redirect_to "/items"
  end

  def show
    if current_admin?
      render file: "/public/404"
    else
      @items = cart.items
    end
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end

  def add_more_item
    item = Item.find(params[:item_id])

      if item.inventory_has_reached_limit?(cart, item)
        flash[:error] = "You've reached the end of this merchant's inventory"
        redirect_to '/cart'
      else
        cart.add_item(item.id.to_s)
        redirect_to '/cart'
      end
  end

end
