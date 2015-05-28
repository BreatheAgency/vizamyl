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

UPDATE answer_translations SET body = replace(body,'(18F)','(<sup>18</sup>F)');
SELECT * FROM question_translations WHERE question_translations.title ILIKE '%(18F)%';


SELECT sum(
  array_length(regexp_split_to_array(body, '\s'),1) +
  array_length(regexp_split_to_array(abbreviations, '\s'),1)
)
AS total FROM text_translations;
