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

User.new(locale: 'es', invite_code: 'tomography', salutation: 'Dr', first_name: 'Example', last_name: 'Example', email: 'es-super-user@readvizamyl.com', password: 'I19vdW34CsS3VCD', password_confirmation: 'I19vdW34CsS3VCD', institution: 'Example', super_user: true, terms_and_conditions_opt_in: true).save!
AdminUser.new(locale: 'es', email: 'es-admin@readvizamyl.com', password: 'T31Rpcyz4b210EV', password_confirmation: 'T31Rpcyz4b210EV').save!
AdminUser.new(locale: 'es', email: 'es-content-admin@readvizamyl.com', password: 'cM6X8u3L68970oz', password_confirmation: 'cM6X8u3L68970oz').save!
