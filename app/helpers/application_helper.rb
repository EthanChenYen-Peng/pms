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

  def better_distance_of_time_in_words(date_time)
    if date_time >= Time.now
      t('time_to_future_in_words', days: distance_of_time_in_words_to_now(date_time))
    else
      t('time_ago_in_words', days: distance_of_time_in_words_to_now(date_time))
    end
  end
end
