SET NOCOUNT ON
USE [Stumptown40]
GO

--
-- TABLES
--

CREATE TABLE [dbo].[Racer]
(
	[RacerId]      [int] IDENTITY(1,1) NOT NULL,
	[StartSlot]    [int]               NOT NULL DEFAULT(0),
	[Name]         [nvarchar](200)     NOT NULL,
	[Organization] [nvarchar](200)     NOT NULL,
	[FaceUrl]      [nvarchar](200)         NULL,
	[CarUrl]       [nvarchar](200)         NULL,
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

INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (1, 1, 1, 37, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (2, 1, 2, 38, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (3, 1, 3, 38, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (4, 1, 4, 39, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (5, 1, 5, 40, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (6, 1, 6, 41, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (7, 1, 7, 42, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (8, 1, 8, 43, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (9, 1, 9, 44, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (10, 1, 10, 45, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (11, 1, 11, 46, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (12, 1, 12, 46, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (13, 1, 13, 47, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (14, 1, 14, 48, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (15, 1, 15, 49, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (16, 1, 16, 50, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (17, 1, 17, 51, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (18, 1, 18, 52, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (19, 1, 19, 53, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (20, 1, 20, 54, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (21, 1, 21, 54, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (22, 1, 22, 55, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (23, 1, 23, 56, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (24, 1, 24, 57, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (25, 1, 25, 58, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (26, 1, 26, 59, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (27, 1, 27, 60, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (28, 1, 28, 61, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (29, 1, 29, 62, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (30, 1, 30, 62, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (31, 1, 31, 63, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (32, 1, 32, 64, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (33, 1, 33, 65, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (34, 1, 34, 66, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (35, 1, 35, 67, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (36, 1, 36, 68, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (37, 2, 1, 69, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (38, 2, 2, 69, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (39, 2, 3, 70, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (40, 2, 4, 70, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (41, 2, 5, 71, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (42, 2, 6, 71, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (43, 2, 7, 72, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (44, 2, 8, 72, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (45, 2, 9, 73, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (46, 2, 10, 73, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (47, 2, 11, 74, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (48, 2, 12, 74, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (49, 2, 13, 75, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (50, 2, 14, 75, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (51, 2, 15, 76, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (52, 2, 16, 76, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (53, 2, 17, 77, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (54, 2, 18, 77, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (55, 2, 19, 78, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (56, 2, 20, 78, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (57, 2, 21, 79, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (58, 2, 22, 79, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (59, 2, 23, 80, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (60, 2, 24, 80, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (61, 2, 25, 81, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (62, 2, 26, 81, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (63, 2, 27, 82, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (64, 2, 28, 82, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (65, 2, 29, 83, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (66, 2, 30, 83, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (67, 2, 31, 84, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (68, 2, 32, 84, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (69, 3, 1, 85, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (70, 3, 2, 85, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (71, 3, 3, 86, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (72, 3, 4, 86, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (73, 3, 5, 87, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (74, 3, 6, 87, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (75, 3, 7, 88, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (76, 3, 8, 88, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (77, 3, 9, 89, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (78, 3, 10, 89, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (79, 3, 11, 90, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (80, 3, 12, 90, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (81, 3, 13, 91, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (82, 3, 14, 91, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (83, 3, 15, 92, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (84, 3, 16, 92, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (85, 4, 1, 93, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (86, 4, 2, 93, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (87, 4, 3, 94, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (88, 4, 4, 94, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (89, 4, 5, 95, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (90, 4, 6, 95, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (91, 4, 7, 96, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (92, 4, 8, 96, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (93, 5, 1, 97, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (94, 5, 2, 97, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (95, 5, 3, 98, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (96, 5, 4, 98, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (97, 6, 1, 99, 1, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (98, 6, 2, 99, 2, GETDATE());
INSERT INTO [dbo].[Match] ([MatchId], [RoundId], [RaceNumber], [NextWinningMatchId], [NextWinningMatchSlot], [Modified]) VALUES (99, 7, 1, 0, 0, GETDATE());

GO

INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (1, 'Joe Mildenberger', 'Joe Mildenberger');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (2, 'Mason West', 'Ascentium');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (3, 'Allison Thompson', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (4, 'Yvonne Perez Emerson', 'WeMake');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (5, 'Yvonne Perez Emerson', 'Creativegirl');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (6, 'Michael Dryden', 'Nike');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (7, 'Del Olds', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (8, 'John Skelton', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (9, 'Ed Matthews', 'Ed Matthews');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (10, 'Johnny Levenson', 'John Levenson Design');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (11, 'Ryan Smythe', 'Smythe Design');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (12, 'Evan Wilcox', 'Evan Wilcox');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (13, 'HERENOW', 'HERENOW');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (14, 'Emily Passmore', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (15, 'Jamie Jeffers', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (16, 'Simon McDowell', 'Mountain Shop/Castle Boardshop');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (17, 'Nate Currie', 'Nate Currie');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (18, 'Nick Fedoroff', 'Webtrends');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (19, 'Robin Balmer', 'Webtrends Design Lab');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (20, 'Kelley Roy and Team ADX Three', 'ADX Portland');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (21, 'Ryan Parr', 'Webtrends Design Lab');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (22, 'Rob Derstadt', 'Rob Derstadt');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (23, 'AIGA Portland', 'AIGA Portland');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (24, 'Erik Ratcliffe', 'Erik Ratcliffe');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (25, 'Timurx', 'Timurx');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (26, 'Jen Raynak', 'Little Star Cars');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (27, 'Brad Hagstrom', 'Brad Hagstrom');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (28, 'Duane Casey', 'King/Casey Motor Sports');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (29, 'Steven Osborn', 'Urban Airship');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (30, 'Mark Kellar', 'Mark Kellar');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (31, 'Anton Legoo', 'Anton Legoo');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (32, 'Charrice Finks', 'Charrice Finks');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (33, 'Maria & Nikole', 'Sockeye');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (34, 'Patrick Holly', 'Get Crisp');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (35, 'Kris Jaksic', 'Kris Jaksic');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (36, 'DanO', 'Splash Worldwide');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (37, 'Jason Keisling', 'www.jasonkeisling.com');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (38, 'Mike Wellins', 'The Freakybuttrue Peculiarium');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (39, 'Brandon Schoessler', 'Transport');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (40, 'Jeremy Knudson', 'Jeremy Knudson');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (41, 'Mark Lewis', 'Mark Lewis');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (42, 'Tim May', 'Tim May');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (43, 'Urban Airship One', 'Urban Airship');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (44, 'Urban Airship Two', 'Urban Airship');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (45, 'Urban Airship Three', 'Urban Airship');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (46, 'David Frey', 'Webtrends Design Lab');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (47, 'Pinball One', 'Pinball One');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (48, 'Bryant Jaksic', 'Bryant Jaksic');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (49, 'Ben Friedle', 'Outlier Solutions');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (50, 'Evan Osherow', 'Webtrends');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (51, 'Fabrice Tatieze', 'Webtrends');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (52, 'Julie Sowell', 'Webtrends');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (53, 'Sheli Bryan', 'Buckman');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (54, 'Zach Vestal', 'Buckman');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (55, 'Five', 'Athletepath');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (56, 'George Vakoutis', 'TheNewGroup');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (57, 'Nick Nakadate', 'Animation Dynamics, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (58, 'Sho Ito', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (59, 'Keenan Blanchard', 'Keenan Blanchard Photography');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (60, 'Willamette Week', 'Willamette Week');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (61, 'Steve Jarvis', 'Steve Jarvis');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (62, 'Dirk Frewing', 'Dirk Frewing');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (63, 'Kelley Roy and Team ADX One', 'ADX Portland');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (64, 'David Stewart', 'Webtrends Design Lab');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (65, 'Kelley Roy and Team ADX Two', 'ADX Portland');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (66, 'Seth Cameron Short', 'Animation Dynamics Inc (ADi)');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (67, 'Nic Petersen', 'Makelike (ADi)');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (68, 'Eric Graham-Adams Herboth', 'Equippe');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (69, 'Bruce Kehe', 'Hopworks');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (70, 'Rocket', 'Revel In Portland');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (71, 'Andy Hugelier', 'Subtext');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (72, 'Stephen Leineweber', 'Pop Art Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (73, 'Mark Ulanowicz', 'Mark Ulanowicz');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (74, 'Birdhat', 'Birdhat');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (75, 'Mark Stein', 'Mark Stein Photography');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (76, 'Lorien Steele', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (77, 'Ezra Cimino-Hurt', 'Case of Bass');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (78, 'Doug Chamblin', 'Doug Chamblin Furniture Maker');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (79, 'Derek Keevil', 'The Hat Sharpener');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (80, 'Alice Brown80', 'RosStars80');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (81, 'Alice Brown81', 'RosStars81');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (82, 'Alice Brown82', 'RosStars82');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (83, 'Alice Brown83', 'RosStars83');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (84, 'Alice Brown84', 'RosStars84');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (85, 'Alice Brown85', 'RosStars85');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (86, 'Alice Brown86', 'RosStars86');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (87, 'Alice Brown87', 'RosStars87');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (88, 'Alice Brown88', 'RosStars88');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (89, 'Alice Brown89', 'RosStars89');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (90, 'Alice Brown90', 'RosStars90');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (91, 'Alice Brown91', 'RosStars91');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (92, 'Alice Brown92', 'RosStars92');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (93, 'Alice Brown93', 'RosStars93');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (94, 'Alice Brown94', 'RosStars94');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (95, 'Alice Brown95', 'RosStars95');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (96, 'Alice Brown96', 'RosStars96');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (97, 'Alice Brown97', 'RosStars97');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (98, 'Alice Brown98', 'RosStars98');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (99, 'Alice Brown99', 'RosStars99');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (100, 'Alice Brown100', 'RosStars100');
GO