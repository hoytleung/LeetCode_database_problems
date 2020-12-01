WITH JoinTable AS
        (SELECT D.Name AS Department, E.Name As Employee, E.Salary AS Salary FROM Employee AS E, Department AS D
         WHERE E.DepartmentId = D.Id), 

     HighestSalary AS
        (SELECT Department, MAX(Salary) AS Salary FROM JoinTable
         GROUP BY Department),
         
     SecondHighestSalary AS
        (SELECT JT.Department, MAX(JT.Salary) AS Salary 
         FROM JoinTable AS JT, HighestSalary AS HS 
         WHERE JT.Department = HS.Department AND JT.Salary < HS.Salary
         GROUP BY Department),
         
     ThirdHighestSalary AS
        (SELECT JT.Department, MAX(JT.Salary) AS Salary 
         FROM JoinTable AS JT, SecondHighestSalary AS SHS 
         WHERE JT.Department = SHS.Department AND JT.Salary < SHS.Salary
         GROUP BY Department),
         
     UnionTable AS
        (SELECT * FROM HighestSalary 
            UNION SELECT * FROM SecondHighestSalary
            UNION SELECT * FROM ThirdHighestSalary)
     


Select JT.Department, JT.Employee, JT.Salary FROM JoinTable AS JT, UnionTable AS UT
WHERE JT.Department = UT.Department AND JT.Salary = UT.Salary