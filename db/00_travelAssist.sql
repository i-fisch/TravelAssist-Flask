SHOW DATABASES;
CREATE DATABASE TravelAssist;

grant all privileges on TravelAssist.* to 'webapp'@'%';
flush privileges;

USE TravelAssist;

CREATE TABLE IF NOT EXISTS Hosts (
    Username VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(20),
    PhoneNumber INTEGER,
    Email VARCHAR(100) UNIQUE NOT NULL,
    HostPartner VARCHAR(50),
    FOREIGN KEY(HostPartner)
           REFERENCES Hosts(Username)
);

INSERT INTO Hosts(Username, FirstName, LastName, Gender, PhoneNumber, Email)
VALUES ('harold72', 'harold', 'wilder', 'male', 1112223333, 'harold@yahoo.com');
INSERT INTO Hosts
VALUES ('Agnes72', 'agnes', 'wilder', 'female', 1112223333, 'agnes@yahoo.com', 'harold72');

CREATE TABLE IF NOT EXISTS Travelers (
    Username VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(20),
    Age INTEGER NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Budget INTEGER
);

INSERT INTO Travelers
VALUES ('emanr', 'emanual', 'reuder', 'male', 34, 'emanual@gmail.com', 100);
INSERT INTO Travelers
VALUES ('aishao', 'aisha', 'oliver', 'female', 48, 'aishao@gmail.com', 5000);
INSERT INTO Travelers
VALUES ('ameliam', 'amelia', 'mason', 'female', 21, 'ameliam@gmail.com', 100);

CREATE TABLE IF NOT EXISTS Planners (
    Username VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNumber INTEGER,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Fees INTEGER NOT NULL,
    ExperienceLevel VARCHAR(50) NOT NULL
);

INSERT INTO Planners
VALUES ('georgew', 'george', 'washington', 1349874528, 'georgew@gmail.com', 1000, 'expert');
INSERT INTO Planners
VALUES ('edwinh', 'edwin', 'honoret', 1349874525, 'edwinh@gmail.com', 100, 'beginner');

CREATE TABLE IF NOT EXISTS Activities (
    Name VARCHAR(200),
    Description VARCHAR(1000) NOT NULL,
    Location VARCHAR(200),
    Category VARCHAR(100) NOT NULL,
    Price INTEGER NOT NULL,
    Availability INTEGER,
    HostUser VARCHAR(50),
    PRIMARY KEY (Name, Location),
    FOREIGN KEY(HostUser)
           REFERENCES Hosts(Username)
);

INSERT INTO Activities
VALUES ('Tree climbing', 'Climbing redwood trees.', 'California', 'Outdoors', 50, 20, 'harold72');
INSERT INTO Activities
VALUES ('Circus', 'Come see clowns and acrobats.', 'Wisconsin', 'Entertainment', 20, 100, 'Agnes72');

CREATE TABLE IF NOT EXISTS Lodgings (
    Name VARCHAR(200),
    City VARCHAR(100),
    Country VARCHAR(100) NOT NULL,
    Region VARCHAR(100),
    Street VARCHAR(100) NOT NULL,
    Number INTEGER NOT NULL,
    ZIP INTEGER NOT NULL,
    PhoneNumber INTEGER,
    HostUser VARCHAR(50),
    PRIMARY KEY (Name, City),
    FOREIGN KEY(HostUser)
           REFERENCES Hosts(Username)
);

INSERT INTO Lodgings
VALUES ('H&A B&B', 'Madison', 'USA', 'Wisconsin', 'South Maine', 72, 53558, 1112223333, 'harold72');
INSERT INTO Lodgings
VALUES ('The Lodge', 'Frankfort', 'USA', 'Kentucky', 'Green', 27, 40601, 1112224444, 'Agnes72');

