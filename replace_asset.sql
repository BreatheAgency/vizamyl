DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM image_source_translations;
UPDATE tmptable SET id = nextval('image_source_translations_id_seq');¬
UPDATE tmptable SET locale = 'de';
INSERT INTO image_source_translations (SELECT * FROM tmptable);¬
DROP TABLE IF EXISTS tmptable;

UPDATE video_translations
SET source = replace(source, 'EN_','DE_')
WHERE locale='de'
