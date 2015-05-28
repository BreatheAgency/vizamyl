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


# User.new(locale: 'fr', invite_code: 'resonance', salutation: 'Dr', first_name: 'Example', last_name: 'Example', email: 'fr-super-user@readvizamyl.com', password: 'w9aMyMm2Fd', password_confirmation: 'w9aMyMm2Fd', institution: 'Example', super_user: true, terms_and_conditions_opt_in: true).save!

# AdminUser.new(locale: 'fr', email: 'fr-admin@readvizamyl.com', password: 'jGsHZes5dCeWR6a', password_confirmation: 'jGsHZes5dCeWR6a').save!

# AdminUser.new(locale: 'fr', email: 'fr-content-admin@readvizamyl.com', password: 'si8Enf939Q9I6mQ', password_confirmation: 'si8Enf939Q9I6mQ').save!
