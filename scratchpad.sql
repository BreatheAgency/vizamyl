DROP TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmptable as SELECT * FROM interactive_source_translations;
UPDATE tmptable SET id = nextval('interactive_source_translations_id_seq');
UPDATE tmptable SET locale = 'de';
INSERT INTO interactive_source_translations (SELECT * FROM tmptable);
DROP TABLE IF EXISTS tmptable;

UPDATE interactive_source_translations SET label = 'Negativ | Positiv' WHERE label = 'Coronal review' AND locale = 'de';

UPDATE interactive_source_translations SET label = 'Axiale Ansicht' WHERE label = 'Axial review' AND locale = 'de';
UPDATE interactive_source_translations SET label = 'Koronare Ansicht' WHERE label = 'Coronal review' AND locale = 'de';
UPDATE interactive_source_translations SET label = 'Sagittale Ansicht' WHERE label = 'Sagittal review' AND locale = 'de';

UPDATE interactive_source_translations SET label = 'Axiale Ansicht' WHERE label = 'Axiale ansicht' AND locale = 'de';
UPDATE interactive_source_translations SET label = 'Koronare Ansicht' WHERE label = 'Koronare ansicht' AND locale = 'de';
UPDATE interactive_source_translations SET label = 'Koronare Ansicht' WHERE label = 'Coronal review ' AND locale = 'de';

UPDATE question_translations SET explanation_source = replace(explanation_source, 'EN_','DE_') WHERE locale = 'de';

UPDATE text_translations set body = replace(body, '"Weiter"', '„Weiter“') where locale = 'de';
UPDATE interactive_translations set body = replace(body, '"Weiter"', '„Weiter“') where locale = 'de';

UPDATE question_translations SET title = replace(title,'(18F)','(<sup>18</sup>F)');
SELECT * FROM question_translations WHERE question_translations.title ILIKE '%(18F)%';

UPDATE text_translations SET body = replace(body,'(18F)','(<sup>18</sup>F)');
SELECT * FROM text_translations WHERE text_translations.body ILIKE '%(18F)%';

SELECT * FROM answer_translations WHERE locale='it';

SELECT * FROM answer_translations WHERE locale='it' AND body LIKE '%<p> </p>%';

UPDATE answer_translations SET body = REPLACE(body, '<p> </p>', '') WHERE locale='it';

UPDATE question_translations SET title = REPLACE(title, '18F;', '<sup>18</sup>F') WHERE locale='it';

UPDATE question_translations SET title = regexp_replace(title, '[\n\r]+', ' ', 'g' ) WHERE locale='it';

COUNT(DISTINCT(users));

SELECT COUNT(DISTINCT id) FROM users;









####################################################################







SELECT sum(
  array_length(regexp_split_to_array(title, '\s'),1) +
  array_length(regexp_split_to_array(body, '\s'),1) +
  array_length(regexp_split_to_array(abbreviations, '\s'),1)
)
AS text_total FROM text_translations;

SELECT sum(
  array_length(regexp_split_to_array(title, '\s'),1) +
  array_length(regexp_split_to_array(body, '\s'),1) +
  array_length(regexp_split_to_array(abbreviations, '\s'),1)
)
AS video_title FROM video_translations;

SELECT sum(
  array_length(regexp_split_to_array(title, '\s'),1) +
  array_length(regexp_split_to_array(correct_title, '\s'),1) +
  array_length(regexp_split_to_array(incorrect_title, '\s'),1)
)
AS question_total FROM question_translations;

SELECT sum(
  array_length(regexp_split_to_array(title, '\s'),1) +
  array_length(regexp_split_to_array(body, '\s'),1)
)
AS interactive_total FROM interactive_translations;

SELECT sum(
  array_length(regexp_split_to_array(body, '\s'),1)
)
AS answer_total FROM answer_translations;

SELECT sum(
  array_length(regexp_split_to_array(body, '\s'),1)
)
AS question_intro_total FROM question_intro_translations;

SELECT sum(
  array_length(regexp_split_to_array(title, '\s'),1)
)
AS chapter_total FROM chapter_translations;
