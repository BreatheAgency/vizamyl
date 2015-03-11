DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM interactive_source_translations;
UPDATE tmptable SET id = nextval('interactive_source_translations_id_seq');
UPDATE tmptable SET locale = 'de';
UPDATE tmptable SET source = replace(source, 'EN_','DE_');
INSERT INTO interactive_source_translations (SELECT * FROM tmptable);
DROP TABLE IF EXISTS tmptable;



SELECT * FROM interactive_sources;

UPDATE interactive_sources SET source = replace(source, 'EN_','')

UPDATE interactive_source_translations SET label = 'Axiale ansicht' WHERE label = 'Axiale Ansicht' AND locale = 'de';
UPDATE interactive_source_translations SET label = 'Koronare ansicht' WHERE label = 'Koronare Ansicht' AND locale = 'de';
UPDATE interactive_source_translations SET label = 'Sagittale ansicht' WHERE label = 'Sagittale Ansicht' AND locale = 'de';
