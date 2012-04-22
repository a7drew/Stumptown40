SET NOCOUNT ON
USE [Stumptown40]
GO

--
-- TABLES
--

CREATE TABLE [dbo].[Racer]
(
	[RacerId]      [int] IDENTITY(1,1) NOT NULL,
	[Name]         [nvarchar](200)     NOT NULL,
	[Organization] [nvarchar](200)     NOT NULL,
	[FaceUrl]      [nvarchar](200)         NULL,
	[CarUrl]       [nvarchar](200)         NULL,
	CONSTRAINT [PK_Racer] PRIMARY KEY CLUSTERED ([RacerId] ASC)
)
GO

CREATE TABLE [dbo].[Bracket]
(
  [BracketId]   [int] IDENTITY(1,1) NOT NULL,
  [Name]        [nvarchar](100)     NOT NULL,
  CONSTRAINT [PK_Bracket] PRIMARY KEY CLUSTERED ([BracketId] ASC)
)
GO

CREATE TABLE [dbo].[Round]
(
  [RoundId]     [int] IDENTITY(1,1) NOT NULL,
  [BracketId]   [int]               NOT NULL,
  [RoundNumber] [int]               NOT NULL,
  CONSTRAINT [PK_Round] PRIMARY KEY CLUSTERED ([RoundId] ASC)
)
GO

CREATE TABLE [dbo].[Match]
(
  [MatchId]        [int] IDENTITY(1,1) NOT NULL,
  [RoundId]        [int]               NOT NULL,
  [Cluster]        [int]               NOT NULL,
  [RaceNumber]     [int]               NOT NULL,
  [Racer1Id]       [int]                   NULL,
  [Racer2Id]       [int]                   NULL,
  [WinningRacerId] [int]                   NULL,
  [NextMatchId]    [int]                   NULL,
  CONSTRAINT [PK_Match] PRIMARY KEY CLUSTERED ([MatchId] ASC)
)
GO

--
-- FOREIGN KEY CONSTRAINTS
--

ALTER TABLE [dbo].[Round]  WITH CHECK ADD  CONSTRAINT [FK_Round_BracketId] FOREIGN KEY([BracketId])
REFERENCES [dbo].[Bracket] ([BracketId])
GO
ALTER TABLE [dbo].[Round] CHECK CONSTRAINT [FK_Round_BracketId]
GO

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

INSERT INTO [dbo].[Bracket] (Name) VALUES ('#winning');
INSERT INTO [dbo].[Bracket] (Name) VALUES ('#drinking');
GO

INSERT INTO [dbo].[Round] (BracketId, RoundNumber) VALUES (1, 1);
INSERT INTO [dbo].[Round] (BracketId, RoundNumber) VALUES (1, 2);
INSERT INTO [dbo].[Round] (BracketId, RoundNumber) VALUES (1, 3);
INSERT INTO [dbo].[Round] (BracketId, RoundNumber) VALUES (1, 4);
INSERT INTO [dbo].[Round] (BracketId, RoundNumber) VALUES (1, 5);
INSERT INTO [dbo].[Round] (BracketId, RoundNumber) VALUES (1, 6);
INSERT INTO [dbo].[Round] (BracketId, RoundNumber) VALUES (1, 7);

INSERT INTO [dbo].[Round] (BracketId, RoundNumber) VALUES (2, 1);
INSERT INTO [dbo].[Round] (BracketId, RoundNumber) VALUES (2, 2);
INSERT INTO [dbo].[Round] (BracketId, RoundNumber) VALUES (2, 3);
INSERT INTO [dbo].[Round] (BracketId, RoundNumber) VALUES (2, 4);
INSERT INTO [dbo].[Round] (BracketId, RoundNumber) VALUES (2, 5);
INSERT INTO [dbo].[Round] (BracketId, RoundNumber) VALUES (2, 6);
GO

INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 1, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 1, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 1, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 1, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 2, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 2, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 2, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 2, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 3, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 3, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 3, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 3, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 4, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 4, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 4, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (1, 4, 4);
GO

INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 1, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 1, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 1, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 1, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 1, 5);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 1, 6);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 1, 7);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 1, 8);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 2, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 2, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 2, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 2, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 2, 5);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 2, 6);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 2, 7);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 2, 8);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 3, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 3, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 3, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 3, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 3, 5);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 3, 6);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 3, 7);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 3, 8);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 4, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 4, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 4, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 4, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 4, 5);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 4, 6);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 4, 7);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (2, 4, 8);
GO

INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 1, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 1, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 1, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 1, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 2, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 2, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 2, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 2, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 3, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 3, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 3, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 3, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 4, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 4, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 4, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (3, 4, 4);
GO

INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (4, 1, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (4, 1, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (4, 2, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (4, 2, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (4, 3, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (4, 3, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (4, 4, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (4, 4, 2);
GO

INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (5, 1, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (5, 2, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (5, 3, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (5, 4, 1);
GO

INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (6, 1, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (6, 1, 2);
GO

INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (7, 1, 1);
GO

INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (8, 1, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (8, 1, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (8, 1, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (8, 1, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (8, 2, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (8, 2, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (8, 2, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (8, 2, 4);
GO

INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 1, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 1, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 1, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 1, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 1, 5);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 1, 6);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 1, 7);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 1, 8);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 2, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 2, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 2, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 2, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 2, 5);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 2, 6);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 2, 7);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (9, 2, 8);
GO

INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (10, 1, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (10, 1, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (10, 1, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (10, 1, 4);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (10, 2, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (10, 2, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (10, 2, 3);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (10, 2, 4);
GO

INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (11, 1, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (11, 1, 2);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (11, 2, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (11, 2, 2);
GO

INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (12, 1, 1);
INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (12, 1, 2);
GO

INSERT INTO [dbo].[Match] (RoundId, Cluster, RaceNumber) VALUES (13, 1, 1);
GO

INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Joe Mildenberger', 'Joe Mildenberger');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Mason West', 'Ascentium');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Allison Thompson', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Yvonne Perez Emerson', 'WeMake');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Yvonne Perez Emerson', 'Creativegirl');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Michael Dryden', 'Nike');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Del Olds', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('John Skelton', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Ed Matthews', 'Ed Matthews');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Johnny Levenson', 'John Levenson Design');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Ryan Smythe', 'Smythe Design');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Evan Wilcox', 'Evan Wilcox');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('HERENOW', 'HERENOW');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Emily Passmore', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Jamie Jeffers', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Simon McDowell', 'Mountain Shop/Castle Boardshop');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Nate Currie', 'Nate Currie');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('David Frey', 'Webtrends Design Lab');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Robin Balmer', 'Webtrends Design Lab');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('David Stewart', 'Webtrends Design Lab');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Ryan Parr', 'Webtrends Design Lab');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Rob Derstadt', 'Rob Derstadt');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('AIGA Portland', 'AIGA Portland');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Erik Ratcliffe', 'Erik Ratcliffe');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Timurx', 'Timurx');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Jen Raynak', 'Little Star Cars');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Brad Hagstrom', 'Brad Hagstrom');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Duane Casey', 'King/Casey Motor Sports');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Steven Osborn', 'Urban Airship');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Mark Kellar', 'Mark Kellar');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Anton Legoo', 'Anton Legoo');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Charrice Finks', 'Charrice Finks');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Maria & Nikole', 'Sockeye');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Patrick Holly', 'Get Crisp');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Kris Jaksic', 'Kris Jaksic');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('DanO', 'Splash Worldwide');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Jason Keisling', 'www.jasonkeisling.com');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Mike Wellins', 'The Freakybuttrue Peculiarium');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Brandon Schoessler', 'Transport');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Jeremy Knudson', 'Jeremy Knudson');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Mark Lewis', 'Mark Lewis');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Tim May', 'Tim May');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Urban Airship One', 'Urban Airship');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Urban Airship Two', 'Urban Airship');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Urban Airship Three', 'Urban Airship');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Nick Fedoroff', 'Webtrends');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Blu (aka "The Winner")', 'Coordinate Media');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Bryant Jaksic', 'Bryant Jaksic');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Ben Friedle', 'Outlier Solutions');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Evan Osherow', 'Webtrends');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Fabrice Tatieze', 'Webtrends');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Julie Sowell', 'Webtrends');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Sheli Bryan', 'Buckman');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Zach Vestal', 'Buckman');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Five', 'Athletepath');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('George Vakoutis', 'TheNewGroup');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Nick Nakadate', 'Animation Dynamics, Inc.');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Sho Ito', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Keenan Blanchard', 'Keenan Blanchard Photography');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Willamette Week', 'Willamette Week');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Steve Jarvis', 'Steve Jarvis');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Dirk Frewing', 'Dirk Frewing');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Kelley Roy and Team ADX One', 'ADX Portland');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Kelley Roy and Team ADX Two', 'ADX Portland');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Kelley Roy and Team ADX Three', 'ADX Portland');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Seth Cameron Short', 'Animation Dynamics Inc (ADi)');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Nic Petersen', 'Makelike (ADi)');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Eric Graham-Adams Herboth', 'Equippe');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Bruce Kehe', 'Hopworks');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Rocket', 'Revel In Portland');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Andy Hugelier', 'Subtext');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Stephen Leineweber', 'Pop Art Inc.');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Mark Ulanowicz', 'Mark Ulanowicz');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Birdhat', 'Birdhat');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Mark Stein', 'Mark Stein Photography');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Lorien Steele', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Ezra Cimino-Hurt', 'Case of Bass');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Doug Chamblin', 'Doug Chamblin Furniture Maker');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Derek Keevil', 'The Hat Sharpener');
INSERT INTO [dbo].[Racer] (Name, Organization) VALUES ('Matthew Ross', 'RosStars');
GO
