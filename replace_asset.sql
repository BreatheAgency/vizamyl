UPDATE video_translations
SET source = replace(source, 'EN_','FR_')
WHERE locale='fr';

UPDATE image_source_translations
SET source = replace(source, 'EN_','FR_')
WHERE locale='fr';
