class TopUpsController < ApplicationController
  before_action :authenticate_user!
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(params_order)
    @order.user = current_user
    @order.save
    OrderSlackNotifyJob.perform_later(@order.id)
  end

  def params_order
    params.require(:order).permit(:amount, :bank_name, :bank_card_number, :bank_real_name)
  end
end
