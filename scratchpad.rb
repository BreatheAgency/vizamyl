# c = Chapter.find(8)
# t = c.tests
# qr = QuestionRound.where(subject: t)
# qs = Question.where(question_round: qr)
# I18n.locale = :en
# t.each { |n| n.update_attributes(results_title: 'Self-assessment questions results') }
# qs.each { |n| n.update_attributes(correct_title: 'Question ${index}: Correct', incorrect_title: 'Question ${index}: Incorrect') }
# I18n.locale = :de
# t.each { |n| n.update_attribute(:results_title, 'Ergebnis der Fragen zur Selbstbewertung') }
# qs.each { |n| n.update_attributes(correct_title: 'Frage ${index}: Richtig', incorrect_title: 'Frage ${index}: Falsch') }

User.new(locale: 'it', invite_code: 'tomography', salutation: 'Dr', first_name: 'Example', last_name: 'Example', email: 'it-super-user@readvizamyl.com', password: 'Ko94Pj1Yd4tXh2i', password_confirmation: 'Ko94Pj1Yd4tXh2i', institution: 'Example', super_user: true, terms_and_conditions_opt_in: true).save!
AdminUser.new(locale: 'it', email: 'it-admin@readvizamyl.com', password: 'phS4NT12JtGWAnY', password_confirmation: 'phS4NT12JtGWAnY').save!
AdminUser.new(locale: 'it', email: 'it-content-admin@readvizamyl.com', password: 'ZCa2gZIC883OJXQ', password_confirmation: 'ZCa2gZIC883OJXQ').save!
