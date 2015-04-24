I18n.locale = :en
c = Chapter.find(7)
t = c.tests
t.update_all(results_title: 'Self-assessment questions results')
qr = QuestionRound.where(subject: t)
Question.where(question_round: qr).update_all(correct_title: 'Question ${index}: Correct', incorrect_title: 'Question ${index}: Incorrect')
