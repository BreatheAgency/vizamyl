c = Chapter.find(8)
t = c.tests
qr = QuestionRound.where(subject: t)
qs = Question.where(question_round: qr)

I18n.locale = :en
t.each { |n| n.update_attributes(results_title: 'Self-assessment questions results') }
qs.each { |n| n.update_attributes(correct_title: 'Question ${index}: Correct', incorrect_title: 'Question ${index}: Incorrect') }
I18n.locale = :de
t.each { |n| n.update_attribute(:results_title, 'Ergebnis der Fragen zur Selbstbewertung') }
qs.each { |n| n.update_attributes(correct_title: 'Frage ${index}: Richtig', incorrect_title: 'Frage ${index}: Falsch') }


User.new(locale: 'en-gb', invite_code: 'plaque', salutation: 'Dr', first_name: 'Example', last_name: 'Example', email: 'en-gb-super-user@readvizamyl.com', password: 'InjeiPLiN4HCQaO', password_confirmation: 'InjeiPLiN4HCQaO', institution: 'Example', super_user: true, terms_and_conditions_opt_in: true).save!

AdminUser.new(locale: 'en-gb', email: 'en-gb-admin@readvizamyl.com', password: 'q8q6ZhLvEfJ3gsm', password_confirmation: 'q8q6ZhLvEfJ3gsm').save!

AdminUser.new(locale: 'en-gb', email: 'en-gb-content-admin@readvizamyl.com', password: 'jxC5vWXbzx15V9X', password_confirmation: 'jxC5vWXbzx15V9X').save!
