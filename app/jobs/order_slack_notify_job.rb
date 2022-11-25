class OrderSlackNotifyJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find order_id
    notifier = Slack::Notifier.new 'https://hooks.slack.com/services/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'
    notifier.ping "The user #{order.user.email} is order!\nThe amount is: #{order.amount}, \nThe serial number is: #{order.serial_number}, \nThe status is: #{order.state}"
  end
end
