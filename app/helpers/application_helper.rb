module ApplicationHelper
  def render_item_or_items(message, &block)
    if message.respond_to?(:each)
      message.each(&block)
    else
      yield message
    end
  end

  def switch_locale_path(language)
    if request.path == '/'
      "/#{language.to_s}"
    else
      request.path.sub(locale.to_s, language.to_s)
    end
  end
end
