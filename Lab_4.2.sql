ALTER VIEW TeamCreaetion AS
SELECT T.tName,T.tCreated
FROM Teams T
WHERE T.tCreated >'01-01-1990';

ALTER VIEW TeamPartners AS
SELECT T.tName,P.Since
FROM Teams T INNER JOIN Is_Partner P ON T.tid=P.tid
WHERE P.Since>'01-01-1975'

ALTER VIEW PartnersandSince AS
SELECT P.PaName,P.PaRevenue,PP.Since
FROM Partners P INNER JOIN Is_Partner PP ON P.Paid=PP.Paid
GROUP BY P.PaName,P.PaRevenue,PP.Since



INSERT INTO Tables(Name)
VALUES ('Owners');

INSERT INTO Tables(Name)
VALUES ('Coaches');

INSERT INTO Tables(Name)
VALUES ('Is_Partner');

INSERT INTO Views(Name)
VALUES ('KoreanPLayes');

INSERT INTO Views(Name)
VALUES ('PlayersAndTeams');

INSERT INTO Views(Name)
VALUES ('PlayersAndTeamsGroupBy');

INSERT INTO Tests(Name)
VALUES ('TestTable1');

INSERT INTO Tests(Name)
VALUES ('TestTable2');

INSERT INTO Tests(Name)
VALUES ('TestTable3');


INSERT INTO TestTables(TestID,TableID,NoOfRows,Position)
VALUES (7,1,1000,1)

INSERT INTO TestTables(TestID,TableID,NoOfRows,Position)
VALUES (7,2,1000,2)

INSERT INTO TestTables(TestID,TableID,NoOfRows,Position)
VALUES (7,3,1000,3)

INSERT INTO TestViews(TestID,ViewID)
VALUES (7,1)

INSERT INTO TestViews(TestID,ViewID)
VALUES (7,2)

INSERT INTO TestViews(TestID,ViewID)
VALUES (7,3)

