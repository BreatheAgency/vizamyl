# Vizamyl Training App

### Updating development with production data

```
heroku pg:pull HEROKU_POSTGRESQL_PURPLE_URL vizamyl_production_dump --app vizamyl
psql
DROP DATABASE vizamyl_development;
CREATE DATABASE vizamyl_development WITH TEMPLATE vizamyl_production_dump;
```

### Adding a language

* Get access to the password spreadsheet
* Add new content admin; be sure to set the locale
* Add new superuser by `dup`ing another superuser; be sure to currect the locale!
* Add the locale to each step; `Step.all.each { |s| s.locales << 'jp' ; s.save! }`
* Consider running `scripts/add_translations_for_new_language.sql.erb`. Note the comments.
* Add the relevant locale to `layout.yml` & `pages.yml`, then translate them
* Rename videos as per the conventions. At the time of writing there are 95 videos.
* Fix `videos.source` for the new videos:
``` ruby
I18n.locale = 'jp'
Video.all.each { |v| v.source = v.source.gsub(/^EN/, 'JP') ; v.save! }
Question
  .all
  .select { |q| q.explanation_source.present? }
  .each { |v| v.explanation_source = v.explanation_source.gsub(/^EN/, 'JP') ; v.save! }
```
* Add vidoes to the vizamyl-staging S3 bucket's 'videos-in', then schedule transcoding via scripts/transcode
* Deploy, then add new admin users on the production db via the console
* Add to locales / origins list for the filters on the active admin page

### Deployment

```
heroku pg:backups capture --app vizamyl-staging
heroku pg:backups capture --app vizamyl
dropdb vizamyl_staging_dump
dropdb vizamyl_production_dump
heroku pg:pull HEROKU_POSTGRESQL_ONYX_URL vizamyl_staging_dump --app vizamyl-staging
heroku pg:pull HEROKU_POSTGRESQL_PURPLE_URL vizamyl_production_dump --app vizamyl
pg_dump vizamyl_production_dump -O -t users -t users_id_seq -t admin_users -t admin_users_id_seq -t progressions -t progressions_id_seq -Fc -f production_users.sql --column-inserts --data-only
psql -d vizamyl_staging_dump -c "TRUNCATE TABLE users, admin_users, progressions RESTART IDENTITY;"
pg_restore production_users.sql -d vizamyl_staging_dump --single-transaction
aws s3 sync s3://vizamyl-production s3://vizamyl-production-backup
aws s3 sync s3://vizamyl-staging s3://vizamyl-staging-backup
aws s3 sync s3://vizamyl-staging s3://vizamyl-production
heroku maintenance:on --app vizamyl
heroku pg:reset DATABASE --app vizamyl --confirm vizamyl
heroku pg:push vizamyl_staging_dump DATABASE --app vizamyl
heroku maintenance:off --app vizamyl
heroku ps:restart --app vizamyl
```
