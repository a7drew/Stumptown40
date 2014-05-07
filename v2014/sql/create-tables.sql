SET NOCOUNT ON
--USE [Stumptown40DB]
--GO

--
-- TABLES
--

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Race'))
BEGIN
  DROP TABLE [dbo].[Race]
END
GO

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Car'))
BEGIN
  DROP TABLE [dbo].[Car]
END
GO

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'AppSetting'))
BEGIN
  DROP TABLE [dbo].[AppSetting]
END
GO

CREATE TABLE [dbo].[AppSetting]
(
	[AppSettingId] [int]            NOT NULL,
	[SettingName]  [nvarchar](200)  NOT NULL,
	[SettingValue] [nvarchar](200)  NOT NULL
)
GO

CREATE TABLE [dbo].[Car]
(
	[CarId]        [int]           IDENTITY NOT NULL,
	[CarNumber]    [int]                    NOT NULL,
	[DivisionId]   [int]                    NOT NULL,
	[Name]         [nvarchar](200)          NOT NULL,
	[Organization] [nvarchar](200)          NOT NULL,
    [PositionId]   [int]                        NULL,	
	CONSTRAINT [PK_Racer] PRIMARY KEY CLUSTERED ([CarId] ASC)
)
GO

CREATE TABLE [dbo].[Race]
(
  [RaceId]       [int] IDENTITY NOT NULL,
  [DivisionId]   [int]          NOT NULL,
  [CarIdWinner]  [int]          NOT NULL,
  [CarIdLoser]   [int]          NOT NULL,
  CONSTRAINT [PK_Race] PRIMARY KEY CLUSTERED ([RaceId] ASC)
)
GO

--
-- FOREIGN KEY CONSTRAINTS
--

ALTER TABLE [dbo].[Race]  WITH CHECK ADD  CONSTRAINT [FK_Race_CarIdWinner] FOREIGN KEY([CarIdWinner])
REFERENCES [dbo].[Car] ([CarId])
GO
ALTER TABLE [dbo].[Race] CHECK CONSTRAINT [FK_Race_CarIdWinner]
GO

ALTER TABLE [dbo].[Race]  WITH CHECK ADD  CONSTRAINT [FK_Race_CarIdLoser] FOREIGN KEY([CarIdLoser])
REFERENCES [dbo].[Car] ([CarId])
GO
ALTER TABLE [dbo].[Race] CHECK CONSTRAINT [FK_Race_CarIdLoser]
GO

