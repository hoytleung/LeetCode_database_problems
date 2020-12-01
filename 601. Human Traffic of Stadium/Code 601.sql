With Consecutive AS (   
    SELECT S1.id AS S1_id, S1.visit_date S1_visitdate, S1.people AS S1_people, S2.id AS S2_id, S2.visit_date S2_visitdate, S2.people AS S2_people, S3.id AS S3_id, S3.visit_date S3_visitdate, S3.people AS S3_people
    FROM Stadium AS S1, Stadium AS S2, Stadium AS S3
    WHERE S2.id = S1.id +1 AND S3.id = S1.id +2 AND S1.people >=100 AND S2.people >=100 AND S3.people >=100),
        
     S1 AS (
    SELECT S1_id AS id, S1_visitdate AS visit_date, S1_people AS people FROM Consecutive),
    
     S2 AS (
    SELECT S2_id AS id, S2_visitdate AS visit_date, S2_people AS people FROM Consecutive),
    
     S3 AS (            
    SELECT S3_id AS id, S3_visitdate AS visit_date, S3_people AS people FROM Consecutive)
    
    

SELECT * FROM S1
    UNION SELECT * FROM S2
    UNION SELECT * FROM S3
ORDER BY id