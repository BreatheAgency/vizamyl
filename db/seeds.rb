(1...8).each do |i|
  c = Chapter.create!(title: "#{Faker::Commerce.product_name} (#{i})", position: i)
  Video.create_for_chapter(c, title: "(Video) #{Faker::Commerce.product_name}")
  Image.create_for_chapter(c, title: "(Image) #{Faker::Commerce.product_name}")
end

I18n.available_locales.each do |locale|
  admin = AdminUser.create!(locale: locale, email: "#{locale}-admin@example.com", password: 'password', password_confirmation: 'password')
  user = User.new(locale: locale, title: 'Ms', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "#{locale}-user@example.com", password: 'password', password_confirmation: 'password')
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