--
-- STORED PROCEDURES
--

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[spGetNextRaceByDivisionId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[spGetNextRaceByDivisionId];
GO

CREATE PROCEDURE [dbo].[spGetNextRaceByDivisionId] 
	@id INT
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @LastCarIdWinner INT;

	DECLARE @NextCar TABLE
		(
			Id         INT IDENTITY,
			CarId      INT
		);

	SELECT TOP 1 @LastCarIdWinner=CarIdWinner
	FROM [dbo].[Race]
	WHERE DivisionId = @id
	ORDER BY RaceId DESC;

	IF @LastCarIdWinner IS NULL
		BEGIN
			SET @LastCarIdWinner = -1;
		END

	INSERT INTO @NextCar
	SELECT TOP 4 [CarId] 
	FROM [dbo].[Car] a
	WHERE [a].[DivisionId] = @id
	AND [a].[CarId] > @LastCarIdWinner
	AND [a].[CarId] NOT IN (SELECT [CarIdLoser] FROM [dbo].[Race])
	ORDER BY [a].[CarId];

	DECLARE @NextCarCount INT;

	SELECT @NextCarCount = COUNT(*) FROM @NextCar;

	IF (@NextCarCount < 4)
		BEGIN
			SET @LastCarIdWinner = -1;

			INSERT INTO @NextCar
			SELECT TOP 4 [CarId] 
			FROM [dbo].[Car] a
			WHERE [a].[DivisionId] = @id
			AND [a].[CarId] > @LastCarIdWinner
			AND [a].[CarId] NOT IN (SELECT [CarIdLoser] FROM [dbo].[Race])
			ORDER BY [a].[CarId];
		END

	SELECT TOP 4 [CarId] FROM @NextCar ORDER BY [Id];

END
GO

--
-- DATA
--

INSERT INTO [dbo].[AppSetting] (AppSettingId, SettingName, SettingValue) VALUES (1,'username','alice');
INSERT INTO [dbo].[AppSetting] (AppSettingId, SettingName, SettingValue) VALUES (2,'password','secret');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (1,1,'Manifest Team','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (2,1,'Greg Schmidt','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (3,1,'Cole Schmidt','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (4,1,'Tyler Bechtel','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (5,1,'David Danner','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (6,1,'HERENOW Creative','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (7,1,'Blu-Jae Marketing','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (8,1,'Hopworks','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (9,1,'33 Books Co.','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (10,1,'Urban Airship Uno','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (11,1,'Urban Airship Dos','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (15,1,'B&amp;B Print Source','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (12,1,'Urban Airship Tres','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (16,1,'James Bechtel','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (13,1,'Urban Airship Cuatro','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (17,1,'Inavero, Inc.','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (14,1,'Urban Airship Cinco','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (18,1,'Mason West','SMITH');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (20,1,'Colin Harvey','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (21,1,'Ryan Smythe','Smythe Design');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (22,1,'Gregory Saunders','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (23,1,'James Stiehl','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (24,1,'Brad Hagstrom','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (25,1,'Dylan Boye','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (26,1,'Sam Sudy','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (27,1,'Kristy Charroin','SPLASH');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (28,1,'Daniel Brunner','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (29,1,'Jen Raynak','Little Star Racing');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (30,1,'David Embree','Athletepath');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (31,1,'Ashley Holmes','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (32,1,'Charrice Finks','Robert Half International');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (33,1,'Ben Kulp','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (34,1,'Matt Ross','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (35,1,'Sergio Teran','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (36,1,'Nick Nakadate','Animation Dynamics, Inc.');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (37,1,'Andrew Hay','Vertigo');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (38,1,'Ben Friedle','Outlier');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (39,1,'Crystal Potter Eins','Figure Plant');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (41,1,'Postano Sales Un','Postano Team');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (40,1,'Crystal Potter Zwei','Figure Plant');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (42,1,'Postano Client Success Deux','Postano Team');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (47,1,'Luis Menchu','Portland Community College');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (43,1,'Postano Marketing Trois','Postano Team');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (48,1,'John','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (44,1,'Postano UX Quatre','Postano Team');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (49,1,'Anton Legoo','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (45,1,'Postano Design Cinq','Postano Team');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (50,1,'Austin Whipple','Scout Books');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (51,1,'François Vigneault','Scout Books');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (52,1,'Johnny Levenson','E-Racers Ltd.');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (53,1,'Gregory Saunders','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (54,1,'Wayne Espinola','USF');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (55,1,'Ian','Pop Art Inc.');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (56,1,'Ben Bertola','Team Bertola');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (57,1,'Darren Cools','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (58,1,'Ryan Massrey','Uncle Wally''s BBQ');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (60,1,'Parker Morris','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (61,1,'Andy Davis','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (62,1,'Casey Harger','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (63,1,'Greg Windell Ichi','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (64,1,'Greg Windell Ni','Poa Cafe');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (67,1,'Leah Davidson','Sheepscot');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (65,1,'Greg Windell San','Poa Cafe');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (68,1,'Carter Stewart','');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (66,1,'Greg Windell Shi','Hank');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (69,1,'David Stewart','Endorphin Apps');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (70,1,'Ben Pringle','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (71,1,'Curt Brown','Curt Brown Renovation');

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (72,1,'Blogfish','Postano');

-- UNLIMITED DIVISION

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (19,2,'Nick Nakadate','BuiltBot');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (46,2,'Kendra','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (59,2,'ITs TOO Windy For a Sombrero', '');
GO