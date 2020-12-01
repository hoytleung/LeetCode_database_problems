WITH Client AS (
    SELECT * FROM Users WHERE Role = 'client'),
     
     Driver AS (
    SELECT * FROM Users WHERE Role = 'driver'),
    
     Structured_Trips AS (
    SELECT T.Client_Id, C.Banned AS Banned_1, T.Driver_Id, D.Banned AS Banned_2, T.Status, T.Request_at
    FROM Trips AS T, Client AS C, Driver AS D
    WHERE T.Client_Id = C.Users_Id AND T.Driver_Id = D.Users_Id AND T.Request_at BETWEEN '2013-10-01' AND '2013-10-03'), 
    
     Total_Trips AS (
    SELECT Request_at AS Day, COUNT(*) AS Total FROM Structured_Trips
    WHERE Banned_1 = 'No' AND Banned_2 = 'No'
    GROUP BY Request_at),
    
     Cancelled_Trips AS (
    SELECT Request_at AS Day, COUNT(*) AS Cancel FROM Structured_Trips
    WHERE Banned_1 = 'No' AND Banned_2 = 'No' AND NOT Status = 'completed'
    GROUP BY Request_at)



SELECT TT.Day, IF(CT.Cancel/TT.Total IS NULL, 0.00, ROUND(CT.Cancel/TT.Total,2)) AS "Cancellation Rate"
FROM Total_Trips AS TT LEFT OUTER JOIN Cancelled_Trips AS CT 
ON TT.Day = CT.Day