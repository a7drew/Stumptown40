SET NOCOUNT ON
USE [Stumptown40]
GO

--
-- TABLES
--

IF (NOT EXISTS (SELECT *
                FROM INFORMATION_SCHEMA.TABLES 
                WHERE TABLE_SCHEMA = 'dbo' 
                AND  TABLE_NAME = 'MyConfig'))
BEGIN
	CREATE TABLE [dbo].[MyConfig]
	(
		[MyConfigId] [int]           NOT NULL,
		[MyKey]      [nvarchar](200) NOT NULL,
		[MyValue]    [nvarchar](200) NOT NULL,	
		CONSTRAINT [PK_MyConfig] PRIMARY KEY CLUSTERED ([MyConfigId] ASC)
	)
END
GO

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Match'))
BEGIN
  DROP TABLE [dbo].[Match]
END
GO

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Round'))
BEGIN
  DROP TABLE [dbo].[Round]
END
GO

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Racer'))
BEGIN
  DROP TABLE [dbo].[Racer]
END
GO

CREATE TABLE [dbo].[Racer]
(
	[RacerId]      [int]           IDENTITY NOT NULL,
	[StartSlot]    [int]                    NOT NULL DEFAULT(0),
	[Name]         [nvarchar](200)          NOT NULL,
	[Organization] [nvarchar](200)          NOT NULL,
	[FaceUrl]      [nvarchar](200)          NULL,
	[CarUrl]       [nvarchar](200)          NULL,
	CONSTRAINT [PK_Racer] PRIMARY KEY CLUSTERED ([RacerId] ASC)
)
GO

CREATE TABLE [dbo].[Round]
(
  [RoundId] [int] NOT NULL,
  CONSTRAINT [PK_Round] PRIMARY KEY CLUSTERED ([RoundId] ASC)
)
GO

CREATE TABLE [dbo].[Match]
(
  [MatchId]              [int]               NOT NULL,
  [RoundId]              [int]               NOT NULL,
  [RaceNumber]           [int]               NOT NULL,
  [Racer1Id]             [int]                   NULL,
  [Racer2Id]             [int]                   NULL,
  [WinningRacerId]       [int]                   NULL,
  [NextWinningMatchId]   [int]                   NULL,
  [NextWinningMatchSlot] [int]                   NULL,
  [Modified]             [datetime]              NULL,
  CONSTRAINT [PK_Match] PRIMARY KEY CLUSTERED ([MatchId] ASC)
)
GO

--
-- FOREIGN KEY CONSTRAINTS
--

ALTER TABLE [dbo].[Match]  WITH CHECK ADD  CONSTRAINT [FK_Match_RoundId] FOREIGN KEY([RoundId])
REFERENCES [dbo].[Round] ([RoundId])
GO
ALTER TABLE [dbo].[Match] CHECK CONSTRAINT [FK_Match_RoundId]
GO

ALTER TABLE [dbo].[Match]  WITH CHECK ADD  CONSTRAINT [FK_Match_Racer1Id] FOREIGN KEY([Racer1Id])
REFERENCES [dbo].[Racer] ([RacerId])
GO
ALTER TABLE [dbo].[Match] CHECK CONSTRAINT [FK_Match_Racer1Id]
GO

ALTER TABLE [dbo].[Match]  WITH CHECK ADD  CONSTRAINT [FK_Match_Racer2Id] FOREIGN KEY([Racer2Id])
REFERENCES [dbo].[Racer] ([RacerId])
GO
ALTER TABLE [dbo].[Match] CHECK CONSTRAINT [FK_Match_Racer2Id]
GO

ALTER TABLE [dbo].[Match]  WITH CHECK ADD  CONSTRAINT [FK_Match_WinningRacerId] FOREIGN KEY([WinningRacerId])
REFERENCES [dbo].[Racer] ([RacerId])
GO
ALTER TABLE [dbo].[Match] CHECK CONSTRAINT [FK_Match_WinningRacerId]
GO

