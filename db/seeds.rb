chapter_one = Chapter.create!(title: 'Chapter 1')

video_one = Video.create_for_chapter(chapter_one, title: 'Video 1')
image_one = Image.create_for_chapter(chapter_one, title: 'Image 1')

I18n.available_locales.each do |locale|
  admin = AdminUser.create!(locale: locale, email: "#{locale}-admin@example.com", password: 'password', password_confirmation: 'password')
  user = User.new(locale: locale, title: 'Ms', first_name: locale.capitalize, last_name: 'User', email: "#{locale}-user@example.com", password: 'password', password_confirmation: 'password')
  user.skip_confirmation!
  user.save!

  user.progressions.create!(step: video_one)
  user.progressions.create!(step: image_one)
end