ALTER PROCEDURE testing
AS
 DECLARE @IDTest INT, @NameTest VARCHAR(50);
 DECLARE @RowCountTest INT = (SELECT COUNT(*) FROM Tests);

 
	 WHILE @RowCountTest > 0 BEGIN
		    SELECT @IDTest=TestID, @NameTest=Name 
		    FROM Tests 
			ORDER BY TestID DESC OFFSET @RowCountTest - 1 ROWS FETCH NEXT 1 ROWS ONLY;
			--PRINT CAST(@IDTest AS Varchar(10))+' '+@NameTest  
			
			DECLARE @IDTable INT, @NoOfRows VARCHAR(50),@TableName VARCHAR(50);
			DECLARE @Position INT=1;
			SET @Position=1;
			DECLARE @RowCountTestAndTables INT = (SELECT COUNT(*) FROM TestTables T WHERE T.TestID=@IDTest);	
			WHILE @RowCountTestAndTables>0 BEGIN
					SELECT @IDTable=TableID, @NoOfRows=NoOfRows 
					FROM TestTables T
					WHERE T.TestID=@IDTest and T.Position=@Position
					--ORDER BY TableID DESC OFFSET @RowCountTestAndTables - 1 ROWS FETCH NEXT 1 ROWS ONLY;

					

					SET @TableName=(
					SELECT TT.Name
					FROM Tables TT
 					WHERE TT.TableID=@IDTable)

					PRINT @TableName

					--IF @TableName='Is_Partner'
					--BEGIN
						DECLARE @deleteTBL AS VARCHAR(MAX);
						SET @deleteTBL = 'DELETE FROM ' + @TableName;

						EXECUTE(@deleteTBL);
					--END
					

				

					--PRINT CAST(@IDTable AS Varchar(10))+' '+CAST(@NoOfRows AS Varchar(10))+' '+CAST(@Position AS Varchar(10))
					SET @Position+=1;
					SET @RowCountTestAndTables -=1;

			END
			
			SET @Position-=1;
			
			DECLARE @ALLStartAt DATETIME;
			SELECT @ALLStartAt=GETDATE()
			DECLARE @Pbool INT;
			SET @Pbool=0;
			DECLARE @Tbool INT;
			SET @Tbool=0;
			DECLARE @IPbool INT;
			SET @IPbool=0
			WHILE @Position>0 BEGIN
					SELECT @IDTable=TableID, @NoOfRows=NoOfRows 
					FROM TestTables T
					WHERE T.TestID=@IDTest and T.Position=@Position
					--ORDER BY TableID DESC OFFSET @RowCountTestAndTables - 1 ROWS FETCH NEXT 1 ROWS ONLY;

					SET @TableName=(
					SELECT TT.Name
					FROM Tables TT
 					WHERE TT.TableID=@IDTable)

					
					--INSERT
					
					
					IF @TableName='Partners'
					BEGIN
						SET @Pbool=1;
						DECLARE @PartnersStartAt DATETIME;
						SELECT @PartnersStartAt=GETDATE()
						DECLARE @PartnerName VARCHAR(30);
						DECLARE @PartnerRevenue INT;
						DECLARe @PartnerID INT=@IDTable;
						/*DECLARE @StartDate AS date;
						DECLARE @EndDate AS date;
						SELECT @StartDate = '01/01/1960',@EndDate   = '12/31/2003';
						
						SELECT @OwnerName =substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ',(abs(checksum(newid())) % 26)+1, 1)
						SELECT @OwnerEmail =substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ',(abs(checksum(newid())) % 26)+1, 1)
						SELECT @OwnerDob=DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, @StartDate, @EndDate)),@StartDate
						*/
						WHILE @NoOfRows>0
						BEGIN
								--PRINT @NoOfRows
								SELECT @PartnerRevenue=FLOOR(RAND()*(50000-1000+1))+1000;
								SELECT @PartnerName =CONVERT(varchar(30),LEFT(REPLACE(NEWID(),'-',''),30))
								BEGIN TRY  
										INSERT INTO Partners(Paid,PaName,PaRevenue)
										VALUES(@NoOfRows,@PartnerName,@PartnerRevenue)
										
								END TRY  
								BEGIN CATCH  
									   SET @NoOfRows += 1;
								END CATCH
								SET @NoOfRows -= 1;
								
						END
						DECLARE @PartnersEndAt DATETIME;
						SELECT @PartnersEndAt=GETDATE()

						--Insert into TestRunTables(TableID,StartAt,EndAt)
						--VALUES(@IDTable,@PartnersStartAt,@PartnersEndAt)
						
					  END
							
					IF @TableName='Teams'
					BEGIN
						SET @Tbool=1;
						DECLARE @TeamsName VARCHAR(30);
						DECLARE @TeamCreated DATE;
						DECLARE @TeamOwner INT;
						DECLARE @TeamLeague INT;
						DECLARE @StartDate AS date;
						DECLARE @EndDate AS date;
						DECLARE @TeamsStartAt DATETIME;
						DECLARe @TeamsID INT=@IDTable;
						SELECT @TeamsStartAt=GETDATE()
						SELECT @StartDate = '01/01/1960',@EndDate   = '12/31/2003';
						WHILE @NoOfRows>0
						BEGIN
								
								--PRINT @NoOfRows
								SELECT @TeamsName =CONVERT(varchar(30),LEFT(REPLACE(NEWID(),'-',''),30))
								SELECT @TeamOwner=FLOOR(RAND()*((SELECT COUNT(*) FROM Owners)-1+1))+1;
								SELECT @TeamLeague=FLOOR(RAND()*((SELECT COUNT(*) FROM Leagues)-1+1))+1;
								SELECT @TeamCreated=DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, @StartDate, @EndDate)),@StartDate)

								BEGIN TRY
										INSERT INTO Teams(tid,tName,oid,lid,tCreated)
										VALUES(@NoOfRows,@TeamsName,@TeamOwner,@TeamLeague,@TeamCreated)
								END TRY  
								BEGIN CATCH  
									   SET @NoOfRows += 1;
								END CATCH
								SET @NoOfRows -= 1;
						END
						DECLARE @TeamsEndAt DATETIME;
						SELECT @TeamsEndAt=GETDATE()
						
						--Insert into TestRunTables(TableID,StartAt,EndAt)
						--VALUES(@IDTable,@TeamsStartAt,@TeamsEndAt)
					  END

					IF @TableName='Is_Partner'
					BEGIN
						SET @IPbool=1;
						DECLARE @PartnerIs_Partner INT;
						DECLARE @TeamIs_Partner INT;
						DECLARE @SinceIs_Partner DATE;
						DECLARe @Is_PartnerID INT=@IDTable;
						
						DECLARE @StartDate2 AS date;
						DECLARE @EndDate2 AS date;
						DECLARE @Is_PartnersStartAt DATETIME;
						SELECT @Is_PartnersStartAt=GETDATE()

						SELECT @StartDate2 = '01/01/1960',@EndDate2   = '12/31/2003';
						WHILE @NoOfRows>0
						BEGIN
								--PRINT @NoOfRows
								SELECT @PartnerIs_Partner=FLOOR(RAND()*((SELECT COUNT(*) FROM Partners)-1+1))+1;
								SELECT @TeamIs_Partner=FLOOR(RAND()*((SELECT COUNT(*) FROM Teams)-1+1))+1;
								SELECT @SinceIs_Partner=DATEADD(DAY, RAND(CHECKSUM(NEWID()))*(1+DATEDIFF(DAY, @StartDate, @EndDate)),@StartDate)

								BEGIN TRY
										INSERT INTO Is_Partner(tid,Paid,Since)
										VALUES(@TeamIs_Partner,@PartnerIs_Partner,@SinceIs_Partner)
								END TRY  
								BEGIN CATCH  
									   SET @NoOfRows += 1;
								END CATCH
								SET @NoOfRows -= 1;
						END
						DECLARE @Is_PartnerEndAt DATETIME;
						SELECT @Is_PartnerEndAt=GETDATE()

						--Insert into TestRunTables(TableID,StartAt,EndAt)
						--VALUES(@IDTable,@Is_PartnersStartAt,@Is_PartnerEndAt)
					  END

					--PRINT CAST(@IDTable AS Varchar(10))+' '+CAST(@NoOfRows AS Varchar(10))+' '+CAST(@Position AS Varchar(10))
					SET @Position-=1;
					

			END
			
			--PRINT CAST(@Position AS VARCHAR(10))
			DECLARE @ViewID INT;
			DEClARE @ViewName VARCHAR(50);
		    DECLARE @RowCountTestAndViews INT = (SELECT COUNT(*) FROM TestViews T WHERE T.TestID=@IDTest);	
			declare @Stored table
					(
						viewid INT,
						startat datetime,
						endat datetime
					)
			DELETE FROM @Stored
			WHILE @RowCountTestAndViews>0 BEGIN
					SELECT @ViewID=ViewID 
					FROM TestViews V
					WHERE V.TestID=@IDTest
					ORDER BY ViewID DESC OFFSET @RowCountTestAndViews - 1 ROWS FETCH NEXT 1 ROWS ONLY;
					

					DECLARE @StartATView DATETIME;
					SELECT @StartATView=GETDATE()
					SET @ViewName= (SELECT VV.Name
					FROM Views VV
					WHERE VV.ViewID=@ViewID)

					DECLARE @runView AS VARCHAR(MAX);
					SET @runView = 'SELECT * FROM ' + @ViewName;

					EXECUTE(@runView);

					DECLARE @EndATView DATETIME;
					SELECT @EndATView=GETDATE()


					insert into @Stored values (@ViewID,@StartATView,@EndATView)

					
					SET @RowCountTestAndViews -= 1;

			END

			DECLARE @ALLEndAt DATETIME;
			SELECT @ALLEndAt=GETDATE()

			Insert into TestRuns(Description,StartAt,EndAt)
			VALUES(@NameTest,@ALLStartAt,@ALLEndAt)

			DECLARE @TRID int;
			SET @TRID=(
			SELECT TestRunID
			FROM TestRuns
			WHERE Description=@NameTest and StartAt=@ALLStartAt)

			IF @Pbool=1 
			BEGIN 
					Insert into TestRunTables(TestRunID,TableID,StartAt,EndAt)
					VALUES(@TRID,@PartnerID,@PartnersStartAt,@PartnersEndAt)
			end

			IF @Tbool=1
			BEGIN
					Insert into TestRunTables(TestRunID,TableID,StartAt,EndAt)
					VALUES(@TRID,@TeamsID,@TeamsStartAt,@TeamsEndAt)
			END

			IF @IPbool=1
			BEGIN
					Insert into TestRunTables(TestRunID,TableID,StartAt,EndAt)
					VALUES(@TRID,@Is_PartnerID,@Is_PartnersStartAt,@Is_PartnerEndAt)
			END

			DECLARE @StATView DATETIME;
			DECLARE @EnATView DATETIME;
			DECLARE @idv INT;
            Declare @idkanymore INT= (SELECT COUNT(*) FROM @Stored);
			While @idkanymore>0 
			BEGIn
					SELECT @idv=viewid,@StartATView=startat,@EnATView=endat
					FROM @Stored
					ORDER BY viewid DESC OFFSET @idkanymore - 1 ROWS FETCH NEXT 1 ROWS ONLY;

					Insert into TestRunViews(TestRunID,ViewID,StartAt,EndAt)
					VALUES(@TRID,@idv,@StartATView,@EnATView)
					SET @idkanymore -= 1;
			END

			SET @RowCountTest -= 1;
	 END
