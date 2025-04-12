CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

SELECT * FROM job_applied;

INSERT INTO job_applied 
VALUES (1, '2020-01-01', TRUE, 'resume1.pdf', TRUE, 'cover_letter1.pdf', 'pending'),
       (2, '2020-01-02', FALSE, NULL, FALSE, NULL, 'rejected'),
       (3, '2020-01-03', TRUE, 'resume3.pdf', TRUE, 'cover_letter3.pdf', 'accepted');

SELECT * FROM job_applied;

INSERT INTO job_applied (
    job_id, 
    application_sent_date, 
    custom_resume, 
    resume_file_name, 
    cover_letter_sent, 
    cover_letter_file_name, 
    status
)
VALUES 
    (4, '2020-01-04', TRUE, 'resume4.pdf', TRUE, 'cover_letter4.pdf', 'pending'),
    (5, '2020-01-05', FALSE, NULL, FALSE, NULL, 'rejected'),
    (6, '2020-01-06', TRUE, 'resume6.pdf', TRUE, 'cover_letter6.pdf', 'accepted');

ALTER TABLE job_applied
ADD contact VARCHAR(50);  

UPDATE job_applied
SET contact = 'Erlich Bachman'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'Draco Malfoy'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Bertram Gilfoyle'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Alan Rickman'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Bill Gates'
WHERE job_id = 5;

UPDATE job_applied
SET status = 'submitted'
WHERE job_id = 1;

UPDATE job_applied
SET status = 'interview scheduled'
WHERE job_id = 2;

ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name;

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

ALTER TABLE job_applied
DROP COLUMN contact_name;

DELETE FROM job_applied
WHERE job_id = 6;

TRUNCATE TABLE job_applied;

DROP TABLE job_applied;

SELECT * FROM job_applied;