# Vizamyl
- http://vizamyl-sandbox.herokuapp.com
- http://stg-www.readvizamyl.com
- https://www.readvizamyl.com

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

```
heroku pg:backups capture --app vizamyl-staging
heroku pg:backups capture --app vizamyl
dropdb vizamyl_staging_dump
dropdb vizamyl_production_dump
heroku pg:pull DATABASE vizamyl_staging_dump --app vizamyl-staging
heroku pg:pull DATABASE vizamyl_production_dump --app vizamyl
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

# Image magick

```
mkdir _new && cd _new
convert black/*.jpg -crop 550x464+0+0 -bordercolor Black -border 0x18 -set filename:f '%t' ../_new/'%[filename:f].jpg'
convert white/*.jpg -crop 550x464+0+0 -bordercolor White -border 0x18 -set filename:f '%t' ../_new/'%[filename:f].jpg'
```

# Cache

```
aws s3 cp s3://vizamyl-staging/videos s3://vizamyl-staging/videos --recursive --metadata-directive REPLACE --expires 2100-01-01T00:00:00Z --acl public-read --cache-control max-age=2592000,public
aws s3 cp s3://vizamyl-staging/images s3://vizamyl-staging/images --recursive --metadata-directive REPLACE --expires 2100-01-01T00:00:00Z --acl public-read --cache-control max-age=2592000,public
aws s3 cp s3://vizamyl-staging/interactives s3://vizamyl-staging/interactives --recursive --metadata-directive REPLACE --expires 2100-01-01T00:00:00Z --acl public-read --cache-control max-age=2592000,public
aws s3 cp s3://vizamyl-production/videos s3://vizamyl-production/videos --recursive --metadata-directive REPLACE --expires 2100-01-01T00:00:00Z --acl public-read --cache-control max-age=2592000,public
aws s3 cp s3://vizamyl-production/images s3://vizamyl-production/images --recursive --metadata-directive REPLACE --expires 2100-01-01T00:00:00Z --acl public-read --cache-control max-age=2592000,public
aws s3 cp s3://vizamyl-production/interactives s3://vizamyl-production/interactives --recursive --metadata-directive REPLACE --expires 2100-01-01T00:00:00Z --acl public-read --cache-control max-age=2592000,public
```
