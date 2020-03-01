	--WRITE STRORE PROCEDURE TO ACCEPTE EMPLOYEE ID AND RETURN HIS MANAGER ID FROM EMPLYOEE TABLE OF 
	--ADVENTURE WORKS DATABASE

	CREATE PROCEDURE usp_DisplayEmpMag
	(
			@EMPID INT
	)
	AS
	BEGIN
		IF EXISTS(SELECT * FROM HumanResources.Employee WHERE BusinessEntityID=@EMPID)
			BEGIN
			SELECT HRE.OrganizationLevel AS 'MANAGER ID'
			FROM HumanResources.Employee HRE
			RIGHT JOIN HumanResources.Employee  HRE1	
			ON HRE.BusinessEntityID=HRE1.OrganizationLevel
			RIGHT JOIN Person.Person PP
			ON PP.BusinessEntityID=HRE.BusinessEntityID
			WHERE HRE1.BusinessEntityID=@EMPID
		END
		ELSE
			RAISERROR ('PLEASE ENTER VALID DATA',18,0);  
			--PRINT'PLEASE ENTER VALID DATA'
	END
	GO


	EXEC usp_DisplayEmpMag '290'
	GO
-----------------------------------------------------------------------------------------------------------------------------------
	--WRITE STRORE PROCEDURE TO ACCEPT EMPLOYRR ID AND DISPLAY FIRST NAME ,EMPLOYEE LAST NAME,DATE OF
	-- BIRTH,EMAIL ID ,PHONE NUMBER AND TILTLE FROM EMPLYEE TABLE OF ADVENTUREWORKS DATABASE

	ALTER PROCEDURE usp_DisplayDetail
	(
		@EMPID INT
	)
	AS
	BEGIN
	IF EXISTS(SELECT * FROM HumanResources.Employee WHERE BusinessEntityID=@EMPID)
		BEGIN
				SELECT HRE.BusinessEntityID,
					  (PP.FirstName+SPACE(1)+PP.LastName)AS 'NAME',
					   HRE.BirthDate,
					   HRE.JobTitle 
					   FROM HumanResources.Employee HRE
					   INNER JOIN Person.Person PP 
					   ON HRE.BusinessEntityID=PP.BusinessEntityID
					   WHERE HRE.BusinessEntityID=@EMPID
		END
			ELSE
		RAISERROR ('PLEASE ENTER VALID DATA',18,0);  
	END
	GO

----------------------------------------------------------------------------------------------------------------------------------------

	EXEC usp_DisplayDetail NULL
	GO

----------------------------------------------------------------------------------------------------------------------------------------
--	WRITE STRORE PROCEDURE TO ACCEPT DEPARTMENT NAME AND DISPLAY EMPLOYEE NAME ,
--	DATE OF JOINING FOR A PARTICULAR DEPARTMENT DEPARTMENT TABLE OF ADVENTURE WORKS DATABASE

	ALTER PROCEDURE usp_DisplayEmpDeatil
	(
			@DEPARTMENT VARCHAR(100)
	)
	AS
	BEGIN
	if EXISTS (SELECT * FROM HUMANRESOURCES.DEPARTMENT WHERE NAME=@DEPARTMENT)
		BEGIN		
				SELECT PP.FirstName,HREDH.StartDate FROM HumanResources.Department HRD
				INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
				ON HRD.DepartmentID=HREDH.DepartmentID
				INNER JOIN HumanResources.Employee HRE
				ON HRE.BusinessEntityID=HREDH.BusinessEntityID
				INNER JOIN Person.Person PP
				ON PP.BusinessEntityID=HRE.BusinessEntityID
				WHERE HRD.DepartmentID=(
											SELECT DepartmentID 
											FROM HumanResources.Department 
											WHERE Name=@DEPARTMENT
										)
		END
	ELSE
		RAISERROR ('PLEASE ENTER VALID DATA',18,0);  
	END
	GO 

	EXEC usp_DisplayEmpDeatil 'kgf'
	GO

