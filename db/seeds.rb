DUMMY_BODY = 'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.'
DUMMY_ABBREVIATIONS = 'MRI: magnetic resonance imaging<br>PET: positron emission tomography<br>'

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
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})

module_one = Chapter.create(title: 'Module 1', position: 2)
module_one.texts.create({
  page_id: 'M1_P1',
  title: 'Text',
  body: DUMMY_BODY,
})

module_one_a = Chapter.create(title: 'Module 1a', position: 3)
module_one_a.texts.create({
  page_id: 'M1A_P1',
  title: 'Text',
  body: DUMMY_BODY
  subject_area: 'Subject Area',
})
module_one_a.videos.create({
  page_id: 'M1A_P2',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
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
# M1A_P5
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
# M1A_P8

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
})
module_one_b.videos.create({
  page_id: 'M1B_P3',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_one_b.interactives.create({
  page_id: 'M1B_P4',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_one_b.question_intros.create({
  page_id: 'M1B_P5',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
# M1B_P6
module_one_b.videos.create({
  page_id: 'M1B_P7',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_one_b.interactives.create({
  page_id: 'M1B_P8',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_one_b.question_intros.create({
  page_id: 'M1B_P9',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
# M1B_P10
module_one_b.videos.create({
  page_id: 'M1B_P11',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,

})
module_one_b.interactives.create({
  page_id: 'M1B_P12',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_one_b.question_intros.create({
  page_id: 'M1B_P13',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
# M1B_P14

module_two = Chapter.create(title: 'Module 2', position: 5)
module_two.texts.create({
  page_id: 'M2_P1',
  title: 'Text',
  body: DUMMY_BODY,
})

module_two_a = Chapter.create(title: 'Module 2a', position: 6)
module_two_a.texts.create({
  page_id: 'M2A_P1',
  title: 'Text',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
})
module_two_a.videos.create({
  page_id: 'M2A_P2',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_two_a.videos.create({
  page_id: 'M2A_P3',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_two_a.videos.create({
  page_id: 'M2A_P4',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_two_a.videos.create({
  page_id: 'M2A_P5',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: false,
})
module_two_a.question_intros.create({
  page_id: 'M2A_P6',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
#M2A_P7
module_two_a.videos.create({
  page_id: 'M2A_P8',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: false,
})
module_two_a.question_intros.create({
  page_id: 'M2A_P9',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
#M2A_P10
module_two_a.videos.create({
  page_id: 'M2A_P11',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: false,
})
module_two_a.question_intros.create({
  page_id: 'M2A_P12',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
#M2A_P13
module_two_a.videos.create({
  page_id: 'M2A_P14',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})

module_two_b = Chapter.create(title: 'Module 2b', position: 6)
module_two_b.texts.create({
  page_id: 'M2B_P1',
  title: 'Text',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
})
module_two_b.videos.create({
  page_id: 'M2B_P2',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_two_b.videos.create({
  page_id: 'M2B_P3',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_two_b.question_intros.create({
  page_id: 'M2B_P4',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
#M2B_P5
module_two_b.videos.create({
  page_id: 'M2B_P6',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_two_b.question_intros.create({
  page_id: 'M2B_P7',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
#M2B_P8
module_two_b.videos.create({
  page_id: 'M2B_P9',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_two_b.question_intros.create({
  page_id: 'M2B_P10',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
#M2B_P11

module_three = Chapter.create(title: 'Module 3', position: 7)
module_three.texts.create({
  page_id: 'M3_P1',
  title: 'Text',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
})
module_three.videos.create({
  page_id: 'M3_P2',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P3',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P4',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P5',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P6',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P7',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P8',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P9',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P10',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P11',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.question_intros.create({
  page_id: 'M3_P12',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
#M3_P13
module_three.videos.create({
  page_id: 'M3_P14',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P15',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P16',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P17',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P18',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P19',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P20',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P21',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P22',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P23',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P24',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P25',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P26',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P27',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P28',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.question_intros.create({
  page_id: 'M3_P29',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
#M3_P30
module_three.videos.create({
  page_id: 'M3_P31',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P32',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P33',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P34',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P35',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P36',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P37',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P38',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P39',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.question_intros.create({
  page_id: 'M3_P40',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
#M3_P41
module_three.videos.create({
  page_id: 'M3_P42',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P43',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P44',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P45',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P46',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P47',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P48',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.question_intros.create({
  page_id: 'M3_P49',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
#M3_P50
module_three.videos.create({
  page_id: 'M3_P51',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P52',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P53',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.interactives.create({
  page_id: 'M3_P54',
  title: 'Interactive',
  body: DUMMY_BODY,
})
module_three.videos.create({
  page_id: 'M3_P55',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.question_intros.create({
  page_id: 'M3_P56',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
#M3_P57
module_three.videos.create({
  page_id: 'M3_P58',
  title: 'Video',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P59',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.videos.create({
  page_id: 'M3_P60',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
module_three.question_intros.create({
  page_id: 'M3_P61',
  title: 'Question Intro',
  body: DUMMY_BODY,
})
#M3_P62
module_four_a = Chapter.create(title: 'Module 4a', position: 8)
module_four_a.texts.create({
  page_id: 'M4A_P1',
  title: 'Text',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
})
module_four_a.videos.create({
  page_id: 'M4A_P2',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
#M4A_P3
module_four_a.videos.create({
  page_id: 'M4A_P4',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
#M4A_P5
module_four_a.videos.create({
  page_id: 'M4A_P6',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
})
#M4A_P7
module_four_a.videos.create({
  page_id: 'M4A_P8',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: false,
})
#M4A_P9
module_four_a.videos.create({
  page_id: 'M4A_P10',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: false,
})
#M4A_P11
module_four_a.videos.create({
  page_id: 'M4A_P12',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: false,
})
#M4A_P13
module_four_a.videos.create({
  page_id: 'M4A_P14',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: false,
})
#M4A_P15
module_four_a.videos.create({
  page_id: 'M4A_P16',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: false,
})
#M4A_P17
module_four_a.videos.create({
  page_id: 'M4A_P18',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: false,
})
#M4A_P19
module_four_a.videos.create({
  page_id: 'M4A_P20',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: false,
})
#M4A_P21
module_four_a.videos.create({
  page_id: 'M4A_P22',
  title: 'Video',
  body: DUMMY_BODY,
  source: 'M0_P2_VIDEO',
  abbreviations: DUMMY_ABBREVIATIONS,
  mandatory: false,
})

module_four_b = Chapter.create(title: 'Module 4b', position: 9)
module_four_b.texts.create({
  page_id: 'M4B_P1',
  title: 'Text',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
})
#M4B_P2
#M4B_P3?
module_four_b.texts.create({
  page_id: 'M4B_P4',
  title: 'Text',
  body: DUMMY_BODY,
  subject_area: 'Subject Area',
})

I18n.available_locales.each do |locale|
  admin = AdminUser.create!(locale: locale, email: "#{locale}-admin@readvizamyl.com", password: 'vzmyl100', password_confirmation: 'vzmyl100')

  [true, false].each do |super_user|
    user = User.new(locale: locale, invite_code: 'invite', title: 'Dr', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "#{locale}-#{(super_user) ? 'super-' : ''}user@readvizamyl.com", password: 'vzmyl100', password_confirmation: 'vzmyl100', super_user: super_user)
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

# User.all.each do |user|
#   Step.all.each do |step|
#     user.progressions.create(step:step)
#   end
# end
