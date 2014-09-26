(1...8).each do |i|
  c = Chapter.create!(title: "Chapter #{i}", position: i)
  Video.create_for_chapter(c, title: 'Video 1')
  Image.create_for_chapter(c, title: 'Image 1')
end

I18n.available_locales.each do |locale|
  admin = AdminUser.create!(locale: locale, email: "#{locale}-admin@example.com", password: 'password', password_confirmation: 'password')
  user = User.new(locale: locale, title: 'Ms', first_name: locale.capitalize, last_name: 'User', email: "#{locale}-user@example.com", password: 'password', password_confirmation: 'password')
  user.skip_confirmation!
  user.save!
  Step.all.each do |step|
    user.progressions.create!(step: step)
  end
  first_chapter = Chapter.first
  first_step = first_chapter.steps.first
  first_progression = user.progressions.where(step: first_step).first
  first_progression.update_attributes(amount: 0.5)
end
