class AsyncLinkEmailJob < ApplicationJob
  queue_as :default

  def perform(visitor, site)

    visitor.pending = false
    visitor.save
                
    data = visitor.get_data
    VisitMailer.new_link_email(visitor.id, site, data).deliver_now

  end
end
