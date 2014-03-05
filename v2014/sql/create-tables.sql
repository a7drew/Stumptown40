SET NOCOUNT ON
USE [Stumptown40]
GO

--
-- TABLES
--

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Car'))
BEGIN
  DROP TABLE [dbo].[Car]
END
GO

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'Race'))
BEGIN
  DROP TABLE [dbo].[Race]
END
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
-- DATA
--

-- standard division

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (1,1,'Dave Selden','Co-Founder!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (2,1,'Howard Freedman','Buckman Elementary');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (3,1,'Mason West','SMITH');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (4,1,'Sam Amis','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (5,1,'Nic Petersen','TROPHIES! / Makelike');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (6,1,'Ben Friedle','Outlier Solutions');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (7,1,'Jed Herzog','Outlier Solutions');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (8,1,'Greg Windell - 1','Hank Designs');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (9,1,'Greg Windell - 2','Hank Designs');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (10,1,'Rocket Windell','Revel in Portland');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (11,1,'Jeremiah Raidt','SMITH');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (12,1,'Steve Jarvis','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (13,1,'James Stiehl','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (14,1,'Michael Dryden','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (15,1,'Brian Garcia','HOT BOX');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (16,1,'Greg Windell - 3','BlackBox Productions');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (17,1,'Chad Jacobsen','Oregon Museum of Science');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (18,1,'Matthew Ross','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (19,1,'Pinball Publishing','Sponsor!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (20,1,'Gaby Jenkins','Sponsor!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (21,1,'David Stewart','Skylark64');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (22,1,'Jen Raynak','Little Star Racing');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (23,1,'Erich Quist','Liveaxle');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (24,1,'Darren Cools','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (25,1,'Evan Wilcox','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (26,1,'Jen Raynak','Little Star Racing');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (27,1,'Nate Fasser','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (28,1,'Keenan Blanchard','Keenan Blanchard Photography');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (29,1,'Evan Wilcox','HERENOW');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (30,1,'Tiffany Jennings','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (31,1,'Nicholas Nakadate','Animation Dynamics, Inc.');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (32,1,'Nate Currie','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (33,1,'Maria Janosko','Maria & Dusty Inc.');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (34,1,'Johnny Levenson','Con-way Freight');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (35,1,'Jerry Blazek','Xerox');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (36,1,'Transport','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (37,1,'Katherine Topaz','Storycode');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (38,1,'Herboth O''Hanlon','Team Vermin');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (39,1,'Luis Menchu','Portland Community College');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (40,1,'Kate O''Neil','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (41,1,'Mari Gamard','Sponsor!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (42,1,'Ryan Legler','Sponsor!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (43,1,'Justin Garrity','Sponsor!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (44,1,'Gregory Saunders','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (45,1,'Stephen R. Topaz', 'Topaz Design (Sponsor)');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (46,1,'Scott Landis','Storycode');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (47,1,'Schoolhouse Supplies','This year''s beneficiary!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (48,1,'Schuyler Silva','Figure Plant');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (49,1,'Ben Birdsall','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (50,1,'Colin Harvey','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (51,1,'Bruce Kehe','Hopworks Urban Brewery');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (52,1,'The New Group','The New Group');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (53,1,'Urban Airship 1','Sponsor!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (54,1,'Urban Airship 2','Sponsor!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (55,1,'Urban Airship 3','Sponsor!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (56,1,'Urban Airship 4','Sponsor!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (57,1,'Urban Airship 5','Sponsor!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (58,1,'Urban Airship 6','Sponsor!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (59,1,'Ben Bertola','Team Bertola');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (60,1,'David Danner','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (61,1,'Greg Schmidt','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (62,1,'Crystal Potter','Figure Plant');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (63,1,'Stevie SwellPath Jr.','SwellPath');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (64,1,'Tad Lowder','');

-- unlimited division

INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (1,2,'Dave Selden','Co-Founder!');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (2,2,'Howard Freedman','Buckman Elementary');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (3,2,'Mason West','SMITH');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (4,2,'Sam Amis','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (5,2,'Nic Petersen','TROPHIES! / Makelike');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (6,2,'Ben Friedle','Outlier Solutions');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (7,2,'Jed Herzog','Outlier Solutions');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (8,2,'Greg Windell - 1','Hank Designs');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (9,2,'Greg Windell - 2','Hank Designs');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (10,2,'Rocket Windell','Revel in Portland');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (11,2,'Jeremiah Raidt','SMITH');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (12,2,'Steve Jarvis','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (13,2,'James Stiehl','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (14,2,'Michael Dryden','');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (15,2,'Brian Garcia','HOT BOX');
INSERT INTO [dbo].[Car] (CarNumber, DivisionId, Name, Organization) VALUES (16,2,'Greg Windell - 3','BlackBox Productions');
GO