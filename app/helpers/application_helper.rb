module ApplicationHelper
  def get_locale
    params[:locale]
  end

  def render_item_or_items(message, &block)
    if message.respond_to?(:each)
      message.each(&block)
    else
      yield message
    end
  end
end