CREATE TABLE IF NOT EXISTS Rooms (
    Name VARCHAR(200),
    City VARCHAR(100),
    Number INTEGER NOT NULL,
    View VARCHAR(100),
    Price INTEGER NOT NULL,
    NumBeds INTEGER NOT NULL,
    PRIMARY KEY (Name, City, Number),
    FOREIGN KEY(Name, City)
           REFERENCES Lodgings(Name, City)
           ON UPDATE CASCADE
           ON DELETE CASCADE
);

INSERT INTO Rooms
VALUES ('H&A B&B', 'Madison', 201, 'Field', 167, 2);
INSERT INTO Rooms
VALUES ('The Lodge', 'Frankfort', 532, 'Woods', 213, 1);

CREATE TABLE IF NOT EXISTS TravelGroups (
    Name VARCHAR(100),
    Organizer VARCHAR(50),
    Destination VARCHAR(100),
    PRIMARY KEY (Name, Organizer)
);

INSERT INTO TravelGroups
VALUES ('Amelia\'s Group', 'Amelia', 'Wyoming');
INSERT INTO TravelGroups
VALUES ('Emanual\'s Group', 'Emanual', 'Antarctica');

CREATE TABLE IF NOT EXISTS Discounts (
    Name VARCHAR(200),
    DealPercent INTEGER,
    Description VARCHAR(1000) NOT NULL,
    PRIMARY KEY (Name, DealPercent)
);

INSERT INTO Discounts
VALUES ('BOGO', 50, 'Buy one night, get one night free.');
INSERT INTO Discounts
VALUES ('President\'s Day Weekend', 75, 'Come celebrate president\'s day weekend with us!');

CREATE TABLE IF NOT EXISTS Advertisements (
    Name VARCHAR(200) PRIMARY KEY,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    Cost INTEGER NOT NULL,
    HostAdvertiser VARCHAR(50),
    PlannerAdvertiser VARCHAR(50),
    FOREIGN KEY(HostAdvertiser)
           REFERENCES Hosts(Username),
    FOREIGN KEY(PlannerAdvertiser)
           REFERENCES Planners(Username)
);

INSERT INTO Advertisements(Name, StartDate, EndDate, Cost, HostAdvertiser)
VALUES ('Come have fun', CURRENT_TIMESTAMP, '2023-12-12T12:00:01', 25, 'harold72');
INSERT INTO Advertisements(Name, StartDate, EndDate, Cost, PlannerAdvertiser)
VALUES ('Merry Christmas', CURRENT_TIMESTAMP, '2023-12-23T12:00:01', 78, 'edwinh');

CREATE TABLE IF NOT EXISTS Itineraries (
    Name VARCHAR(200),
    TravelerOrganizer VARCHAR(50),
    PlannerOrganizer VARCHAR(50),
    TotalPrice INTEGER,
    PRIMARY KEY (Name),
    FOREIGN KEY(TravelerOrganizer)
           REFERENCES Travelers(Username),
    FOREIGN KEY(PlannerOrganizer)
           REFERENCES Planners(Username)
);

INSERT INTO Itineraries(Name, TravelerOrganizer, TotalPrice)
VALUES ('Best Vacay', 'ameliam', 100);
INSERT INTO Itineraries(Name, PlannerOrganizer, TotalPrice)
VALUES ('My First Itinerary', 'edwinh', 500);

CREATE TABLE IF NOT EXISTS Pictures (
    LodgingName VARCHAR(200),
    City VARCHAR(100),
    ImageURL VARCHAR(500) PRIMARY KEY,
    Name VARCHAR(200),
    Description VARCHAR(1000),
    FOREIGN KEY(LodgingName, City)
           REFERENCES Lodgings(Name, City)
);

INSERT INTO Pictures
VALUES ('The Lodge', 'Frankfort', 'imageurl.com', 'OutsideView', 'View of outside.');
INSERT INTO Pictures
VALUES ('H&A B&B', 'Madison', 'imageurl2.com', 'CuteDecor', 'Look at how cute our decor is.');

