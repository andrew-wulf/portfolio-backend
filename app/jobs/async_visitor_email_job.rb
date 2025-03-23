class AsyncVisitorEmailJob < ApplicationJob
  queue_as :default

  def perform(visitor)
    data = visitor.get_all_recent_unique_visitors
    VisitMailer.new_visitor_email(visitor.id, data).deliver_now
  end
  
end
