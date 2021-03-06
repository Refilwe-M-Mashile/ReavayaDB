USE master;

USE ReaVayaDB
GO
	CREATE TABLE Phases(
		PhaseID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		PhaseCode VARCHAR(2) NOT NULL,
		Description NVARCHAR (500) NOT NULL
	);

GO
	CREATE TABLE BusRoutes(
		RouteID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		FromCity VARCHAR(50) NOT NULL,
		ToCity VARCHAR(50) NOT NULL,
		PhaseID INT CONSTRAINT PhaseID_FK FOREIGN KEY REFERENCES Phases(PhaseID),
	);

GO
	CREATE TABLE RouteCodes(
		CodeID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		CodeName VARCHAR(3) UNIQUE NOT NULL,
		RouteID INT CONSTRAINT RouteID_FK FOREIGN KEY REFERENCES BusRoutes(RouteID)
	);

GO
	CREATE TABLE BusStatuses(
		StatusID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		Status VARCHAR(15) NOT NULL UNIQUE,
		Description NVARCHAR(250) NOT NULL UNIQUE
	);

GO
	CREATE TABLE Buses(
		BusID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
		Registration NVARCHAR(10) UNIQUE NOT NULL,
		Seats INT NOT NULL,
		RouteCodeID INT CONSTRAINT RouteCodeID_PK NULL FOREIGN KEY REFERENCES RouteCodes(CodeID),
		StatusID INT CONSTRAINT StatusID_FK FOREIGN KEY REFERENCES BusStatuses(StatusID) DEFAULT 1,
	);

GO
	CREATE TABLE Positions(
		PositionID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
		PositionName VARCHAR (30) NOT NULL UNIQUE,
	);

GO
	CREATE TABLE Employees(
		EmployeeID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
		FirstName NVARCHAR(100) NOT NULL,
		LastName NVARCHAR(100) NOT NULL,
		DateOfBirth DATE NOT NULL,
		ResAddress NVARCHAR(100) NOT NULL,
		CellphoneNum NVARCHAR(20) UNIQUE NOT NULL,
		EmailAddress NVARCHAR(50) UNIQUE NOT NULL,
		PositionID INT CONSTRAINT PositionID_FK FOREIGN KEY REFERENCES Positions(PositionID),
	);

GO
	CREATE TABLE Users(
		UserID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
		FirstName NVARCHAR(100) NOT NULL,
		LastName NVARCHAR(100) NOT NULL,
		DateOfBirth DATE NOT NULL,
		ResAddress VARCHAR(100) NOT NULL,
		City VARCHAR(100) NOT NULL,
		CellphoneNum VARCHAR(10) UNIQUE NOT NULL,
		EmailAddress NVARCHAR(50) UNIQUE NOT NULL,
	);

GO
	CREATE TABLE AccountTypes(
		TypeID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		TypeName NVARCHAR (7) NOT NULL,
	);

GO
	CREATE TABLE Accounts(
		AccountID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		UserID INT FOREIGN KEY (UserID) REFERENCES Users(UserID),
		TypeID INT FOREIGN KEY (TypeID) REFERENCES AccountTypes (TypeID),
		CardNumber INT UNIQUE NOT NULL,
		Points INT DEFAULT 0,
		CreatedAt DATE NOT NULL,
		Balance MONEY DEFAULT 0.0,
	);

GO
	CREATE TABLE Fares(
		FareID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		StartKM DECIMAL NOT NULL,
		EndKM DECIMAL NOT NULL,
		Fare SMALLMONEY NOT NULL,
	);

GO
	CREATE TABLE Stations(
		StationID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		RouteID INT FOREIGN KEY (RouteID) REFERENCES BusRoutes(RouteID),
		Name VARCHAR(30) UNIQUE NOT NULL,
	);

GO
	CREATE TABLE Bookings(
		BookingID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		FareID INT FOREIGN KEY (FareID) REFERENCES Fares(FareID),
		AccountID INT FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
		BusID INT FOREIGN KEY (BusID) REFERENCES Buses (BusID),
		StationID INT FOREIGN KEY (StationID) REFERENCES Stations (StationID),
		TimeOfTravel time NOT NULL,
		DateOfTravel date NOT NULL,
	);

GO
	CREATE TABLE DriverBuses (
		AllocationID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
		EmployeeID INT FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
		BusID INT FOREIGN KEY (BusID) REFERENCES Buses (BusID),
		StartDate DATE NOT NULL,
		EndDate DATE NULL,
	);

GO
	DROP TABLE IF EXISTS TicketTypes CREATE TABLE TicketTypes(
		TypeID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		TicketType VARCHAR(6) NOT NULL,
		Price SMALLMONEY NOT NULL
	);

GO
	CREATE TABLE Tickets(
		TicketID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		StationID INT FOREIGN KEY (StationID) REFERENCES Stations(StationID),
		TicketType INT FOREIGN KEY (TicketType) REFERENCES TicketTypes(TypeID),
		SoldBy INT FOREIGN KEY REFERENCES Employees (EmployeeID)
	);

GO