CREATE TABLE IF NOT EXISTS Reviews (
    Poster VARCHAR(50),
    Target VARCHAR(200),
    Comment LONGTEXT NOT NULL,
    Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    Rating INTEGER NOT NULL,
    LodgingName VARCHAR(200),
    City VARCHAR(100),
    ActivityName VARCHAR(200),
    Location VARCHAR(100),
    PRIMARY KEY (Poster, Target),
    FOREIGN KEY(LodgingName, City)
           REFERENCES Lodgings(Name, City),
    FOREIGN KEY(ActivityName, Location)
           REFERENCES Activities(Name, Location)

);

INSERT INTO Reviews(Poster, Target, Comment, Rating, LodgingName, City)
VALUES ('Max', 'The Lodge', 'The Lodge sucks.', 0, 'The Lodge', 'Frankfort');
INSERT INTO Reviews(Poster, Target, Comment, Rating, ActivityName, Location)
VALUES ('Alex', 'Circus Review', 'Great experience!', 5, 'Circus', 'Wisconsin');

CREATE TABLE IF NOT EXISTS Trav_Act (
    Username VARCHAR(50),
    Name VARCHAR(200),
    Location VARCHAR(200),
    PRIMARY KEY (Username, Name, Location),
    FOREIGN KEY(Name, Location)
           REFERENCES Activities(Name, Location),
    FOREIGN KEY(Username)
           REFERENCES Travelers(Username)
);

INSERT INTO Trav_Act
VALUES ('ameliam', 'Circus', 'Wisconsin');
INSERT INTO Trav_Act
VALUES ('emanr', 'Tree climbing', 'California');

CREATE TABLE IF NOT EXISTS Trav_Lodg (
    Username VARCHAR(50),
    Name VARCHAR(200),
    City VARCHAR(200),
    PRIMARY KEY (Username, Name, City),
    FOREIGN KEY(Name, City)
           REFERENCES Lodgings(Name, City),
    FOREIGN KEY(Username)
           REFERENCES Travelers(Username)
);

INSERT INTO Trav_Lodg
VALUES ('ameliam', 'The Lodge', 'Frankfort');
INSERT INTO Trav_Lodg
VALUES ('emanr', 'H&A B&B', 'Madison');

CREATE TABLE IF NOT EXISTS Trav_Group (
    Username VARCHAR(50),
    Name VARCHAR(200),
    Organizer VARCHAR(50),
    PRIMARY KEY (Username, Name, Organizer),
    FOREIGN KEY(Name, Organizer)
           REFERENCES TravelGroups(Name, Organizer),
    FOREIGN KEY(Username)
           REFERENCES Travelers(Username)
);

INSERT INTO Trav_Group
VALUES ('ameliam', 'Amelia\'s Group', 'Amelia');
INSERT INTO Trav_Group
VALUES ('emanr', 'Emanual\'s Group', 'Emanual');

CREATE TABLE IF NOT EXISTS Host_Plan (
    HostUsername VARCHAR(50),
    PlannerName VARCHAR(50),
    PRIMARY KEY (HostUsername, PlannerName),
    FOREIGN KEY(HostUsername)
           REFERENCES Hosts(Username),
    FOREIGN KEY(PlannerName)
           REFERENCES Planners(Username)
);

INSERT INTO Host_Plan
VALUES ('harold72', 'edwinh');
INSERT INTO Host_Plan
VALUES ('Agnes72', 'edwinh');

CREATE TABLE IF NOT EXISTS Host_Disc (
    Username VARCHAR(50),
    Name VARCHAR(200),
    DealPercent INTEGER,
    PRIMARY KEY (Username, Name, DealPercent),
    FOREIGN KEY(Name, DealPercent)
           REFERENCES Discounts(Name, DealPercent),
    FOREIGN KEY(Username)
           REFERENCES Hosts(Username)
);

INSERT INTO Host_Disc
VALUES ('harold72', 'BOGO', 50);
INSERT INTO Host_Disc
VALUES ('Agnes72', 'President\'s Day Weekend', 75);