GO


EXEC testing

Select * from Tables
Select * from Views
Select * from Tests
Select * from TestTables
Select * from TestViews


INSERT INTO Tests(Name)
VALUES ('Test2')

DELETE TestTables
WHERE TestID=11 and TableID=1


INSERT INTO TestTables(TestID,TableID,NoOfRows,Position)
VALUES(11,3,8000,1)

INSERT INTO TestTables(TestID,TableID,NoOfRows,Position)
VALUES(11,2,10000,3)

INSERT INTO TestTables(TestID,TableID,NoOfRows,Position)
VALUES(11,2,7000,3)

INSERT INTO TestViews(TestID,ViewID)
VALUES(11,2)

SELECT * FROM TestRunTables
SELECT * FROM TestRuns
SELECT * FROM TestRunViews
Select * from TestTables

UPDATE TestTables
SET Position=2
WHERE TestID=11 and TableID=2

INSERT INTO TestTables(TestID,TableID,NoOfRows,Position)
VALUES (7,1,200,4)

Select * from TeamCreaetion
Select * from TeamPartners
Select * from PartnersandSince


DELETE TestRuns
DELETE TestRunTables
DELETE TestRunViews

SELECT * from Partners
SELECT * from Teams
SELECT * from Is_Partner


UPDATE TestTables
SET Position=3
WHERE TestID=7 and TableID=1

SELECT * FROM Leagues