--
-- DATA
--

INSERT INTO [dbo].[Round] (RoundId) VALUES (1);
INSERT INTO [dbo].[Round] (RoundId) VALUES (2);
INSERT INTO [dbo].[Round] (RoundId) VALUES (3);
INSERT INTO [dbo].[Round] (RoundId) VALUES (4);
INSERT INTO [dbo].[Round] (RoundId) VALUES (5);
INSERT INTO [dbo].[Round] (RoundId) VALUES (6);
INSERT INTO [dbo].[Round] (RoundId) VALUES (7);

GO

INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (1, 1, 1, 37, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (2, 1, 2, 38, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (3, 1, 3, 38, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (4, 1, 4, 39, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (5, 1, 5, 40, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (6, 1, 6, 41, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (7, 1, 7, 42, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (8, 1, 8, 43, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (9, 1, 9, 44, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (10, 1, 10, 45, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (11, 1, 11, 46, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (12, 1, 12, 46, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (13, 1, 13, 47, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (14, 1, 14, 48, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (15, 1, 15, 49, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (16, 1, 16, 50, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (17, 1, 17, 51, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (18, 1, 18, 52, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (19, 1, 19, 53, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (20, 1, 20, 54, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (21, 1, 21, 54, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (22, 1, 22, 55, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (23, 1, 23, 56, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (24, 1, 24, 57, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (25, 1, 25, 58, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (26, 1, 26, 59, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (27, 1, 27, 60, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (28, 1, 28, 61, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (29, 1, 29, 62, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (30, 1, 30, 62, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (31, 1, 31, 63, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (32, 1, 32, 64, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (33, 1, 33, 65, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (34, 1, 34, 66, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (35, 1, 35, 67, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (36, 1, 36, 68, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (37, 2, 1, 69, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (38, 2, 2, 69, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (39, 2, 3, 70, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (40, 2, 4, 70, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (41, 2, 5, 71, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (42, 2, 6, 71, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (43, 2, 7, 72, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (44, 2, 8, 72, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (45, 2, 9, 73, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (46, 2, 10, 73, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (47, 2, 11, 74, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (48, 2, 12, 74, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (49, 2, 13, 75, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (50, 2, 14, 75, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (51, 2, 15, 76, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (52, 2, 16, 76, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (53, 2, 17, 77, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (54, 2, 18, 77, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (55, 2, 19, 78, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (56, 2, 20, 78, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (57, 2, 21, 79, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (58, 2, 22, 79, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (59, 2, 23, 80, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (60, 2, 24, 80, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (61, 2, 25, 81, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (62, 2, 26, 81, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (63, 2, 27, 82, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (64, 2, 28, 82, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (65, 2, 29, 83, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (66, 2, 30, 83, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (67, 2, 31, 84, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (68, 2, 32, 84, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (69, 3, 1, 85, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (70, 3, 2, 85, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (71, 3, 3, 86, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (72, 3, 4, 86, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (73, 3, 5, 87, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (74, 3, 6, 87, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (75, 3, 7, 88, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (76, 3, 8, 88, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (77, 3, 9, 89, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (78, 3, 10, 89, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (79, 3, 11, 90, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (80, 3, 12, 90, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (81, 3, 13, 91, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (82, 3, 14, 91, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (83, 3, 15, 92, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (84, 3, 16, 92, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (85, 4, 1, 93, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (86, 4, 2, 93, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (87, 4, 3, 94, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (88, 4, 4, 94, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (89, 4, 5, 95, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (90, 4, 6, 95, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (91, 4, 7, 96, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (92, 4, 8, 96, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (93, 5, 1, 97, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (94, 5, 2, 97, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (95, 5, 3, 98, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (96, 5, 4, 98, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (97, 6, 1, 99, 1);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (98, 6, 2, 99, 2);
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot]) VALUES (99, 7, 1, 0, 0);

GO

INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (1,'Dave Selden','Co-Founder!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (2,'Howard Freedman','Buckman Elementary');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (3,'Mason West','SMITH');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (4,'Sam Amis','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (5,'Nic Petersen','TROPHIES! / Makelike');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (6,'Ben Friedle','Outlier Solutions');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (7,'Jed Herzog','Outlier Solutions');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (8,'Greg Windell - 1','Hank Designs');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (9,'Greg Windell - 2','Hank Designs');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (10,'Rocket Windell','Revel in Portland');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (11,'Jeremiah Raidt','SMITH');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (12,'Steve Jarvis','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (13,'James Stiehl','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (14,'Michael Dryden','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (15,'Brian Garcia','HOT BOX');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (16,'Greg Windell - 3','BlackBox Productions');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (17,'Chad Jacobsen','Oregon Museum of Science');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (18,'Matthew Ross','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (19,'Pinball Publishing','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (20,'Gaby Jenkins','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (21,'David Stewart','Skylark64');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (22,'Jen Raynak','Little Star Racing');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (23,'Erich Quist','Liveaxle');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (24,'Darren Cools','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (25,'Evan Wilcox','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (26,'Jen Raynak','Little Star Racing');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (27,'Nate Fasser','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (28,'Keenan Blanchard','Keenan Blanchard Photography');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (29,'Evan Wilcox','HERENOW');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (30,'Tiffany Jennings','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (31,'Nicholas Nakadate','Animation Dynamics, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (32,'Nate Currie','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (33,'Maria Janosko','Maria & Dusty Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (34,'Johnny Levenson','Con-way Freight');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (35,'Jerry Blazek','Xerox');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (36,'Transport','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (37,'Katherine Topaz','Storycode');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (38,'Herboth O''Hanlon','Team Vermin');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (39,'Luis Menchu','Portland Community College');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (40,'Kate O''Neil','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (41,'Mari Gamard','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (42,'Ryan Legler','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (43,'Justin Garrity','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (44,'Gregory Saunders','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (45,'Stephen R. Topaz', 'Topaz Design (Sponsor)');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (46,'Scott Landis','Storycode');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (47,'Schoolhouse Supplies','This year''s beneficiary!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (48,'Schuyler Silva','Figure Plant');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (49,'Ben Birdsall','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (50,'Colin Harvey','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (51,'Bruce Kehe','Hopworks Urban Brewery');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (52,'The New Group','The New Group');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (53,'Urban Airship 1','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (54,'Urban Airship 2','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (55,'Urban Airship 3','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (56,'Urban Airship 4','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (57,'Urban Airship 5','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (58,'Urban Airship 6','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (59,'Ben Bertola','Team Bertola');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (60,'David Danner','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (61,'Greg Schmidt','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (62,'Crystal Potter','Figure Plant');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (63,'Stevie SwellPath Jr.','SwellPath');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (64,'Tad Lowder','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (65,'Steve','Pop Art');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (66,'52 Limited - 1','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (67,'52 Limited - 2','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (68,'52 Limited - 3','Sponsor!');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (69,'Ian Kennelly','Pop Art Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (70,'Rick Koe','Tigerlogic');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (71,'Peter Koe','Tigerlogic');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (72,'Anthony Stock','Microchip Technology, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (73,'Jon, Stevesies, Brewer & Garber','Fire it Up');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (74,'Eric Reigert','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (75,'Kyle Ackerman','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (76,'Sho, Yoore, Alex & Megan','Alex Harry & Associates');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (77,'Carter Stewart','Stewart Family');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (78,'Leland Hyer','Search Logic Media');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (79,'Megin Diem','Postano');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (80,'Kendra Freeman','');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (81,'Brian cheek','Postano');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (82, 'Kim Grinfeder', 'ServerGrove');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (83, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (84, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (85, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (86, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (87, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (88, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (89, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (90, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (91, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (92, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (93, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (94, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (95, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (96, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (97, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (98, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (99, 'No Show', '');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (100, 'No Show', '');

GO