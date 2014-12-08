DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM answer_translations;
UPDATE tmptable SET id = nextval('answer_translations_id_seq');
UPDATE tmptable SET locale = 'de';
INSERT INTO answer_translations (SELECT * FROM tmptable);
DROP TABLE IF EXISTS tmptable;

DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM chapter_translations;
UPDATE tmptable SET id = nextval('chapter_translations_id_seq');
UPDATE tmptable SET locale = 'de';
INSERT INTO chapter_translations (SELECT * FROM tmptable);
DROP TABLE IF EXISTS tmptable;

DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM image_source_translations;
UPDATE tmptable SET id = nextval('image_source_translations_id_seq');
UPDATE tmptable SET locale = 'de';
INSERT INTO image_source_translations (SELECT * FROM tmptable);
DROP TABLE IF EXISTS tmptable;

DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM image_translations;
UPDATE tmptable SET id = nextval('image_translations_id_seq');
UPDATE tmptable SET locale = 'de';
INSERT INTO image_translations (SELECT * FROM tmptable);
DROP TABLE IF EXISTS tmptable;

DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM interactive_source_translations;
UPDATE tmptable SET id = nextval('interactive_source_translations_id_seq');
UPDATE tmptable SET locale = 'de';
INSERT INTO interactive_source_translations (SELECT * FROM tmptable);
DROP TABLE IF EXISTS tmptable;

DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM interactive_translations;
UPDATE tmptable SET id = nextval('interactive_translations_id_seq');
UPDATE tmptable SET locale = 'de';
INSERT INTO interactive_translations (SELECT * FROM tmptable);
DROP TABLE IF EXISTS tmptable;

DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM question_intro_translations;
UPDATE tmptable SET id = nextval('question_intro_translations_id_seq');
UPDATE tmptable SET locale = 'de';
INSERT INTO question_intro_translations (SELECT * FROM tmptable);
DROP TABLE IF EXISTS tmptable;

DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM question_translations;
UPDATE tmptable SET id = nextval('question_translations_id_seq');
UPDATE tmptable SET locale = 'de';
INSERT INTO question_translations (SELECT * FROM tmptable);
DROP TABLE IF EXISTS tmptable;

DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM test_translations;
UPDATE tmptable SET id = nextval('test_translations_id_seq');
UPDATE tmptable SET locale = 'de';
INSERT INTO test_translations (SELECT * FROM tmptable);
DROP TABLE IF EXISTS tmptable;

DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM text_translations;
UPDATE tmptable SET id = nextval('text_translations_id_seq');
UPDATE tmptable SET locale = 'de';
INSERT INTO text_translations (SELECT * FROM tmptable);
DROP TABLE IF EXISTS tmptable;

DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM video_translations;
UPDATE tmptable SET id = nextval('video_translations_id_seq');
UPDATE tmptable SET locale = 'de';
INSERT INTO video_translations (SELECT * FROM tmptable);
DROP TABLE IF EXISTS tmptable;
