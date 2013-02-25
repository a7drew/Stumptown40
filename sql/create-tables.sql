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

INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (1, 'FirstName LastName', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (2, 'FirstName LastName', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (3, 'FirstName LastName', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (4, 'FirstName LastName', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (5, 'FirstName LastName', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (6, 'FirstName LastName', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (7, 'FirstName LastName', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (8, 'FirstName LastName', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (9, 'FirstName LastName', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (10, 'FirstName LastName10', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (11, 'FirstName LastName11', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (12, 'FirstName LastName12', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (13, 'FirstName LastName13', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (14, 'FirstName LastName14', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (15, 'FirstName LastName15', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (16, 'FirstName LastName16', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (17, 'FirstName LastName17', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (18, 'FirstName LastName18', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (19, 'FirstName LastName19', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (20, 'FirstName LastName20', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (21, 'FirstName LastName21', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (22, 'FirstName LastName22', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (23, 'FirstName LastName23', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (24, 'FirstName LastName24', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (25, 'FirstName LastName25', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (26, 'FirstName LastName26', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (27, 'FirstName LastName27', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (28, 'FirstName LastName28', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (29, 'FirstName LastName29', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (30, 'FirstName LastName30', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (31, 'FirstName LastName31', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (32, 'FirstName LastName32', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (33, 'FirstName LastName33', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (34, 'FirstName LastName34', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (35, 'FirstName LastName35', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (36, 'FirstName LastName36', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (37, 'FirstName LastName37', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (38, 'FirstName LastName38', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (39, 'FirstName LastName39', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (40, 'FirstName LastName40', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (41, 'FirstName LastName41', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (42, 'FirstName LastName42', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (43, 'FirstName LastName43', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (44, 'FirstName LastName44', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (45, 'FirstName LastName45', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (46, 'FirstName LastName46', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (47, 'FirstName LastName47', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (48, 'FirstName LastName48', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (49, 'FirstName LastName49', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (50, 'FirstName LastName50', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (51, 'FirstName LastName51', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (52, 'FirstName LastName52', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (53, 'FirstName LastName53', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (54, 'FirstName LastName54', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (55, 'FirstName LastName55', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (56, 'FirstName LastName56', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (57, 'FirstName LastName57', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (58, 'FirstName LastName58', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (59, 'FirstName LastName59', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (60, 'FirstName LastName60', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (61, 'FirstName LastName61', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (62, 'FirstName LastName62', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (63, 'FirstName LastName63', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (64, 'FirstName LastName64', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (65, 'FirstName LastName65', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (66, 'FirstName LastName66', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (67, 'FirstName LastName67', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (68, 'FirstName LastName68', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (69, 'FirstName LastName69', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (70, 'FirstName LastName70', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (71, 'FirstName LastName71', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (72, 'FirstName LastName72', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (73, 'FirstName LastName73', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (74, 'FirstName LastName74', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (75, 'FirstName LastName75', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (76, 'FirstName LastName76', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (77, 'FirstName LastName77', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (78, 'FirstName LastName78', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (79, 'FirstName LastName79', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (80, 'FirstName LastName80', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (81, 'FirstName LastName81', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (82, 'FirstName LastName82', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (83, 'FirstName LastName83', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (84, 'FirstName LastName84', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (85, 'FirstName LastName85', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (86, 'FirstName LastName86', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (87, 'FirstName LastName87', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (88, 'FirstName LastName88', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (89, 'FirstName LastName89', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (90, 'FirstName LastName90', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (91, 'FirstName LastName91', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (92, 'FirstName LastName92', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (93, 'FirstName LastName93', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (94, 'FirstName LastName94', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (95, 'FirstName LastName95', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (96, 'FirstName LastName96', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (97, 'FirstName LastName97', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (98, 'FirstName LastName98', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (99, 'FirstName LastName99', 'Company Name Goes Here');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (100, 'FirstName LastName100', 'Company Name Goes Here100');
GO