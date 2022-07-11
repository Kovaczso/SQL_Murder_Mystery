--A crime has taken place and the detective needs your help.
--The detective gave you the crime scene report, but you somehow lost it.
--You vaguely remember that the crime was a  murder  that occurred sometime on  Jan.15, 2018  and that it took place in  SQL City .
--Start by retrieving the corresponding crime scene report from the police department’s database.
Select
  *
FROM
  crime_scene_report
WHERE
  date = 20180115
  AND type = 'murder'
  AND city = 'SQL City';

--Security footage shows that there were 2 witnesses.
--The first witness lives at the last house on "Northwestern Dr".
--The second witness, named Annabel, lives somewhere on "Franklin Ave".
Select
  *
FROM
  person
Where
  address_street_name = 'Northwestern Dr'
ORDER BY
  address_number DESC
LIMIT
  1;

Select
  *
FROM
  person
Where
  name LIKE '%Annabel%'
  AND address_street_name = 'Franklin Ave';

--1st Witness  14887 Morty Schapiro 118009 4919 Northwestern Dr 111564949
--2nd Witness  16371 Annabel Miller 490173 490173 Franklin Ave 318771143
Select
  transcript,
  person.name
FROM
  interview
  JOIN person ON person.id = interview.person_id
WHERE
  interview.person_id IN (
    Select
      id
    FROM
      person
    Where
      address_street_name = 'Northwestern Dr'
    ORDER BY
      address_number DESC
    LIMIT
      1
  )
UNION
Select
  transcript,
  person.name
FROM
  interview
  JOIN person ON person.id = interview.person_id
WHERE
  interview.person_id IN (
    Select
      id
    FROM
      person
    Where
      name LIKE '%Annabel%'
      AND address_street_name = 'Franklin Ave'
  );

-- Morty Schapiro
--I heard a gunshot and then saw a man run out.
--He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z".
--Only gold members have those bags. The man got into a car with a plate that included "H42W".
--Annabel Miller
--I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.
Select
  get_fit_now_member.person_id,
  person.name
FROM
  get_fit_now_member
  JOIN get_fit_now_check_in ON get_fit_now_member.id = get_fit_now_check_in.membership_id
  JOIN person ON person.id = get_fit_now_member.person_id
  JOIN drivers_license ON drivers_license.id = person.license_id
Where
  get_fit_now_member.membership_status = 'gold'
  AND get_fit_now_member.id LIKE '48Z%'
  AND get_fit_now_check_in.check_in_date = 20180109
  AND drivers_license.plate_number LIKE '%H42W%';

-- 67318 Jeremy Bowers
Select
  *
FROM
  interview
Where
  person_id = 67318;

INSERT INTO
  solution
VALUES
  (1, 'Jeremy Bowers');
  
-- Congrats, you found the murderer! But wait, there's more... 
--If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. 
--If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. 
--Use this same INSERT statement with your new suspect to check your answer.

SELECT
  value
FROM
  solution;

Select
  *
FROM
  interview
Where
  person_id = 67318 
  -- I was hired by a woman with a lot of money.
  --I don't know her name but I know she's around 5'5" (65") or 5'7" (67").
  --She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.
Select
  drivers_license.id,
  person.name,
  income.annual_income AS income
FROM
  drivers_license
  JOIN person ON person.license_id = drivers_license.id
  JOIN income ON person.ssn = income.ssn
  JOIN facebook_event_checkin ON facebook_event_checkin.person_id = person.id
WHERE
  drivers_license.height BETWEEN 65 AND 67
  AND drivers_license.car_make = 'Tesla'
  AND drivers_license.car_model = 'Model S'
  AND facebook_event_checkin.event_name = 'SQL Symphony Concert'
  AND facebook_event_checkin.date LIKE '%201712%';

INSERT INTO
  solution
VALUES
  (1, 'Miranda Priestly');

SELECT
  value
FROM
  solution;
  
--Congrats, you found the brains behind the murder! 
--Everyone in SQL City hails you as the greatest SQL detective of all time. 
--Time to break out the champagne!

🎉🥳🎈🎊✔
