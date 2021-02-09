module Features
  module SessionHelpers
    def login_as(user, locale = :en)
      visit login_path(locale: locale)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_button(locale == :en ? 'Login' : '登入')
    end
  end
end
