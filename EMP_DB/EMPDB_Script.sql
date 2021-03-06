IF OBJECT_ID ('dbo.AspNetUsers') IS NOT NULL
	DROP TABLE dbo.AspNetUsers
GO

CREATE TABLE dbo.AspNetUsers
	(
	Id                   NVARCHAR (128) NOT NULL,
	Email                NVARCHAR (256),
	EmailConfirmed       BIT NOT NULL,
	PasswordHash         NVARCHAR (max),
	SecurityStamp        NVARCHAR (max),
	PhoneNumber          NVARCHAR (max),
	PhoneNumberConfirmed BIT NOT NULL,
	TwoFactorEnabled     BIT NOT NULL,
	LockoutEndDateUtc    DATETIME,
	LockoutEnabled       BIT NOT NULL,
	AccessFailedCount    INT NOT NULL,
	UserName             NVARCHAR (256) NOT NULL,
	CONSTRAINT PK_dbo.AspNetUsers PRIMARY KEY (Id)
	)
GO

CREATE UNIQUE INDEX UserNameIndex
	ON dbo.AspNetUsers (UserName)
GO



IF OBJECT_ID ('dbo.NewsHighlight') IS NOT NULL
	DROP TABLE dbo.NewsHighlight
GO

CREATE TABLE dbo.NewsHighlight
	(
	NEWSID   INT IDENTITY NOT NULL,
	TITLE    NVARCHAR (500),
	LOGONAME VARCHAR (100),
	LOGOPATH VARCHAR (500),
	JOBTYPE  VARCHAR (50),
	DEL_IND  CHAR (1)
	)
GO

IF OBJECT_ID ('dbo.PAPERPOSTING') IS NOT NULL
	DROP TABLE dbo.PAPERPOSTING
GO

CREATE TABLE dbo.PAPERPOSTING
	(
	PID          INT IDENTITY NOT NULL,
	PNAME        VARCHAR (50),
	PDESCRIPTION VARCHAR (500),
	WEEK         VARCHAR (50),
	POSTDATE     DATE,
	PPATH        VARCHAR (500),
	DEL_IND      CHAR (1),
	ISACTIVE     CHAR (1),
	IPADDRESS    VARCHAR (50),
	CREATEUSER   VARCHAR (50),
	CREATEDATE   DATE,
	UPDATEUSER   VARCHAR (50),
	UPDATEDATE   DATE,
	CONSTRAINT PK_PAPERPOSTING PRIMARY KEY (PID)
	)
GO

IF OBJECT_ID ('dbo.SUBSCRIPTIONS') IS NOT NULL
	DROP TABLE dbo.SUBSCRIPTIONS
GO

CREATE TABLE dbo.SUBSCRIPTIONS
	(
	SUBID        INT IDENTITY NOT NULL,
	SUBNAME      VARCHAR (50),
	SUBAMOUNT    DECIMAL (18, 2),
	VALIDFOR     INT,
	TIMEDURATION VARCHAR (50),
	DEL_IND      CHAR (1),
	CREATEUSER   VARCHAR (50),
	CREATEDATE   DATE,
	CONSTRAINT PK_SUBSCRIPTIONS PRIMARY KEY (SUBID)
	)
GO

IF OBJECT_ID ('dbo.TRANSECTIONS') IS NOT NULL
	DROP TABLE dbo.TRANSECTIONS
GO

CREATE TABLE dbo.TRANSECTIONS
	(
	TRANID             INT IDENTITY NOT NULL,
	EMAIL              VARCHAR (50),
	SUBID              INT,
	SUBSTARTDATE       DATE,
	SUBENDDATE         DATE,
	ISACTIVE           CHAR (1),
	PAIDAMOUNT         DECIMAL (18, 2),
	PAYTYPE            VARCHAR (50),
	TRAINAMOUNT        DECIMAL (18, 2),
	PAYSTATUS          VARCHAR (250),
	mihpayid           VARCHAR (100),
	mode               VARCHAR (50),
	status             VARCHAR (50),
	txnid              VARCHAR (100),
	amount             DECIMAL (18, 2),
	addedon            DATETIME,
	productinfo        VARCHAR (500),
	firstname          VARCHAR (100),
	Payuemail          VARCHAR (100),
	phone              VARCHAR (50),
	PG_TYPE            VARCHAR (50),
	encryptedPaymentId VARCHAR (200),
	bank_ref_num       VARCHAR (50),
	bankcode           VARCHAR (50),
	error              VARCHAR (200),
	error_Message      VARCHAR (1000),
	cardToken          VARCHAR (100),
	name_on_card       VARCHAR (100),
	cardnum            VARCHAR (100),
	payuMoneyId        VARCHAR (50),
	discount           DECIMAL (18, 2),
	net_amount_debit   DECIMAL (18, 2),
	CONSTRAINT PK_TRANSECTIONS PRIMARY KEY NONCLUSTERED (TRANID),
	CONSTRAINT FK_TRANSECTIONS_SUBSCRIPTIONS FOREIGN KEY (SUBID) REFERENCES dbo.SUBSCRIPTIONS (SUBID),
	CONSTRAINT FK_TRANSECTIONS_USER FOREIGN KEY (EMAIL) REFERENCES dbo.USER (EMAIL)
	)
GO

CREATE CLUSTERED INDEX IX_TRANSECTIONS
	ON dbo.TRANSECTIONS (TRANID)
GO

IF OBJECT_ID ('dbo.[USER]') IS NOT NULL
	DROP TABLE dbo.[USER]
GO

CREATE TABLE dbo.[USER]
	(
	ID         INT IDENTITY NOT NULL,
	FIRSTNAME  VARCHAR (50),
	MIDDLENAME VARCHAR (50),
	LASTNAME   VARCHAR (50),
	MOB        VARCHAR (10),
	CONTACT    VARCHAR (50),
	ADDRESS    VARCHAR (500),
	AREA       VARCHAR (50),
	CITY       VARCHAR (50),
	STATE      VARCHAR (50),
	COUNTRY    VARCHAR (50),
	EMAIL      VARCHAR (50) NOT NULL,
	PASSWORD   VARCHAR (50),
	CREATEDATE DATE,
	CREATEUSER VARCHAR (50),
	UPDATEDATE DATE,
	UPDATEUSER VARCHAR (50),
	DEL_IND    CHAR (1),
	ISACTIVE   CHAR (1),
	IPADDRESS  VARCHAR (50),
	CONSTRAINT PK_USER PRIMARY KEY (EMAIL)
	)
GO

IF OBJECT_ID ('dbo.USERSPAPERDETAILS') IS NOT NULL
	DROP TABLE dbo.USERSPAPERDETAILS
GO

CREATE TABLE dbo.USERSPAPERDETAILS
	(
	ID     INT IDENTITY NOT NULL,
	TRANID INT,
	EMAIL  VARCHAR (50),
	PID    INT,
	CONSTRAINT PK_USERSPAPERDETAILS PRIMARY KEY (ID),
	CONSTRAINT FK_USERSPAPERDETAILS_PAPERPOSTING FOREIGN KEY (PID) REFERENCES dbo.PAPERPOSTING (PID),
	CONSTRAINT FK_USERSPAPERDETAILS_USER FOREIGN KEY (EMAIL) REFERENCES dbo.USER (EMAIL),
	CONSTRAINT FK_USERSPAPERDETAILS_USERSPAPERDETAILS FOREIGN KEY (TRANID) REFERENCES dbo.TRANSECTIONS (TRANID)
	)
GO



