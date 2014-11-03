DUMMY_BODY = '<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p>'
DUMMY_ABBREVIATIONS = '<p><strong>MRI:</strong> magnetic resonance imaging</p><p><strong>PET:</strong> positron emission tomography</p>'

module_zero = Chapter.create(title: 'Introduction', position: 1)
module_zero.texts.create({
  page_id: 'M0_P1',
  title: 'Text',
  body: DUMMY_BODY
})
module_zero.videos.create({
  page_id: 'M0_P2',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: true,
})

module_one = Chapter.create(title: 'Module 1', position: 2)
module_one.images.create({
  page_id: 'M1_P1',
  title: 'Image',
  source: 'test',
})

module_one_a = Chapter.create(title: 'Module 1a', position: 3)
module_one_a.images.create({
  page_id: 'M1A_P1',
  title: 'Image',
  source: 'test',
  subject_area: 'Subject Area',
})
module_one_a.videos.create({
  page_id: 'M1A_P2',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: true,
})
module_one_a.videos.create({
  page_id: 'M1A_P3',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: false,
})
module_one_a.question_intros.create({
  page_id: 'M1A_P4',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
module_one_a.image_questions.create({
  page_id: 'M1A_P5',
  title: 'Image Question',
  subject_area: 'Subject Area',
})
module_one_a.videos.create({
  page_id: 'M1A_P6',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: false,
})
module_one_a.question_intros.create({
  page_id: 'M1A_P7',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
module_one_a.image_questions.create({
  page_id: 'M1A_P8',
  title: 'Image Question',
})

module_one_b = Chapter.create(title: 'Module 1b', position: 4)
module_one_b.texts.create({
  page_id: 'M1B_P1',
  title: 'Text',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
})
module_one_b.videos.create({
  page_id: 'M1B_P2',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: true,
})
module_one_b.videos.create({
  page_id: 'M1B_P3',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: true,
})
module_one_b.interactives.create({
  page_id: 'M1B_P4',
  title: 'Interactive',
  body: DUMMY_BODY,
  sources: ['test', 'test']
})
module_one_b.question_intros.create({
  page_id: 'M1B_P5',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
module_one_b.image_questions.create({
  page_id: 'M1B_P6',
  title: 'Image Question',
})

# chapter_zero.interactive_questions.create({
#   title: 'Interactive Question',
#   subject_area: 'Subject Area',
# })


I18n.available_locales.each do |locale|
  admin = AdminUser.create!(locale: locale, email: "#{locale}-admin@readvizamyl.com", password: 'password', password_confirmation: 'password')

  [true, false].each do |super_user|
    user = User.new(locale: locale, invite_code: 'invite', title: 'Ms', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "#{locale}-#{(super_user) ? 'super-' : ''}user@readvizamyl.com", password: 'password', password_confirmation: 'password', super_user: super_user)
    user.save!
    Step.all.each do |step|
      user.progressions.create!(step: step)
    end
    first_chapter = Chapter.first
    first_step = first_chapter.steps.first
    first_progression = user.progressions.where(step: first_step).first
    first_progression.update_attributes(amount: 0.5)
  end
end