CREATE TABLE IF NOT EXISTS Plan_Disc (
    Username VARCHAR(50),
    Name VARCHAR(200),
    DealPercent INTEGER,
    PRIMARY KEY (Username, Name, DealPercent),
    FOREIGN KEY(Name, DealPercent)
           REFERENCES Discounts(Name, DealPercent),
    FOREIGN KEY(Username)
           REFERENCES Planners(Username)
);

INSERT INTO Plan_Disc
VALUES ('edwinh', 'BOGO', 50);
INSERT INTO Plan_Disc
VALUES ('georgew', 'President\'s Day Weekend', 75);

CREATE TABLE IF NOT EXISTS Trav_Plan (
    TravelerUsername VARCHAR(50),
    PlannerUsername VARCHAR(50),
    PRIMARY KEY (TravelerUsername, PlannerUsername),
    FOREIGN KEY(TravelerUsername)
           REFERENCES Travelers(Username),
    FOREIGN KEY(PlannerUsername)
           REFERENCES Planners(Username)
);

INSERT INTO Trav_Plan
VALUES ('ameliam', 'edwinh');
INSERT INTO Trav_Plan
VALUES ('emanr', 'georgew');

CREATE TABLE IF NOT EXISTS Act_Itin (
    ActivityName VARCHAR(200),
    Location VARCHAR(200),
    ItineraryName VARCHAR(200),
    Datetime DATETIME NOT NULL,
    PRIMARY KEY (ActivityName, Location, ItineraryName),
    FOREIGN KEY(ActivityName, Location)
           REFERENCES Activities(Name, Location),
    FOREIGN KEY(ItineraryName)
           REFERENCES Itineraries(Name)
);

INSERT INTO Act_Itin
VALUES ('Circus', 'Wisconsin', 'Best vacay', CURRENT_TIMESTAMP);
INSERT INTO Act_Itin
VALUES ('Tree climbing', 'California', 'My first itinerary', CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS TravGroup_Members (
    Organizer VARCHAR(50),
    Name VARCHAR(200),
    Member VARCHAR(200),
    PRIMARY KEY (Organizer, Name, Member),
    FOREIGN KEY(Name, Organizer)
           REFERENCES TravelGroups(Name, Organizer)
);

INSERT INTO TravGroup_Members
VALUES ('Amelia', 'Amelia\'s Group', 'Max');
INSERT INTO TravGroup_Members
VALUES ('Emanual', 'Emanual\'s Group', 'Alex');

CREATE TABLE IF NOT EXISTS Trav_Likes_Dislikes (
    Username VARCHAR(50),
    Like_Dislike VARCHAR(200),
    PRIMARY KEY (Username, Like_Dislike),
    FOREIGN KEY(Username)
           REFERENCES Travelers(Username)
);

INSERT INTO Trav_Likes_Dislikes
VALUES ('ameliam', 'Drinking');
INSERT INTO Trav_Likes_Dislikes
VALUES ('emanr', 'Sleeping');

CREATE TABLE IF NOT EXISTS Adv_TargetAudience (
    Name VARCHAR(200),
    TargetAudience VARCHAR(200),
    PRIMARY KEY (Name, TargetAudience),
    FOREIGN KEY(Name)
           REFERENCES Advertisements(Name)
);

INSERT INTO Adv_TargetAudience
VALUES ('Come have fun', 'Kids');
INSERT INTO Adv_TargetAudience
VALUES ('Merry Christmas', 'Families');

CREATE TABLE IF NOT EXISTS Act_Restrictions (
    Name VARCHAR(200),
    Location VARCHAR(200),
    Restrictions VARCHAR(200),
    PRIMARY KEY (Name, Location, Restrictions),
    FOREIGN KEY(Name, Location)
           REFERENCES Activities(Name, Location)
);

INSERT INTO Act_Restrictions
VALUES ('Tree climbing', 'California', '18+');
INSERT INTO Act_Restrictions
VALUES ('Circus', 'Wisconsin', 'No alcohol');