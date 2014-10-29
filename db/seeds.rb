chapter_zero = Chapter.create(title: 'Module 0', position: 1)
chapter_zero.texts.build(title: 'Text')
chapter_zero.videos.build(title: 'Video')
chapter_zero.images.build(title: 'Image')
chapter_zero.interactives.build(title: 'Interactive')
chapter_zero.question_intros.build(title: 'Question Intro')
chapter_zero.image_questions.build(title: 'Image Question')
chapter_zero.interactive_questions.build(title: 'Interactive Question')
chapter_zero.save!

#
# chapter_one = Chapter.create!(title: 'Module 1', position: 2)
# Text.create_for_chapter(chapter_one, title: "(Text)")
#
# chapter_one_a = Chapter.create!(title: 'Module 1a', position: 3)
# Text.create_for_chapter(chapter_one_a, title: "(Text)")
# Video.create_for_chapter(chapter_one_a, title: "(Video)")
# Video.create_for_chapter(chapter_one_a, title: "(Video)")
# QuestionIntro.create_for_chapter(chapter_one_a, title: "(Question Intro)")
# ImageQuestion.create_for_chapter(chapter_one_a, title: "(Image Question)")
# Video.create_for_chapter(chapter_one_a, title: "(Video)")
# QuestionIntro.create_for_chapter(chapter_one_a, title: "(Question Intro)")
# ImageQuestion.create_for_chapter(chapter_one_a, title: "(Image Question)")
# Video.create_for_chapter(chapter_one_a, title: "(Video)")
#
# chapter_one_b = Chapter.create!(title: 'Module 1b', position: 4)
# Text.create_for_chapter(chapter_one_b, title: "(Text)")
# Video.create_for_chapter(chapter_one_b, title: "(Video)")
# Video.create_for_chapter(chapter_one_b, title: "(Video)")
# Interactive.create_for_chapter(chapter_one_b, title: "(Interactive)")
# QuestionIntro.create_for_chapter(chapter_one_b, title: "(Question Intro)")
# ImageQuestion.create_for_chapter(chapter_one_b, title: "(Image Question)")
# Video.create_for_chapter(chapter_one_b, title: "(Video)")
# Interactive.create_for_chapter(chapter_one_b, title: "(Interactive)")
# QuestionIntro.create_for_chapter(chapter_one_b, title: "(Question Intro)")
# ImageQuestion.create_for_chapter(chapter_one_b, title: "(Image Question)")
# Video.create_for_chapter(chapter_one_b, title: "(Video)")
# Interactive.create_for_chapter(chapter_one_b, title: "(Interactive)")
# QuestionIntro.create_for_chapter(chapter_one_b, title: "(Question Intro)")
# ImageQuestion.create_for_chapter(chapter_one_b, title: "(Image Question)")
#
# chapter_two = Chapter.create!(title: 'Module 2', position: 5)
# Text.create_for_chapter(chapter_two, title: "(Text)")
#
# chapter_two_a = Chapter.create!(title: 'Module 2a', position: 6)
# Text.create_for_chapter(chapter_two_a, title: "(Text)")
# Video.create_for_chapter(chapter_two_a, title: "(Video)")
# Video.create_for_chapter(chapter_two_a, title: "(Video)")
# Video.create_for_chapter(chapter_two_a, title: "(Video)")
# Video.create_for_chapter(chapter_two_a, title: "(Video)")
# QuestionIntro.create_for_chapter(chapter_two_a, title: "(Question Intro)")
# InteractiveQuestion.create_for_chapter(chapter_two_a, title: "(Interactive Question)")
# Video.create_for_chapter(chapter_two_a, title: "(Video)")
# QuestionIntro.create_for_chapter(chapter_two_a, title: "(Question Intro)")
# InteractiveQuestion.create_for_chapter(chapter_two_a, title: "(Interactive Question)")
# Video.create_for_chapter(chapter_two_a, title: "(Video)")
# QuestionIntro.create_for_chapter(chapter_two_a, title: "(Question Intro)")
# InteractiveQuestion.create_for_chapter(chapter_two_a, title: "(Interactive Question)")
# Video.create_for_chapter(chapter_two_a, title: "(Video)")

I18n.available_locales.each do |locale|
  admin = AdminUser.create!(locale: locale, email: "#{locale}-admin@example.com", password: 'password', password_confirmation: 'password')
  user = User.new(locale: locale, invite_code: 'invite', title: 'Ms', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "#{locale}-user@example.com", password: 'password', password_confirmation: 'password')
  user.save!
  Step.all.each do |step|
    user.progressions.create!(step: step)
  end
  # first_chapter = Chapter.first
  # first_step = first_chapter.steps.first
  # first_progression = user.progressions.where(step: first_step).first
  # first_progression.update_attributes(amount: 0.5)
end
