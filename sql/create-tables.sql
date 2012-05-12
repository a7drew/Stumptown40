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

CREATE TABLE [dbo].[Bracket]
(
  [BracketId]   [int]               NOT NULL,
  [Name]        [nvarchar](100)     NOT NULL,
  CONSTRAINT [PK_Bracket] PRIMARY KEY CLUSTERED ([BracketId] ASC)
)
GO

CREATE TABLE [dbo].[Round]
(
  [RoundId]     [int]               NOT NULL,
  [BracketId]   [int]               NOT NULL,
  [RoundNumber] [int]               NOT NULL,
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
  [NextLosingMatchId]    [int]                   NULL,
  [NextLosingMatchSlot]  [int]                   NULL,
  [Modified]             [datetime]              NULL,
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

ALTER TABLE [dbo].[Match]  WITH CHECK ADD  CONSTRAINT [FK_Match_NextWinningMatchId] FOREIGN KEY([NextWinningMatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[Match] CHECK CONSTRAINT [FK_Match_NextWinningMatchId]
GO

ALTER TABLE [dbo].[Match]  WITH CHECK ADD  CONSTRAINT [FK_Match_NextLosingMatchId] FOREIGN KEY([NextLosingMatchId])
REFERENCES [dbo].[Match] ([MatchId])
GO
ALTER TABLE [dbo].[Match] CHECK CONSTRAINT [FK_Match_NextLosingMatchId]
GO

--
-- DATA
--

INSERT INTO [dbo].[Bracket] (BracketId, Name) VALUES (1, '#winning');
INSERT INTO [dbo].[Bracket] (BracketId, Name) VALUES (2, '#drinking');
INSERT INTO [dbo].[Bracket] (BracketId, Name) VALUES (3, '#championship');
GO

INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (1, 1, 1);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (2, 1, 2);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (3, 1, 3);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (4, 1, 4);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (5, 1, 5);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (6, 1, 6);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (7, 1, 7);

INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (8, 2, 1);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (9, 2, 2);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (10, 2, 3);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (11, 2, 4);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (12, 2, 5);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (13, 2, 6);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (14, 2, 7);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (15, 2, 8);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (16, 2, 9);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (17, 2, 10);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (18, 2, 11);

INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (19, 3, 1);
INSERT INTO [dbo].[Round] (RoundId, BracketId, RoundNumber) VALUES (20, 3, 2);
GO

DECLARE @matchId INT
DECLARE @roundId INT
DECLARE @lastRoundId INT
DECLARE @raceNumber INT
SET @matchId = 1;
SET @roundId = 1;
SET @raceNumber = 1;
SET @lastRoundId = @roundId;

WHILE @matchId < 160
BEGIN

	IF @matchId > 16 SET @roundId = 2;
	IF @matchId > 48 SET @roundId = 3;
	IF @matchId > 64 SET @roundId = 4;
	IF @matchId > 72 SET @roundId = 5;
	IF @matchId > 76 SET @roundId = 6;
	IF @matchId > 78 SET @roundId = 7;

	IF @matchId > 79 SET @roundId = 8;
	IF @matchId > 95 SET @roundId = 9;
	IF @matchId > 111 SET @roundId = 10;
	IF @matchId > 127 SET @roundId = 11;
	IF @matchId > 135 SET @roundId = 12;
	IF @matchId > 143 SET @roundId = 13;
	IF @matchId > 147 SET @roundId = 14;
	IF @matchId > 151 SET @roundId = 15;
	IF @matchId > 153 SET @roundId = 16;
	IF @matchId > 155 SET @roundId = 17;
	IF @matchId > 156 SET @roundId = 18;

	IF @matchId > 157 SET @roundId = 19;
	IF @matchId > 158 SET @roundId = 20;

	IF @lastRoundId <> @roundId SET @raceNumber = 1;

	INSERT INTO [dbo].[Match] (MatchId, RoundId, RaceNumber) VALUES (@matchId, @roundId, @raceNumber);

	SET @lastRoundId = @roundId;
	SET @raceNumber = @raceNumber + 1;
	SET @matchId = @matchId + 1;

END
GO

UPDATE [dbo].[Match] SET [NextWinningMatchId]=17, [NextWinningMatchSlot]=2, [NextLosingMatchId]=80, [NextLosingMatchSlot]=2 WHERE [MatchId]=1;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=19, [NextWinningMatchSlot]=2, [NextLosingMatchId]=81, [NextLosingMatchSlot]=2 WHERE [MatchId]=2;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=21, [NextWinningMatchSlot]=2, [NextLosingMatchId]=86, [NextLosingMatchSlot]=2 WHERE [MatchId]=3;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=23, [NextWinningMatchSlot]=2, [NextLosingMatchId]=87, [NextLosingMatchSlot]=2 WHERE [MatchId]=4;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=25, [NextWinningMatchSlot]=2, [NextLosingMatchId]=84, [NextLosingMatchSlot]=2 WHERE [MatchId]=5;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=27, [NextWinningMatchSlot]=2, [NextLosingMatchId]=85, [NextLosingMatchSlot]=2 WHERE [MatchId]=6;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=29, [NextWinningMatchSlot]=2, [NextLosingMatchId]=82, [NextLosingMatchSlot]=2 WHERE [MatchId]=7;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=31, [NextWinningMatchSlot]=2, [NextLosingMatchId]=83, [NextLosingMatchSlot]=2 WHERE [MatchId]=8;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=33, [NextWinningMatchSlot]=2, [NextLosingMatchId]=88, [NextLosingMatchSlot]=2 WHERE [MatchId]=9;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=35, [NextWinningMatchSlot]=2, [NextLosingMatchId]=89, [NextLosingMatchSlot]=2 WHERE [MatchId]=10;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=37, [NextWinningMatchSlot]=2, [NextLosingMatchId]=94, [NextLosingMatchSlot]=2 WHERE [MatchId]=11;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=39, [NextWinningMatchSlot]=2, [NextLosingMatchId]=95, [NextLosingMatchSlot]=2 WHERE [MatchId]=12;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=41, [NextWinningMatchSlot]=2, [NextLosingMatchId]=92, [NextLosingMatchSlot]=2 WHERE [MatchId]=13;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=43, [NextWinningMatchSlot]=2, [NextLosingMatchId]=93, [NextLosingMatchSlot]=2 WHERE [MatchId]=14;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=45, [NextWinningMatchSlot]=2, [NextLosingMatchId]=90, [NextLosingMatchSlot]=2 WHERE [MatchId]=15;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=47, [NextWinningMatchSlot]=2, [NextLosingMatchId]=91, [NextLosingMatchSlot]=2 WHERE [MatchId]=16;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=49, [NextWinningMatchSlot]=1, [NextLosingMatchId]=88, [NextLosingMatchSlot]=1 WHERE [MatchId]=17;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=49, [NextWinningMatchSlot]=2, [NextLosingMatchId]=104, [NextLosingMatchSlot]=1 WHERE [MatchId]=18;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=50, [NextWinningMatchSlot]=1, [NextLosingMatchId]=89, [NextLosingMatchSlot]=1 WHERE [MatchId]=19;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=50, [NextWinningMatchSlot]=2, [NextLosingMatchId]=105, [NextLosingMatchSlot]=1 WHERE [MatchId]=20;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=51, [NextWinningMatchSlot]=1, [NextLosingMatchId]=94, [NextLosingMatchSlot]=1 WHERE [MatchId]=21;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=51, [NextWinningMatchSlot]=2, [NextLosingMatchId]=110, [NextLosingMatchSlot]=1 WHERE [MatchId]=22;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=52, [NextWinningMatchSlot]=1, [NextLosingMatchId]=95, [NextLosingMatchSlot]=1 WHERE [MatchId]=23;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=52, [NextWinningMatchSlot]=2, [NextLosingMatchId]=111, [NextLosingMatchSlot]=1 WHERE [MatchId]=24;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=53, [NextWinningMatchSlot]=1, [NextLosingMatchId]=92, [NextLosingMatchSlot]=1 WHERE [MatchId]=25;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=53, [NextWinningMatchSlot]=2, [NextLosingMatchId]=108, [NextLosingMatchSlot]=1 WHERE [MatchId]=26;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=54, [NextWinningMatchSlot]=1, [NextLosingMatchId]=93, [NextLosingMatchSlot]=1 WHERE [MatchId]=27;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=54, [NextWinningMatchSlot]=2, [NextLosingMatchId]=109, [NextLosingMatchSlot]=1 WHERE [MatchId]=28;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=55, [NextWinningMatchSlot]=1, [NextLosingMatchId]=90, [NextLosingMatchSlot]=1 WHERE [MatchId]=29;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=55, [NextWinningMatchSlot]=2, [NextLosingMatchId]=106, [NextLosingMatchSlot]=1 WHERE [MatchId]=30;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=56, [NextWinningMatchSlot]=1, [NextLosingMatchId]=91, [NextLosingMatchSlot]=1 WHERE [MatchId]=31;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=56, [NextWinningMatchSlot]=2, [NextLosingMatchId]=107, [NextLosingMatchSlot]=1 WHERE [MatchId]=32;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=57, [NextWinningMatchSlot]=1, [NextLosingMatchId]=80, [NextLosingMatchSlot]=1 WHERE [MatchId]=33;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=57, [NextWinningMatchSlot]=2, [NextLosingMatchId]=96, [NextLosingMatchSlot]=1 WHERE [MatchId]=34;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=58, [NextWinningMatchSlot]=1, [NextLosingMatchId]=81, [NextLosingMatchSlot]=1 WHERE [MatchId]=35;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=58, [NextWinningMatchSlot]=2, [NextLosingMatchId]=97, [NextLosingMatchSlot]=1 WHERE [MatchId]=36;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=59, [NextWinningMatchSlot]=1, [NextLosingMatchId]=86, [NextLosingMatchSlot]=1 WHERE [MatchId]=37;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=59, [NextWinningMatchSlot]=2, [NextLosingMatchId]=102, [NextLosingMatchSlot]=1 WHERE [MatchId]=38;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=60, [NextWinningMatchSlot]=1, [NextLosingMatchId]=87, [NextLosingMatchSlot]=1 WHERE [MatchId]=39;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=60, [NextWinningMatchSlot]=2, [NextLosingMatchId]=103, [NextLosingMatchSlot]=1 WHERE [MatchId]=40;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=61, [NextWinningMatchSlot]=1, [NextLosingMatchId]=84, [NextLosingMatchSlot]=1 WHERE [MatchId]=41;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=61, [NextWinningMatchSlot]=2, [NextLosingMatchId]=100, [NextLosingMatchSlot]=1 WHERE [MatchId]=42;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=62, [NextWinningMatchSlot]=1, [NextLosingMatchId]=85, [NextLosingMatchSlot]=1 WHERE [MatchId]=43;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=62, [NextWinningMatchSlot]=2, [NextLosingMatchId]=101, [NextLosingMatchSlot]=1 WHERE [MatchId]=44;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=63, [NextWinningMatchSlot]=1, [NextLosingMatchId]=82, [NextLosingMatchSlot]=1 WHERE [MatchId]=45;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=63, [NextWinningMatchSlot]=2, [NextLosingMatchId]=98, [NextLosingMatchSlot]=1 WHERE [MatchId]=46;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=64, [NextWinningMatchSlot]=1, [NextLosingMatchId]=83, [NextLosingMatchSlot]=1 WHERE [MatchId]=47;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=64, [NextWinningMatchSlot]=2, [NextLosingMatchId]=99, [NextLosingMatchSlot]=1 WHERE [MatchId]=48;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=65, [NextWinningMatchSlot]=1, [NextLosingMatchId]=114, [NextLosingMatchSlot]=1 WHERE [MatchId]=49;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=65, [NextWinningMatchSlot]=2, [NextLosingMatchId]=116, [NextLosingMatchSlot]=1 WHERE [MatchId]=50;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=66, [NextWinningMatchSlot]=1, [NextLosingMatchId]=115, [NextLosingMatchSlot]=1 WHERE [MatchId]=51;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=66, [NextWinningMatchSlot]=2, [NextLosingMatchId]=117, [NextLosingMatchSlot]=1 WHERE [MatchId]=52;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=67, [NextWinningMatchSlot]=1, [NextLosingMatchId]=118, [NextLosingMatchSlot]=1 WHERE [MatchId]=53;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=67, [NextWinningMatchSlot]=2, [NextLosingMatchId]=112, [NextLosingMatchSlot]=1 WHERE [MatchId]=54;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=68, [NextWinningMatchSlot]=1, [NextLosingMatchId]=119, [NextLosingMatchSlot]=1 WHERE [MatchId]=55;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=68, [NextWinningMatchSlot]=2, [NextLosingMatchId]=113, [NextLosingMatchSlot]=1 WHERE [MatchId]=56;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=69, [NextWinningMatchSlot]=1, [NextLosingMatchId]=122, [NextLosingMatchSlot]=1 WHERE [MatchId]=57;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=69, [NextWinningMatchSlot]=2, [NextLosingMatchId]=124, [NextLosingMatchSlot]=1 WHERE [MatchId]=58;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=70, [NextWinningMatchSlot]=1, [NextLosingMatchId]=123, [NextLosingMatchSlot]=1 WHERE [MatchId]=59;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=70, [NextWinningMatchSlot]=2, [NextLosingMatchId]=125, [NextLosingMatchSlot]=1 WHERE [MatchId]=60;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=71, [NextWinningMatchSlot]=1, [NextLosingMatchId]=126, [NextLosingMatchSlot]=1 WHERE [MatchId]=61;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=71, [NextWinningMatchSlot]=2, [NextLosingMatchId]=120, [NextLosingMatchSlot]=1 WHERE [MatchId]=62;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=72, [NextWinningMatchSlot]=1, [NextLosingMatchId]=127, [NextLosingMatchSlot]=1 WHERE [MatchId]=63;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=72, [NextWinningMatchSlot]=2, [NextLosingMatchId]=121, [NextLosingMatchSlot]=1 WHERE [MatchId]=64;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=73, [NextWinningMatchSlot]=1, [NextLosingMatchId]=141, [NextLosingMatchSlot]=1 WHERE [MatchId]=65;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=73, [NextWinningMatchSlot]=2, [NextLosingMatchId]=140, [NextLosingMatchSlot]=1 WHERE [MatchId]=66;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=74, [NextWinningMatchSlot]=1, [NextLosingMatchId]=143, [NextLosingMatchSlot]=1 WHERE [MatchId]=67;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=74, [NextWinningMatchSlot]=2, [NextLosingMatchId]=142, [NextLosingMatchSlot]=1 WHERE [MatchId]=68;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=75, [NextWinningMatchSlot]=1, [NextLosingMatchId]=137, [NextLosingMatchSlot]=1 WHERE [MatchId]=69;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=75, [NextWinningMatchSlot]=2, [NextLosingMatchId]=136, [NextLosingMatchSlot]=1 WHERE [MatchId]=70;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=76, [NextWinningMatchSlot]=1, [NextLosingMatchId]=139, [NextLosingMatchSlot]=1 WHERE [MatchId]=71;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=76, [NextWinningMatchSlot]=2, [NextLosingMatchId]=138, [NextLosingMatchSlot]=1 WHERE [MatchId]=72;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=77, [NextWinningMatchSlot]=1, [NextLosingMatchId]=148, [NextLosingMatchSlot]=1 WHERE [MatchId]=73;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=77, [NextWinningMatchSlot]=2, [NextLosingMatchId]=149, [NextLosingMatchSlot]=1 WHERE [MatchId]=74;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=78, [NextWinningMatchSlot]=1, [NextLosingMatchId]=150, [NextLosingMatchSlot]=1 WHERE [MatchId]=75;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=78, [NextWinningMatchSlot]=2, [NextLosingMatchId]=151, [NextLosingMatchSlot]=1 WHERE [MatchId]=76;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=79, [NextWinningMatchSlot]=1, [NextLosingMatchId]=155, [NextLosingMatchSlot]=1 WHERE [MatchId]=77;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=79, [NextWinningMatchSlot]=2, [NextLosingMatchId]=154, [NextLosingMatchSlot]=1 WHERE [MatchId]=78;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=158, [NextWinningMatchSlot]=1, [NextLosingMatchId]=157, [NextLosingMatchSlot]=1 WHERE [MatchId]=79;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=96, [NextWinningMatchSlot]=2 WHERE [MatchId]=80;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=97, [NextWinningMatchSlot]=2 WHERE [MatchId]=81;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=98, [NextWinningMatchSlot]=2 WHERE [MatchId]=82;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=99, [NextWinningMatchSlot]=2 WHERE [MatchId]=83;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=100, [NextWinningMatchSlot]=2 WHERE [MatchId]=84;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=101, [NextWinningMatchSlot]=2 WHERE [MatchId]=85;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=102, [NextWinningMatchSlot]=2 WHERE [MatchId]=86;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=103, [NextWinningMatchSlot]=2 WHERE [MatchId]=87;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=104, [NextWinningMatchSlot]=2 WHERE [MatchId]=88;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=105, [NextWinningMatchSlot]=2 WHERE [MatchId]=89;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=106, [NextWinningMatchSlot]=2 WHERE [MatchId]=90;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=107, [NextWinningMatchSlot]=2 WHERE [MatchId]=91;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=108, [NextWinningMatchSlot]=2 WHERE [MatchId]=92;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=109, [NextWinningMatchSlot]=2 WHERE [MatchId]=93;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=110, [NextWinningMatchSlot]=2 WHERE [MatchId]=94;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=111, [NextWinningMatchSlot]=2 WHERE [MatchId]=95;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=112, [NextWinningMatchSlot]=2 WHERE [MatchId]=96;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=113, [NextWinningMatchSlot]=2 WHERE [MatchId]=97;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=114, [NextWinningMatchSlot]=2 WHERE [MatchId]=98;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=115, [NextWinningMatchSlot]=2 WHERE [MatchId]=99;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=116, [NextWinningMatchSlot]=2 WHERE [MatchId]=100;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=117, [NextWinningMatchSlot]=2 WHERE [MatchId]=101;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=118, [NextWinningMatchSlot]=2 WHERE [MatchId]=102;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=119, [NextWinningMatchSlot]=2 WHERE [MatchId]=103;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=120, [NextWinningMatchSlot]=2 WHERE [MatchId]=104;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=121, [NextWinningMatchSlot]=2 WHERE [MatchId]=105;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=122, [NextWinningMatchSlot]=2 WHERE [MatchId]=106;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=123, [NextWinningMatchSlot]=2 WHERE [MatchId]=107;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=124, [NextWinningMatchSlot]=2 WHERE [MatchId]=108;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=125, [NextWinningMatchSlot]=2 WHERE [MatchId]=109;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=126, [NextWinningMatchSlot]=2 WHERE [MatchId]=110;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=127, [NextWinningMatchSlot]=2 WHERE [MatchId]=111;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=128, [NextWinningMatchSlot]=1 WHERE [MatchId]=112;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=128, [NextWinningMatchSlot]=2 WHERE [MatchId]=113;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=129, [NextWinningMatchSlot]=1 WHERE [MatchId]=114;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=129, [NextWinningMatchSlot]=2 WHERE [MatchId]=115;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=130, [NextWinningMatchSlot]=1 WHERE [MatchId]=116;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=130, [NextWinningMatchSlot]=2 WHERE [MatchId]=117;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=131, [NextWinningMatchSlot]=1 WHERE [MatchId]=118;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=131, [NextWinningMatchSlot]=2 WHERE [MatchId]=119;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=132, [NextWinningMatchSlot]=1 WHERE [MatchId]=120;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=132, [NextWinningMatchSlot]=2 WHERE [MatchId]=121;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=133, [NextWinningMatchSlot]=1 WHERE [MatchId]=122;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=133, [NextWinningMatchSlot]=2 WHERE [MatchId]=123;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=134, [NextWinningMatchSlot]=1 WHERE [MatchId]=124;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=134, [NextWinningMatchSlot]=2 WHERE [MatchId]=125;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=135, [NextWinningMatchSlot]=1 WHERE [MatchId]=126;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=135, [NextWinningMatchSlot]=2 WHERE [MatchId]=127;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=136, [NextWinningMatchSlot]=2 WHERE [MatchId]=128;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=137, [NextWinningMatchSlot]=2 WHERE [MatchId]=129;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=138, [NextWinningMatchSlot]=2 WHERE [MatchId]=130;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=139, [NextWinningMatchSlot]=2 WHERE [MatchId]=131;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=140, [NextWinningMatchSlot]=2 WHERE [MatchId]=132;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=141, [NextWinningMatchSlot]=2 WHERE [MatchId]=133;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=142, [NextWinningMatchSlot]=2 WHERE [MatchId]=134;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=143, [NextWinningMatchSlot]=2 WHERE [MatchId]=135;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=144, [NextWinningMatchSlot]=1 WHERE [MatchId]=136;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=144, [NextWinningMatchSlot]=2 WHERE [MatchId]=137;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=145, [NextWinningMatchSlot]=1 WHERE [MatchId]=138;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=145, [NextWinningMatchSlot]=2 WHERE [MatchId]=139;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=146, [NextWinningMatchSlot]=1 WHERE [MatchId]=140;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=146, [NextWinningMatchSlot]=2 WHERE [MatchId]=141;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=147, [NextWinningMatchSlot]=1 WHERE [MatchId]=142;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=147, [NextWinningMatchSlot]=2 WHERE [MatchId]=143;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=148, [NextWinningMatchSlot]=2 WHERE [MatchId]=144;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=149, [NextWinningMatchSlot]=2 WHERE [MatchId]=145;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=150, [NextWinningMatchSlot]=2 WHERE [MatchId]=146;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=151, [NextWinningMatchSlot]=2 WHERE [MatchId]=147;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=152, [NextWinningMatchSlot]=1 WHERE [MatchId]=148;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=152, [NextWinningMatchSlot]=2 WHERE [MatchId]=149;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=153, [NextWinningMatchSlot]=1 WHERE [MatchId]=150;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=153, [NextWinningMatchSlot]=2 WHERE [MatchId]=151;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=154, [NextWinningMatchSlot]=2 WHERE [MatchId]=152;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=155, [NextWinningMatchSlot]=2 WHERE [MatchId]=153;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=156, [NextWinningMatchSlot]=1 WHERE [MatchId]=154;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=156, [NextWinningMatchSlot]=2 WHERE [MatchId]=155;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=157, [NextWinningMatchSlot]=2 WHERE [MatchId]=156;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=158, [NextWinningMatchSlot]=2 WHERE [MatchId]=157;
UPDATE [dbo].[Match] SET [NextWinningMatchId]=159, [NextWinningMatchSlot]=1 WHERE [MatchId]=158;
UPDATE [dbo].[Match] SET [NextLosingMatchId]=159, [NextLosingMatchSlot]=2 WHERE [MatchId]=158;
GO

INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (29, 'Joe Mildenberger', 'Joe Mildenberger');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (31, 'Mason West', 'Ascentium');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (20, 'Allison Thompson', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (49, 'Yvonne Perez Emerson', 'WeMake');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (41, 'Yvonne Perez Emerson', 'Creativegirl');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (40, 'Michael Dryden', 'Nike');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (63, 'Del Olds', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (25, 'John Skelton', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (77, 'Ed Matthews', 'Ed Matthews');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (36, 'Johnny Levenson', 'John Levenson Design');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (59, 'Ryan Smythe', 'Smythe Design');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (27, 'Evan Wilcox', 'Evan Wilcox');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (39, 'HERENOW', 'HERENOW');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (12, 'Emily Passmore', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (47, 'Jamie Jeffers', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (64, 'Simon McDowell', 'Mountain Shop/Castle Boardshop');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (68, 'Nate Currie', 'Nate Currie');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (58, 'Nick Fedoroff', 'Webtrends');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (76, 'Robin Balmer', 'Webtrends Design Lab');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (34, 'Kelley Roy and Team ADX Three', 'ADX Portland');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (14, 'Ryan Parr', 'Webtrends Design Lab');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (3, 'Rob Derstadt', 'Rob Derstadt');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (55, 'AIGA Portland', 'AIGA Portland');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (35, 'Erik Ratcliffe', 'Erik Ratcliffe');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (44, 'Timurx', 'Timurx');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (15, 'Jen Raynak', 'Little Star Cars');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (33, 'Brad Hagstrom', 'Brad Hagstrom');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (67, 'Duane Casey', 'King/Casey Motor Sports');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (56, 'Steven Osborn', 'Urban Airship');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (22, 'Mark Kellar', 'Mark Kellar');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (24, 'Anton Legoo', 'Anton Legoo');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (18, 'Charrice Finks', 'Charrice Finks');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (69, 'Maria & Nikole', 'Sockeye');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (60, 'Patrick Holly', 'Get Crisp');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (2, 'Kris Jaksic', 'Kris Jaksic');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (13, 'DanO', 'Splash Worldwide');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (6, 'Jason Keisling', 'www.jasonkeisling.com');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (28, 'Mike Wellins', 'The Freakybuttrue Peculiarium');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (19, 'Brandon Schoessler', 'Transport');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (8, 'Jeremy Knudson', 'Jeremy Knudson');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (65, 'Mark Lewis', 'Mark Lewis');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (66, 'Tim May', 'Tim May');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (71, 'Urban Airship One', 'Urban Airship');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (74, 'Urban Airship Two', 'Urban Airship');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (10, 'Urban Airship Three', 'Urban Airship');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (37, 'David Frey', 'Webtrends Design Lab');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (26, 'Pinball One', 'Pinball One');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (51, 'Bryant Jaksic', 'Bryant Jaksic');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (70, 'Ben Friedle', 'Outlier Solutions');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (23, 'Evan Osherow', 'Webtrends');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (50, 'Fabrice Tatieze', 'Webtrends');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (7, 'Julie Sowell', 'Webtrends');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (17, 'Sheli Bryan', 'Buckman');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (61, 'Zach Vestal', 'Buckman');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (30, 'Five', 'Athletepath');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (5, 'George Vakoutis', 'TheNewGroup');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (53, 'Nick Nakadate', 'Animation Dynamics, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (80, 'Sho Ito', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (52, 'Keenan Blanchard', 'Keenan Blanchard Photography');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (79, 'Willamette Week', 'Willamette Week');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (1, 'Steve Jarvis', 'Steve Jarvis');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (42, 'Dirk Frewing', 'Dirk Frewing');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (46, 'Kelley Roy and Team ADX One', 'ADX Portland');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (43, 'David Stewart', 'Webtrends Design Lab');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (73, 'Kelley Roy and Team ADX Two', 'ADX Portland');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (4, 'Seth Cameron Short', 'Animation Dynamics Inc (ADi)');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (16, 'Nic Petersen', 'Makelike (ADi)');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (32, 'Eric Graham-Adams Herboth', 'Equippe');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (9, 'Bruce Kehe', 'Hopworks');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (54, 'Rocket', 'Revel In Portland');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (11, 'Andy Hugelier', 'Subtext');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (48, 'Stephen Leineweber', 'Pop Art Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (21, 'Mark Ulanowicz', 'Mark Ulanowicz');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (62, 'Birdhat', 'Birdhat');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (75, 'Mark Stein', 'Mark Stein Photography');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (72, 'Lorien Steele', 'Pop Art, Inc.');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (38, 'Ezra Cimino-Hurt', 'Case of Bass');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (57, 'Doug Chamblin', 'Doug Chamblin Furniture Maker');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (45, 'Derek Keevil', 'The Hat Sharpener');
INSERT INTO [dbo].[Racer] (StartSlot, Name, Organization) VALUES (78, 'Matthew Ross', 'RosStars');
GO
