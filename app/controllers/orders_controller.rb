class OrdersController < ApplicationController

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def new
  end

  def show
    @order = Order.find(params[:id] || params[:order_id])
  end

  def create
    order = Order.new(order_params)
    order.user = current_user
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      flash[:success] = "Your order has been created."
      redirect_to "/profile/orders"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  def update
    order = Order.find(params[:order_id])
    if order.status != "shipped"
      order.update(status: 3)
      order.item_orders.map do |item_order|
        item_order.add_back_to_inventory
      end
      flash[:notice] = "Order-#{order.id} is now #{order.status}"
      redirect_to "/profile"
    else
      flash[:error] = "You cannot cancel a shipped order."
    end
  end


  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
