/****** Script for SelectTopNRows command from SSMS  ******/
USE TSQLV4
CREATE TABLE HR.ZombieCert
(CertID INT IDENTITY(1,1) PRIMARY KEY,
 empid INT FOREIGN KEY REFERENCES HR.Employees(empid),
 CertDate datetime,
 CertExpiration datetime,
 Training_Hours INT, 
)

ALTER TABLE HR.Employees
ADD CertID INT FOREIGN KEY REFERENCES HR.ZombieCert(CertID)

INSERT INTO HR.ZombieCert(empid)
SELECT empid FROM TSQLV4.HR.Employees

UPDATE HR.ZombieCert SET CertDate = GETDATE(), 
	CertExpiration = DATEADD(YYYY,0002,GETDATE()), Training_Hours = 0
	WHERE empid IN (1,2,3,4,5,6,7,8,9)

UPDATE HR.ZombieCert 
SET Training_Hours =
CASE
	WHEN empid = 1 THEN 90
	WHEN empid = 2 THEN 70
	WHEN empid = 3 THEN 40
	WHEN empid = 4 THEN 20
	WHEN empid = 5 THEN 10
	WHEN empid = 6 THEN 95
	WHEN empid = 7 THEN 50
	WHEN empid = 8 THEN 35
	WHEN empid = 9 THEN 35
END

INSERT INTO TSQLV4.HR.Employees(CertID)
SELECT CertID FROM TSQLV4.HR.ZombieCert

SELECT * FROM HR.ZombieCert
SELECT * FROM HR.Employees

