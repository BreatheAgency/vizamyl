I18n.locale = :de
c = Chapter.find(8)
t = c.tests
t.update_all(results_title: 'Ergebnis der Fragen zur Selbstbewertung')
qr = QuestionRound.where(subject: t)
Question.where(question_round: qr).update_all(correct_title: 'Frage ${index}: Richtig', incorrect_title: 'Frage ${index}: Falsch')
