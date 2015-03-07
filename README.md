# Vizamyl

- http://vizamyl-sandbox.herokuapp.com
- http://vizamyl-staging.herokuapp.com
- http://vizamyl.herokuapp.com

# Deployment

- Backup
- Pull latest dbs
- Dump only the users
- Pull latest staging
- Grab all users from production as inserts
- Remove all users from staging
- "Restore" all users from production to staging
- Maintenance mode
- Restore
- Live!

`heroku pgbackups:capture --expire --app vizamyl-staging`
`heroku pgbackups:capture --expire --app vizamyl`
`dropdb vizamyl_staging_dump`
`dropdb vizamyl_production_dump`
`heroku pg:pull DATABASE vizamyl_staging_dump --app vizamyl-staging`
`heroku pg:pull DATABASE vizamyl_production_dump --app vizamyl`
`pg_dump vizamyl_production_dump -O -t users -t users_id_seq -t admin_users -t admin_users_id_seq -t progressions -t progressions_id_seq -Fc -f production_users.sql --column-inserts --data-only`
`psql -d vizamyl_staging_dump -c "TRUNCATE TABLE users, admin_users, progressions RESTART IDENTITY;"`
`pg_restore production_users.sql -d vizamyl_staging_dump --single-transaction`
`heroku maintenance:on --app vizamyl`
`heroku pg:reset DATABASE --app vizamyl`
`heroku pg:push vizamyl_staging_dump DATABASE --app vizamyl`
`heroku maintenance:off --app vizamyl`