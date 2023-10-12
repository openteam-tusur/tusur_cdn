require 'active_support/concern'

module TusurCdn::ActionView
  module Helpers
    def render_cdn(key)
      data = TusurCdn::Consumer.new(key: key).get_data
      result = ERB.new(data.template).result(binding)
      result.html_safe
    rescue => exception
      Airbrake.notify(
        "Отвалился модуль #{key} на #{Rails.application.class.parent_name}",
        {
          redis_data: data,
          exception: exception
        }
      )
      return nil
    end

    ActiveSupport.on_load :action_view do
      include TusurCdn::ActionView::Helpers
    end
  end
end
