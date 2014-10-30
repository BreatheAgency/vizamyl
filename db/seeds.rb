chapter_zero = Chapter.create(title: 'Module 0', position: 1)
chapter_zero.texts.build({
  title: 'Text',
  body: '<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p>',
  subject_area: 'Subject Area',
})
chapter_zero.videos.build({
  title: 'Video',
  body: '<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p>',
  subject_area: 'Subject Area',
  source: 'test',
  references: '<p><strong>MRI:</strong> magnetic resonance imaging</p><p><strong>PET:</strong> positron emission tomography</p>',
})
chapter_zero.images.build({
  title: 'Image',
  subject_area: 'Subject Area',
  source: 'http://placehold.it/968x460',
})
chapter_zero.interactives.build({
  title: 'Interactive',
  subject_area: 'Subject Area',
})
chapter_zero.question_intros.build({
  title: 'Question Intro',
  body: '<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p>',
  subject_area: 'Subject Area',
})
chapter_zero.image_questions.build({
  title: 'Image Question',
  subject_area: 'Subject Area',
})
chapter_zero.interactive_questions.build({
  title: 'Interactive Question',
  subject_area: 'Subject Area',
})
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
