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

User.new(locale: 'en-us', invite_code: '8Q5MH', salutation: 'Dr', first_name: 'Example', last_name: 'Example', email: 'en-us-super-user@readvizamyl.com', password: 'NVkorxCgeLYnor', password_confirmation: 'NVkorxCgeLYnor', institution: 'Example', super_user: true, terms_and_conditions_opt_in: true).save!
AdminUser.new(locale: 'en-us', email: 'en-us-content-admin@readvizamyl.com', password: 'YdvZeuWenNrzWo', password_confirmation: 'YdvZeuWenNrzWo').save!
