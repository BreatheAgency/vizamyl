# Vizamyl

http://vizamyl-staging.herokuapp.com
http://vizamyl.herokuapp.com

# Deployment

`psql -d vizamyl_predeploy -c "DROP TABLE users, active_admin_comments, admin_users, progressions; CASCADE"`

`PGUSER=postgres PGPASSWORD=password heroku pg:pull DATABASE vizamyl_predeploy --app vizamyl-staging`
`pg_dump vizamyl_predeploy -O -T users -T users_id_seq -T active_admin_comments -T active_admin_comments_id_seq -T admin_users -T admin_users_id_seq -T progressions -T progressions_id_seq -Fc -f dump.sql`

`psql -d vizamyl_predeploy_tune -c "TRUNCATE TABLE answer_translations, answers, chapter_translations, chapters, four_b_translations, four_bs, image_source_translations, image_sources, image_translations, images, interactive_source_translations, interactive_sources, interactive_translations, interactives, question_intro_translations, question_intros, question_rounds, question_translations, questions, steps, test_translations, tests, text_translations, texts, video_translations, videos, schema_migrations RESTART IDENTITY;"`
`heroku pg:psql --app vizamyl-production`

`createdb vizamyl_predeploy_tune`
`pg_restore dump.sql -d vizamyl_predeploy_tune --single-transaction`
`dropdb vizamyl_predeploy`


`TRUNCATE TABLE answer_translations, answers, chapter_translations, chapters,
four_b_translations, four_bs, image_source_translations, image_sources,
image_translations, images, interactive_source_translations,
interactive_sources, interactive_translations, interactives,
question_intro_translations, question_intros, question_rounds,
question_translations, questions, steps, test_translations, tests,
text_translations, texts, video_translations, videos, schema_migrations; RESTART
IDENTITY;`
