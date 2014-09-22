admin = AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

user = User.new(title: 'Dr', first_name: 'Demo', last_name: 'Account', email: 'demo@example.com', password: 'password', password_confirmation: 'password')
user.skip_confirmation!
user.save!

chapter_one = Chapter.create!(title: 'Chapter 1')

video_one = Video.create_for_chapter(chapter_one, title: 'Video 1')
image_one = Image.create_for_chapter(chapter_one, title: 'Image 1')

user.progressions.create!(step: video_one)
user.progressions.create!(step: image_one)
