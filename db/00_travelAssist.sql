SHOW DATABASES;
CREATE DATABASE TravelAssist;

grant all privileges on TravelAssist.* to 'webapp'@'%';
flush privileges;

USE TravelAssist;

-- Creating Hosts table and inserting 2 tuples
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

-- Creating Travelers table and inserting 2 tuples
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

-- Creating Planners table and inserting 2 tuples
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

-- Creating Activities table and inserting 2 tuples
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

-- Creating Lodgings table and inserting 2 tuples
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

-- Creating Rooms table and inserting 2 tuples
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

-- Creating TravelGroups table and inserting 2 tuples
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

-- Creating Discounts table and inserting 2 tuples
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

-- Creating Advertisements table and inserting 2 tuples
CREATE TABLE IF NOT EXISTS Advertisements (
    Name VARCHAR(200) PRIMARY KEY,
    StartDate DATETIME,
    EndDate DATETIME,
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

-- Creating Itineraries table and inserting 2 tuples
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

-- Creating Pictures table and inserting 2 tuples
CREATE TABLE IF NOT EXISTS Pictures (
    LodgingName VARCHAR(200),
    City VARCHAR(100),
    ImageURL VARCHAR(500),
    Name VARCHAR(200),
    Description VARCHAR(1000),
    PRIMARY KEY(ImageURL, Name),
    FOREIGN KEY(LodgingName, City)
           REFERENCES Lodgings(Name, City)
);

INSERT INTO Pictures
VALUES ('The Lodge', 'Frankfort', 'imageurl.com', 'OutsideView', 'View of outside.');
INSERT INTO Pictures
VALUES ('H&A B&B', 'Madison', 'imageurl2.com', 'CuteDecor', 'Look at how cute our decor is.');

-- Creating Reviews table and inserting 2 tuples
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
           ON DELETE CASCADE

);

INSERT INTO Reviews(Poster, Target, Comment, Rating, LodgingName, City)
VALUES ('Max', 'The Lodge', 'The Lodge sucks.', 0, 'The Lodge', 'Frankfort');
INSERT INTO Reviews(Poster, Target, Comment, Rating, ActivityName, Location)
VALUES ('Alex', 'Circus Review', 'Great experience!', 5, 'Circus', 'Wisconsin');

-- Creating Trav_Act table and inserting 2 tuples
CREATE TABLE IF NOT EXISTS Trav_Act (
    Username VARCHAR(50),
    Name VARCHAR(200),
    Location VARCHAR(200),
    PRIMARY KEY (Username, Name, Location),
    FOREIGN KEY(Name, Location)
           REFERENCES Activities(Name, Location)
           ON DELETE CASCADE,
    FOREIGN KEY(Username)
           REFERENCES Travelers(Username)
);

INSERT INTO Trav_Act
VALUES ('ameliam', 'Circus', 'Wisconsin');
INSERT INTO Trav_Act
VALUES ('emanr', 'Tree climbing', 'California');

-- Creating Trav_Lodg table and inserting 2 tuples
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

-- Creating Trav_Group table and inserting 2 tuples
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

-- Creating Host_Plan table and inserting 2 tuples
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

-- Creating Host_Disc table and inserting 2 tuples
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
VALUES ('Agnes72', "President\'s Day Weekend", 75);

-- Creating Plan_Disc table and inserting 2 tuples
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
VALUES ('georgew', "President\'s Day Weekend", 75);

-- Creating Trav_Plan table and inserting 2 tuples
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

-- Creating Act_Itin table and inserting 2 tuples
CREATE TABLE IF NOT EXISTS Act_Itin (
    ActivityName VARCHAR(200),
    Location VARCHAR(200),
    ItineraryName VARCHAR(200),
    Datetime DATETIME,
    PRIMARY KEY (ActivityName, Location, ItineraryName),
    FOREIGN KEY(ActivityName, Location)
           REFERENCES Activities(Name, Location)
           ON DELETE CASCADE,
    FOREIGN KEY(ItineraryName)
           REFERENCES Itineraries(Name)
);

INSERT INTO Act_Itin
VALUES ('Circus', 'Wisconsin', 'Best vacay', CURRENT_TIMESTAMP);
INSERT INTO Act_Itin
VALUES ('Tree climbing', 'California', 'My first itinerary', CURRENT_TIMESTAMP);

-- Creating TravGroup_Members table and inserting 2 tuples
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

-- Creating Trav_Likes_Dislikes table and inserting 2 tuples
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

-- Creating Adv_TargetAudience table and inserting 2 tuples
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

-- Creating Act_Restrictions table and inserting 2 tuples
CREATE TABLE IF NOT EXISTS Act_Restrictions (
    Name VARCHAR(200),
    Location VARCHAR(200),
    Restrictions VARCHAR(200),
    PRIMARY KEY (Name, Location, Restrictions),
    FOREIGN KEY(Name, Location)
           REFERENCES Activities(Name, Location)
           ON DELETE CASCADE
);

INSERT INTO Act_Restrictions
VALUES ('Tree climbing', 'California', '18+');
INSERT INTO Act_Restrictions
VALUES ('Circus', 'Wisconsin', 'No alcohol');

-- insert data for hosts table
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('hmaccoughen0','Hebert','MacCoughen','Bigender',1833771138,'hmaccoughen0@yellowpages.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('clevecque1','Cesare','Levecque','Male',1995410476,'clevecque1@spotify.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('vangrick2','Vitoria','Angrick','Female',1511763061,'vangrick2@goo.gl',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('dbrogi3','Dennis','Brogi','Male',1644577344,'dbrogi3@nps.gov',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('jquarton4','Jayme','Quarton','Female',1450928665,'jquarton4@meetup.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('srosengarten5','Sondra','Rosengarten','Female',1994549178,'srosengarten5@amazon.co.uk',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('jjarmyn6','Julina','Jarmyn','Female',1532551290,'jjarmyn6@indiegogo.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('ctomczykiewicz7','Coletta','Tomczykiewicz','Female',1219490508,'ctomczykiewicz7@imdb.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('lmendes8','Lira','Mendes','Polygender',1087994541,'lmendes8@zdnet.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('kmellenby9','Keary','Mellenby','Male',1586598573,'kmellenby9@geocities.jp',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('ssevina','Scotty','Sevin','Male',1184248071,'ssevina@twitter.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('tcastelloneb','Thalia','Castellone','Female',1923873988,'tcastelloneb@mail.ru',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('cfrancaisc','Christiana','Francais','Female',1209875478,'cfrancaisc@apple.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('cgymblettd','Celestyn','Gymblett','Female',1522363006,'cgymblettd@va.gov',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('tdavione','Toddie','Davion','Agender',1362528715,'tdavione@noaa.gov',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('hsurcombef','Herb','Surcombe','Male',1245401873,'hsurcombef@cargocollective.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('cbrittong','Cynthy','Britton','Female',1611714716,'cbrittong@technorati.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('rfosberryh','Rand','Fosberry','Male',1387030133,'rfosberryh@springer.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('rnutoni','Rubie','Nuton','Female',1206729299,'rnutoni@fotki.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('jdeclercj','Julissa','de Clerc','Genderfluid',1851449666,'jdeclercj@histats.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('msellenk','Margarethe','Sellen','Female',1530374805,'msellenk@engadget.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('mhansterl','Morrie','Hanster','Male',1523798068,'mhansterl@ovh.net',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('rcoppensm','Roderic','Coppens','Male',1740589905,'rcoppensm@about.me',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('nceschinin','Nolly','Ceschini','Male',1769927259,'nceschinin@hexun.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('mharriagno','Montgomery','Harriagn','Male',1075679894,'mharriagno@rakuten.co.jp',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('lmarderp','Leigh','Marder','Male',1565816035,'lmarderp@ehow.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('rpenddrethq','Rici','Penddreth','Female',1220875340,'rpenddrethq@mlb.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('cgreguolir','Clea','Greguoli','Female',1089950318,'cgreguolir@chron.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('rpylkynytons','Rafaelia','Pylkynyton','Female',1754764176,'rpylkynytons@cnn.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('jhandyt','Jabez','Handy','Male',1033375553,'jhandyt@kickstarter.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('atonryu','Aurie','Tonry','Female',1402133472,'atonryu@google.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('wizkoviciv','Wat','Izkovici','Male',1587099742,'wizkoviciv@businessinsider.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('mlewendonw','Myrtle','Lewendon','Female',1747984438,'mlewendonw@imgur.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('lscrimshawx','Lian','Scrimshaw','Female',1525069979,'lscrimshawx@wufoo.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('roshavlany','Ruby','O''Shavlan','Male',1561824013,'roshavlany@yahoo.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('hslaffordz','Harper','Slafford','Bigender',1093488426,'hslaffordz@ftc.gov',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('fgrene10','Filide','Grene','Female',1532086966,'fgrene10@privacy.gov.au',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('tbalasini11','Theodor','Balasini','Male',1499210434,'tbalasini11@upenn.edu',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('bnapper12','Brewster','Napper','Genderqueer',1518268702,'bnapper12@qq.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('amayoh13','Alf','Mayoh','Male',1842283279,'amayoh13@newyorker.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('kquartly14','Kellsie','Quartly','Female',1400672600,'kquartly14@wiley.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('glulham15','Guthrey','Lulham','Non-binary',1746719534,'glulham15@howstuffworks.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('cfinci16','Cirstoforo','Finci','Male',1530794329,'cfinci16@ibm.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('icrudginton17','Irwin','Crudginton','Male',1586824237,'icrudginton17@newyorker.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('bhartle18','Barnie','Hartle','Male',1443540611,'bhartle18@washingtonpost.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('mweatherall19','Mata','Weatherall','Male',1570984209,'mweatherall19@issuu.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('lflear1a','Livy','Flear','Female',1556384861,'lflear1a@bandcamp.com',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('xgrangier1b','Xenos','Grangier','Male',1636128094,'xgrangier1b@cdc.gov',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('llowings1c','Lorita','Lowings','Female',1823726336,'llowings1c@sakura.ne.jp',NULL);
INSERT INTO Hosts(Username,FirstName,LastName,Gender,PhoneNumber,Email,HostPartner) VALUES ('jbarthod1d','Jillene','Barthod','Female',1082555870,'jbarthod1d@surveymonkey.com',NULL);

-- insert data for travelers table
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('scansdill0','Sumner','Cansdill','Male',1,'scansdill0@constantcontact.com',3868);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('rskate1','Rollo','Skate','Male',80,'rskate1@unblog.fr',9403);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('cmarikhin2','Cody','Marikhin','Agender',20,'cmarikhin2@pagesperso-orange.fr',1319);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('sprothero3','Sully','Prothero','Male',45,'sprothero3@edublogs.org',2829);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('mcush4','Meghan','Cush','Female',21,'mcush4@tiny.cc',9102);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('imccullouch5','Iorgo','McCullouch','Male',62,'imccullouch5@mapy.cz',9828);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('lkittles6','Leland','Kittles','Male',82,'lkittles6@macromedia.com',984);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('flankham7','Foster','Lankham','Male',35,'flankham7@abc.net.au',4064);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('bsalter8','Berke','Salter','Male',64,'bsalter8@acquirethisname.com',6650);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('ablind9','Atalanta','Blind','Female',18,'ablind9@gizmodo.com',6275);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('psiegertsza','Pyotr','Siegertsz','Male',7,'psiegertsza@europa.eu',3423);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('vphilpb','Vladamir','Philp','Male',63,'vphilpb@google.nl',2010);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('fmcleodc','Fabiano','McLeod','Male',3,'fmcleodc@chronoengine.com',1412);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('rtschirschkyd','Reggy','Tschirschky','Male',22,'rtschirschkyd@blog.com',2797);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('rsmithsone','Rand','Smithson','Male',57,'rsmithsone@etsy.com',8765);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('eliddyf','Enrique','Liddy','Polygender',20,'eliddyf@bluehost.com',304);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('jblinkhorng','Jemimah','Blinkhorn','Female',30,'jblinkhorng@paypal.com',2419);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('mshobrookh','Malina','Shobrook','Female',68,'mshobrookh@elpais.com',1617);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('lnanii','Luelle','Nani','Female',25,'lnanii@wisc.edu',211);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('kmaccallesterj','Karlen','MacCallester','Genderfluid',39,'kmaccallesterj@comcast.net',3814);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('vrubinowk','Vally','Rubinow','Female',72,'vrubinowk@mediafire.com',4488);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('zborlandl','Zora','Borland','Female',62,'zborlandl@fda.gov',9964);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('rcullabinem','Rorke','Cullabine','Male',74,'rcullabinem@ocn.ne.jp',2680);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('mirvingn','Mattheus','Irving','Male',27,'mirvingn@wikispaces.com',6463);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('tfullstoneo','Trenton','Fullstone','Male',85,'tfullstoneo@slashdot.org',6187);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('fbissetp','Flss','Bisset','Female',82,'fbissetp@sakura.ne.jp',8143);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('lgrimshawq','Luisa','Grimshaw','Female',78,'lgrimshawq@opera.com',9168);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('hjerrardr','Hartwell','Jerrard','Male',73,'hjerrardr@redcross.org',166);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('cbaudrys','Corbie','Baudry','Male',29,'cbaudrys@dion.ne.jp',4303);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('wstirript','Wait','Stirrip','Male',55,'wstirript@army.mil',4265);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('jseekingsu','Julieta','Seekings','Female',14,'jseekingsu@squidoo.com',6424);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('edetloffv','Elsey','Detloff','Female',82,'edetloffv@163.com',11);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('cbleasdalew','Clerkclaude','Bleasdale','Male',29,'cbleasdalew@acquirethisname.com',3350);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('nreaperx','Nana','Reaper','Female',18,'nreaperx@phoca.cz',6213);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('mpiensy','Milena','Piens','Female',91,'mpiensy@smugmug.com',4501);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('cdavitashviliz','Charis','Davitashvili','Female',30,'cdavitashviliz@webnode.com',4446);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('hmoulton10','Huey','Moulton','Male',100,'hmoulton10@shutterfly.com',2734);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('tsheppey11','Tybie','Sheppey','Female',74,'tsheppey11@friendfeed.com',6017);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('vdeyenhardt12','Vina','Deyenhardt','Female',91,'vdeyenhardt12@wikimedia.org',3779);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('cchilds13','Caterina','Childs','Bigender',41,'cchilds13@qq.com',1613);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('mslessar14','Maridel','Slessar','Genderqueer',14,'mslessar14@businesswire.com',4359);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('lkelberer15','Layla','Kelberer','Female',65,'lkelberer15@sun.com',441);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('rpassler16','Rafe','Passler','Male',64,'rpassler16@icio.us',6402);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('sdruett17','Sophey','Druett','Female',25,'sdruett17@netscape.com',1107);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('hboag18','Hanson','Boag','Male',19,'hboag18@sphinn.com',6725);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('cdcruze19','Charline','D''Cruze','Female',16,'cdcruze19@who.int',240);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('ispratt1a','Irvin','Spratt','Male',76,'ispratt1a@yelp.com',2944);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('gstodart1b','Gwenette','Stodart','Female',100,'gstodart1b@livejournal.com',9892);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('showles1c','Spense','Howles','Male',24,'showles1c@weebly.com',1255);
INSERT INTO Travelers(Username,FirstName,LastName,Gender,Age,Email,Budget) VALUES ('spurdom1d','Stu','Purdom','Male',56,'spurdom1d@irs.gov',6696);

-- insert data for planners table
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('abernardinelli0','Aurelea','Bernardinelli',1647296158,'abernardinelli0@diigo.com',779,'5-10 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('hindgs1','Hamilton','Indgs',1731425777,'hindgs1@wufoo.com',822,'None');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('phasnip2','Pincas','Hasnip',1557485952,'phasnip2@amazon.co.uk',999,'10+ years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('fphayre3','Felecia','Phayre',1246866226,'fphayre3@unesco.org',92,'10+ years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('chainey4','Coriss','Hainey`',1633749904,'chainey4@jimdo.com',980,'None');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('bmclardie5','Barclay','McLardie',1818132670,'bmclardie5@nsw.gov.au',675,'5-10 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('ngyse6','Nessa','Gyse',1920459032,'ngyse6@europa.eu',953,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('xwibrow7','Xenos','Wibrow',1220194442,'xwibrow7@mashable.com',669,'1-2 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('dblanden8','Darla','Blanden',1331098513,'dblanden8@howstuffworks.com',866,'10+ years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('bmccaghan9','Bernadene','McCaghan',1052897078,'bmccaghan9@comsenz.com',284,'1-2 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('rhampshawa','Robena','Hampshaw',1598774742,'rhampshawa@ycombinator.com',327,'5-10 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('swickendonb','Sarene','Wickendon',1497211085,'swickendonb@elegantthemes.com',839,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('hingramc','Hebert','Ingram',1772749423,'hingramc@amazon.co.uk',744,'5-10 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('hkenderd','Hill','Kender',1421145956,'hkenderd@squidoo.com',356,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('cbidgode','Connie','Bidgod',1915598110,'cbidgode@macromedia.com',561,'1-2 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('sslatenf','Susi','Slaten',1587493923,'sslatenf@moonfruit.com',773,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('estatherg','Eachelle','Stather',1437332551,'estatherg@paypal.com',112,'10+ years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('lbowrah','Luca','Bowra',1983558352,'lbowrah@ucoz.com',115,'10+ years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('hattfieldi','Harrie','Attfield',1105890617,'hattfieldi@histats.com',187,'None');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('ikolodziejj','Ira','Kolodziej',1773497717,'ikolodziejj@taobao.com',800,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('pturpiek','Phillida','Turpie',1302525931,'pturpiek@soundcloud.com',136,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('skitherl','Sib','Kither',1023371731,'skitherl@qq.com',369,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('theersm','Tedie','Heers',1188660956,'theersm@1und1.de',346,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('jsetteringtonn','Jeth','Setterington',1176091553,'jsetteringtonn@bbb.org',261,'5-10 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('jsidaryo','Joane','Sidary',1817254533,'jsidaryo@yelp.com',902,'None');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('bdupreyp','Barri','Duprey',1097254753,'bdupreyp@npr.org',781,'None');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('cdenisovichq','Cherida','Denisovich',1663748494,'cdenisovichq@goo.ne.jp',468,'None');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('fbengerr','Farra','Benger',1696084000,'fbengerr@netvibes.com',73,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('fdimitrievs','Florie','Dimitriev',1092691622,'fdimitrievs@stumbleupon.com',307,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('rroscowt','Rickie','Roscow',1632104225,'rroscowt@admin.ch',356,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('cchaplainu','Candy','Chaplain',1149623048,'cchaplainu@usnews.com',451,'5-10 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('oubachv','Orelia','Ubach',1885925045,'oubachv@timesonline.co.uk',598,'None');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('gprevettw','Gerta','Prevett',1732813069,'gprevettw@hugedomains.com',676,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('rrobinetx','Randi','Robinet',1878371364,'rrobinetx@sbwire.com',553,'10+ years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('lswatey','Lenette','Swate',1064747485,'lswatey@slideshare.net',347,'5-10 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('eaynscombez','Elston','Aynscombe',1682263708,'eaynscombez@google.ca',7,'10+ years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('lashby10','Loy','Ashby',1772789190,'lashby10@comcast.net',352,'10+ years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('lwoollam11','Licha','Woollam',1517675840,'lwoollam11@instagram.com',179,'10+ years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('torford12','Thekla','Orford',1533081108,'torford12@va.gov',647,'1-2 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('dfriatt13','Dorie','Friatt',1463234563,'dfriatt13@oracle.com',919,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('wditty14','Woodrow','Ditty',1299727308,'wditty14@elegantthemes.com',28,'None');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('nomullaney15','Nicky','O''Mullaney',1354889114,'nomullaney15@nps.gov',565,'5-10 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('ydodsworth16','Yoshiko','Dodsworth',1033680897,'ydodsworth16@blinklist.com',209,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('wghilardi17','Worthington','Ghilardi',1679876024,'wghilardi17@ycombinator.com',397,'1-2 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('bantoniutti18','Bonnee','Antoniutti',1700809638,'bantoniutti18@amazonaws.com',811,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('scarayol19','Sharron','Carayol',1804338624,'scarayol19@e-recht24.de',644,'5-10 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('adrogan1a','Antonio','Drogan',1146862440,'adrogan1a@joomla.org',857,'3-5 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('bkarpushkin1b','Billye','Karpushkin',1696880924,'bkarpushkin1b@prlog.org',799,'10+ years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('mtownes1c','Maurizio','Townes',1927286910,'mtownes1c@forbes.com',633,'5-10 years');
INSERT INTO Planners(Username,FirstName,LastName,PhoneNumber,Email,Fees,ExperienceLevel) VALUES ('bgerhold1d','Benton','Gerhold',1155026355,'bgerhold1d@mapy.cz',259,'5-10 years');

-- insert data for activities table
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Grimes-Lemke','Morbi porttitor lorem id ligula.','Chamical','Museum',30,58,'msellenk');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Williamson-Gottlieb','Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.','Joliet','Show',483,44,'hslaffordz');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Marks Inc','Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.','Storozhnytsya','Outdoors',467,47,'ssevina');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('O''Keefe-Toy','Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.','Malabar','Indoors',201,41,'xgrangier1b');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Cassin-Klocko','Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.','Yangchun','Show',305,97,'rpylkynytons');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Daniel, Roob and Schultz','Donec ut dolor.','Panamá','Fitness',380,56,'kquartly14');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Gleason-Roob','Donec semper sapien a libero. Nam dui.','Kyshtym','Show',123,2,'bnapper12');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Padberg-Schmitt','Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.','Shihuajian','Fitness',403,72,'mharriagno');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Kris Group','Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.','Hexing','Indoors',236,24,'xgrangier1b');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('White, Beer and Flatley','Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.','Carapicuíba','Indoors',465,59,'hsurcombef');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Braun Inc','Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui.','Rogów','Show',306,1,'fgrene10');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Legros-Mitchell','Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.','Szubin','Show',100,4,'mhansterl');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Hilpert-Konopelski','Proin leo odio, porttitor id, consequat in, consequat ut, nulla.','Kalanchak','Show',337,32,'lflear1a');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Ortiz, Boyer and Gottlieb','In congue. Etiam justo. Etiam pretium iaculis justo.','Yanggu','Show',427,83,'rcoppensm');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Conroy-Schiller','Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.','Margotuhu Kidul','Fitness',353,5,'wizkoviciv');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Marquardt-Schmitt','Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.','Andongrejo','Museum',351,17,'mharriagno');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Pfannerstill-Hauck','Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.','Kromasan','Indoors',287,18,'lflear1a');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Fay LLC','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.','Al Manşūrah','Indoors',317,88,'icrudginton17');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Kirlin, Rau and Russel','Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.','Chía','Fitness',2,71,'srosengarten5');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Howe, Runte and Romaguera','Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.','Oslo','Indoors',27,72,'fgrene10');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Reynolds, Lockman and Steuber','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.','Péfki','Fitness',67,68,'rpenddrethq');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Schuppe-Abernathy','Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.','Metlika','Show',237,75,'rpylkynytons');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Quigley-Glover','Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.','Hidalgo','Fitness',1,71,'hsurcombef');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Franecki Inc','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.','Monastyryshche','Indoors',29,55,'bhartle18');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Cassin, Schimmel and Kshlerin','Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.','Mascote','Museum',379,78,'msellenk');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Hamill, Quigley and Johns','Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.','Lyuban’','Museum',492,17,'mharriagno');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Langosh and Sons','Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.','Loures','Indoors',2,84,'cfinci16');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Bergnaum and Sons','Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.','El Hermel','Museum',233,72,'rcoppensm');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Nienow and Sons','Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.','Blagnac','Indoors',193,1,'tdavione');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Bergstrom-Fisher','Proin eu mi.','Batu','Show',249,84,'jquarton4');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Collier LLC','Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.','Santa Luzia','Outdoors',327,1,'jdeclercj');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Haley and Sons','Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.','Sima','Indoors',57,52,'mhansterl');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Romaguera Inc','Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.','Guangfu','Show',290,43,'hslaffordz');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Jacobs and Sons','Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.','Gombong','Fitness',63,11,'clevecque1');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Kassulke-Harvey','Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.','El Águila','Indoors',143,78,'msellenk');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Kuhn-Wilderman','Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst.','Ambato Boeny','Outdoors',496,23,'kquartly14');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Wolff-Stark','In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.','Alcorriol','Outdoors',484,88,'icrudginton17');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Hagenes-Grady','Pellentesque ultrices mattis odio. Donec vitae nisi.','Krechevitsy','Museum',469,69,'cgymblettd');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Wehner Inc','Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.','Lindian','Indoors',167,51,'tbalasini11');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Hammes-Rath','Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.','Privodino','Show',426,28,'hslaffordz');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Kihn-Williamson','Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.','Katipunan','Museum',163,99,'jhandyt');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Bailey Group','Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.','Xieshui','Show',345,86,'jbarthod1d');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Nienow-Wisozk','Phasellus id sapien in sapien iaculis congue.','Piraju','Outdoors',213,55,'cgymblettd');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Wilkinson Inc','Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.','Alkmaar','Show',229,50,'lmendes8');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Haag Inc','Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.','Novokayakent','Show',421,52,'fgrene10');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Heathcote-Botsford','Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.','Tangnan','Outdoors',432,7,'bnapper12');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Hamill-Koelpin','Etiam justo.','Henggang','Indoors',424,44,'hslaffordz');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Vandervort and Sons','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.','Pereleshino','Fitness',490,67,'srosengarten5');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Tillman, Grimes and Sipes','Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.','Lons-le-Saunier','Outdoors',355,95,'mweatherall19');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Lakin, Thiel and Kris','Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.','Dongxiang','Outdoors',462,47,'jjarmyn6');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Zieme, Tromp and Rau','Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.','Pô','Indoors',2,61,'jjarmyn6');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Jast Inc','Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.','Gongjiahe','Fitness',247,35,'rpylkynytons');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Effertz, Murphy and Herman','Vivamus tortor. Duis mattis egestas metus.','Beiyang','Show',120,91,'atonryu');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Graham, Mitchell and Hudson','Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.','Dzhayrakh','Indoors',345,56,'xgrangier1b');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Kessler LLC','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.','Lianshi','Fitness',318,79,'wizkoviciv');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Hoppe, Dare and Daugherty','Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.','Papeete','Indoors',119,80,'wizkoviciv');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Pouros-Green','Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.','Huafeng','Indoors',223,84,'jquarton4');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Cole Inc','Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.','Grojec','Indoors',450,12,'cbrittong');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Hegmann-Wunsch','Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.','Zhifang','Indoors',152,20,'tbalasini11');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Goodwin LLC','Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.','Huangdimiao','Outdoors',443,56,'mweatherall19');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Murphy and Sons','Donec semper sapien a libero. Nam dui.','Estância Velha','Outdoors',471,13,'hmaccoughen0');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Mohr Inc','Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante.','Demak','Fitness',348,78,'rnutoni');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Osinski and Sons','Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.','Elmira','Museum',430,66,'bhartle18');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Toy, Hirthe and Willms','Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.','Limulan','Museum',119,7,'nceschinin');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Simonis-Sipes','Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst.','Llocllapampa','Fitness',317,92,'roshavlany');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Leuschke-Bergstrom','Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.','Pokrov','Indoors',62,45,'jjarmyn6');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Hackett LLC','Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.','Galátsi','Museum',176,86,'mhansterl');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Stoltenberg-Thompson','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.','Xinghe Chengguanzhen','Fitness',253,30,'lmendes8');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Batz and Sons','Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.','Pereyaslav-Khmel’nyts’kyy','Outdoors',223,10,'lscrimshawx');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Runolfsdottir LLC','Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.','Jambean','Indoors',406,55,'lflear1a');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Wintheiser-Douglas','Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.','Ranambeling','Outdoors',369,52,'cbrittong');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('D''Amore, Weissnat and Hansen','Aliquam non mauris.','Huangsha','Fitness',294,94,'roshavlany');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Greenholt Group','Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.','Sacramento','Museum',223,23,'wizkoviciv');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Witting-Fisher','In sagittis dui vel nisl.','La Courneuve','Outdoors',197,97,'vangrick2');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Hagenes LLC','In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.','Renxian','Indoors',413,11,'xgrangier1b');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Breitenberg-Cummerata','Fusce consequat.','Kuvshinovo','Indoors',216,16,'tdavione');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Reichel Inc','Donec dapibus. Duis at velit eu est congue elementum.','Unidad','Indoors',5,58,'mharriagno');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('VonRueden-Spinka','Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.','Gândara','Outdoors',52,31,'jdeclercj');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Flatley, Gerhold and Reinger','Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.','Meruge','Outdoors',360,30,'lscrimshawx');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Macejkovic and Sons','Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum.','Gowa','Outdoors',486,14,'cfinci16');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Oberbrunner, Kris and Morar','Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.','Pretoria','Museum',60,99,'lscrimshawx');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Hirthe Group','Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.','Victoriaville','Outdoors',52,96,'mweatherall19');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Schaefer-Breitenberg','Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.','Brckovljani','Indoors',266,69,'roshavlany');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Gorczany-Erdman','Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.','Neftekamsk','Museum',483,44,'cgymblettd');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Lindgren LLC','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.','Jejkowice','Fitness',238,8,'mhansterl');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Parisian-Lynch','Integer ac neque.','Ingenio La Esperanza','Indoors',433,24,'rnutoni');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Rosenbaum-Kuhic','Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.','Bonoua','Show',488,82,'cgymblettd');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Morar-McDermott','In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.','Libacao','Fitness',475,36,'clevecque1');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Rutherford LLC','Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.','Senglea','Museum',158,23,'jjarmyn6');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Mayert and Sons','Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.','Pellegrini','Show',109,92,'hslaffordz');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Hilpert LLC','In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.','San Roque','Outdoors',228,72,'icrudginton17');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Koss, Bins and Blick','Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.','Kimil’tey','Indoors',234,3,'tdavione');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Hammes, Donnelly and Lowe','Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.','Napenay','Museum',209,81,'jhandyt');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Klocko and Sons','In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.','Palatine','Fitness',74,65,'mharriagno');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Daugherty, Keebler and Rau','Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.','Ash Shaykh ‘Uthmān','Indoors',434,15,'lflear1a');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Daugherty-Waelchi','Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.','Waterloo','Indoors',367,58,'cfrancaisc');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('DuBuque-Koelpin','Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum.','Capitán Bermúdez','Outdoors',301,63,'llowings1c');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Lakin, Dickens and Runte','Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.','Lianhe','Fitness',233,19,'cbrittong');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Bins, Marvin and Bednar','Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque.','Coruña, A','Museum',394,88,'jbarthod1d');
INSERT INTO Activities(Name,Description,Location,Category,Price,Availability,HostUser) VALUES ('Hegmann and Sons','Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.','Astghadzor','Outdoors',73,37,'atonryu');

-- insert data for lodgings table
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Kautzer LLC','Ouidah','Benin',NULL,'School',8147,42139,1726845239,'wizkoviciv');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Orn, Nader and McDermott','Yulin','China',NULL,'Division',17,70672,1256124262,'mhansterl');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Howe-Pfeffer','Zhaoxian','China',NULL,'Anderson',0181,85847,1355329670,'hsurcombef');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Terry LLC','Ketangi','Indonesia',NULL,'Packers',84722,58007,1870608824,'jdeclercj');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Conroy LLC','Malbork','Poland',NULL,'Debs',79,51380,1596510182,'bnapper12');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Conroy Group','Waingapu','Indonesia',NULL,'Clemons',9,79163,1024374848,'bnapper12');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Lind-Stroman','Ushi','Armenia',NULL,'Kenwood',9369,26467,1369648074,'jjarmyn6');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Reinger, Sporer and Marvin','Lelystad','Netherlands','Provincie Flevoland','Nobel',9180,88075,1015605612,'cfinci16');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Walsh, Denesik and Tromp','Nongoma','South Africa',NULL,'Porter',1339,90356,1958218844,'atonryu');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Wolf, Treutel and Hansen','Leiria','Portugal','Leiria','Gale',98,44251,1671578135,'rnutoni');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Fahey Inc','Zvenyhorodka','Ukraine',NULL,'Troy',0,19323,1750639967,'rnutoni');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Towne-Wisoky','Netolice','Czech Republic',NULL,'Forest',41082,41632,1844529426,'cfrancaisc');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Dickinson-Jerde','Fufang','China',NULL,'Golf',1,84345,1745219151,'hmaccoughen0');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Murray Group','Lenīnskīy','Kazakhstan',NULL,'Rusk',6270,31979,1573257139,'atonryu');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Aufderhar, Zieme and Halvorson','Himeji','Japan',NULL,'Tennyson',588,50302,1772915107,'rpenddrethq');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Hamill Group','Paris 16','France','Île-de-France','Moland',41,57330,1078450930,'jhandyt');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Sanford-Willms','Santa Fé do Sul','Brazil',NULL,'Bultman',25,96091,1149905139,'rfosberryh');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Weimann, Lockman and Schuppe','Luchenza','Malawi',NULL,'Moland',8,69325,1464270375,'clevecque1');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('D''Amore-Reichert','Panyingkiran','Indonesia',NULL,'Almo',22,55517,1697891785,'mhansterl');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Deckow-Rempel','Tarascon','France','Provence-Alpes-Côte d''Azur','Old Gate',50,74849,1962854802,'cgymblettd');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Purdy LLC','Ashibetsu','Japan',NULL,'Lakewood',65,68526,1557193240,'ssevina');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Dietrich-Keebler','Chixi','China',NULL,'Farmco',07643,20703,1768796747,'ctomczykiewicz7');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Howe and Sons','Kawalimukti','Indonesia',NULL,'Debs',68123,87830,1494057069,'roshavlany');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Renner, Wuckert and Dietrich','Anjie','China',NULL,'Kennedy',837,50426,1797273932,'cfinci16');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Jast-Rutherford','Saint Croix','U.S. Virgin Islands',NULL,'Arrowood',65,34044,1488901961,'kquartly14');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Luettgen LLC','Hongxi','China',NULL,'Fieldstone',5,47950,1681640916,'mhansterl');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Lehner, Shields and Ebert','El Viejo','Nicaragua',NULL,'Crownhardt',7979,75846,1736258898,'hmaccoughen0');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Walker LLC','Darwin','Argentina',NULL,'Spohn',9691,40346,1541803227,'amayoh13');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Larson, Bechtelar and Witting','Sanhe','China',NULL,'Hermina',25080,25938,1148864839,'hsurcombef');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Lockman LLC','Stockholm','Sweden','Stockholm','Burning Wood',031,46376,1510585092,'wizkoviciv');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Harvey Group','Blobo','Indonesia',NULL,'Comanche',2184,41563,1442095533,'wizkoviciv');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Cartwright and Sons','Tegalsari','Indonesia',NULL,'Ridgeway',406,32568,1181932313,'clevecque1');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Lang-D''Amore','Jiangluo','China',NULL,'Prentice',481,18855,1505210737,'lmarderp');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Abbott-Emard','Alegrete','Brazil',NULL,'Hollow Ridge',499,77008,1948778088,'roshavlany');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Williamson Inc','Žiželice','Czech Republic',NULL,'Sutherland',9443,46570,1510254569,'jhandyt');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Balistreri Inc','Tomakomai','Japan',NULL,'Service',4,31926,1652348824,'rcoppensm');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Padberg, Cremin and Berge','Smolenka','Russia',NULL,'Derek',45222,53100,1066994890,'dbrogi3');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Schimmel, Schultz and Gerhold','Parczew','Poland',NULL,'Bashford',8,47829,1251185547,'cgreguolir');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('McClure LLC','Mthatha','South Africa',NULL,'Westport',3094,61711,1352529815,'rfosberryh');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Macejkovic Group','Dalumangcob','Philippines',NULL,'West',70456,31080,1922056923,'mharriagno');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Simonis-Lind','Rio Grande da Serra','Brazil',NULL,'Toban',1091,61980,1060181113,'vangrick2');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Conroy Group','Atap','Indonesia',NULL,'Grasskamp',20977,42982,1603659223,'rpenddrethq');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Simonis Inc','Villa Ocampo','Argentina',NULL,'Maryland',5,15339,1385325884,'hmaccoughen0');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Hand Group','Itupiranga','Brazil',NULL,'Northwestern',09,30445,1611634519,'mharriagno');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Kunde LLC','Sestroretsk','Russia',NULL,'Kenwood',7,45155,1508461354,'wizkoviciv');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Bode, Jacobson and Boyle','Matarraque','Portugal','Lisboa','Moose',3212,57513,1010496345,'bhartle18');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Dickens, McGlynn and Wisozk','Franca','Brazil',NULL,'Del Sol',38,22542,1410344058,'jquarton4');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Hermiston, Hammes and Orn','Santol','Philippines',NULL,'Burrows',4,84703,1527865586,'rfosberryh');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Streich, Smith and Reilly','Diriomo','Nicaragua',NULL,'Express',41439,86261,1160650397,'mweatherall19');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Jacobson-Hegmann','Nam Sách','Vietnam',NULL,'Cordelia',8723,79677,1522610901,'hsurcombef');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Fritsch, Barrows and Yost','Jinchang','China',NULL,'Ohio',13491,84037,1843937503,'jquarton4');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Satterfield LLC','Åkersberga','Sweden','Stockholm','6th',7260,58299,1610115884,'jhandyt');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Gutkowski, Crist and Stroman','Tiwi','Philippines',NULL,'Dakota',98,74848,1318477113,'dbrogi3');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Medhurst and Sons','Jinji','China',NULL,'South',92,73574,1211270971,'cfinci16');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Kirlin LLC','Manorom','Thailand',NULL,'Prairie Rose',8903,67580,1632101863,'xgrangier1b');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Carter-Kovacek','Olszanica','Poland',NULL,'Sullivan',1,62920,1924018921,'glulham15');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Block LLC','Poggio di Chiesanuova','San Marino',NULL,'Sheridan',89,29562,1543590029,'mhansterl');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Medhurst LLC','Valongo','Portugal','Vila Real','Service',23544,32478,1909442795,'msellenk');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Rutherford Inc','Mt Peto','Jamaica',NULL,'Golf',8951,81204,1646061363,'ssevina');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Gutmann-MacGyver','Manado','Indonesia',NULL,'Carioca',52311,78252,1097560550,'jquarton4');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Hansen-Lemke','Wasilków','Poland',NULL,'Grasskamp',16,14353,1565015480,'rnutoni');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Considine, Kerluke and Brown','Toulouse','France','Midi-Pyrénées','Stone Corner',9940,70942,1316114748,'cfinci16');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Hoeger, King and Veum','Mahdia','Guyana',NULL,'Hagan',02504,68023,1639466594,'lmendes8');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('McLaughlin-Schroeder','Zall-Dardhë','Albania',NULL,'Butternut',02290,82337,1850304077,'amayoh13');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Littel-Orn','Cali','Colombia',NULL,'Pearson',0081,47693,1662709797,'lscrimshawx');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Blanda LLC','Usa River','Tanzania',NULL,'Pierstorff',72468,85080,1441965292,'cgreguolir');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Yost, Botsford and Morar','Vĩnh Tường','Vietnam',NULL,'Clarendon',4,23122,1740443541,'jjarmyn6');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Roberts, Daniel and Feeney','Milwaukee','United States','Wisconsin','Meadow Ridge',0,42916,1248451081,'wizkoviciv');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Jacobs Inc','Göteborg','Sweden','Västra Götaland','Drewry',11,13557,1816806657,'mlewendonw');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Wyman, McKenzie and Ullrich','Dongbang','China',NULL,'Fieldstone',808,78836,1530215953,'icrudginton17');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Ziemann-Tremblay','Lodhrān','Pakistan',NULL,'Center',098,53675,1332355539,'mhansterl');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Wunsch and Sons','Senahú','Guatemala',NULL,'Sherman',1,84809,1951047203,'lmarderp');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Hansen-Herzog','Huaping','China',NULL,'Redwing',66019,98059,1365630495,'msellenk');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Cassin-Murray','Isfana','Kyrgyzstan',NULL,'Leroy',01,38699,1658514752,'xgrangier1b');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Mante-Collier','Kalamáta','Greece',NULL,'Caliangt',026,39089,1259826361,'tbalasini11');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Casper, Rowe and Effertz','Baziqiao','China',NULL,'Forest',26799,29713,1666649310,'lflear1a');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Ebert Group','Batangan','Indonesia',NULL,'Sheridan',0821,43480,1971829125,'hslaffordz');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Ryan, Blanda and Pacocha','Puutura','Indonesia',NULL,'Dottie',85189,45086,1388733977,'rpenddrethq');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Treutel-Dare','Rājshāhi','Bangladesh',NULL,'Pennsylvania',9158,20886,1923516732,'bhartle18');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Hermiston Inc','Porsgrunn','Norway','Telemark','Calypso',91888,48694,1081101449,'glulham15');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Ward LLC','Velingrad','Bulgaria',NULL,'Mayer',5,85971,1747290315,'jbarthod1d');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Roob-Rice','Reisdorf','Luxembourg',NULL,'Corry',3508,21422,1536410580,'bhartle18');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Erdman-Thompson','Corzuela','Argentina',NULL,'Lillian',2016,96616,1132475311,'atonryu');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('D''Amore-Price','Tongjiaxi','China',NULL,'Division',85556,12921,1480306911,'cgymblettd');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Spinka LLC','Falun','Sweden','Dalarna','Fallview',08,67289,1999756648,'xgrangier1b');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Kessler and Sons','Belos Ares','Portugal','Porto','Bowman',407,64480,1716991382,'ctomczykiewicz7');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Little, DuBuque and VonRueden','Warmare','Indonesia',NULL,'Huxley',7,70908,1005823241,'mlewendonw');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Dietrich Group','Elaiochóri','Greece',NULL,'Porter',1,58562,1853028268,'lflear1a');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Hickle and Sons','Penang','Indonesia',NULL,'Killdeer',43475,26126,1173359542,'wizkoviciv');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Romaguera, Volkman and McGlynn','Cestas','France','Aquitaine','Village',7413,49290,1221485821,'kmellenby9');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Sporer LLC','Siguinon','Philippines',NULL,'Birchwood',197,15125,1324032723,'rfosberryh');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Monahan, Bruen and Upton','Kliteh','Indonesia',NULL,'Sage',1,89803,1743303246,'srosengarten5');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Koss, Weber and Lueilwitz','Ainaži','Latvia',NULL,'Oneill',878,76549,1734774632,'cbrittong');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Ernser and Sons','Guanban','China',NULL,'Ronald Regan',7776,80852,1398934905,'hmaccoughen0');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('McLaughlin LLC','Sunbu','China',NULL,'Menomonie',1208,43254,1542595560,'mlewendonw');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Lueilwitz LLC','Xianshuigu','China',NULL,'New Castle',687,30449,1319360774,'rcoppensm');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Reinger, Corkery and Kutch','Chinch''ŏn','South Korea',NULL,'Karstens',990,10105,1758810335,'vangrick2');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Lind, Kulas and Morissette','Paulpietersburg','South Africa',NULL,'Kipling',89051,51573,1101504351,'nceschinin');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Leuschke Group','Valenciennes','France','Nord-Pas-de-Calais','Homewood',64,38825,1891096806,'lmarderp');
INSERT INTO Lodgings(Name,City,Country,Region,Street,Number,ZIP,PhoneNumber,HostUser) VALUES ('Stehr and Sons','Mayhan','Mongolia',NULL,'Lake View',1,56017,1330706224,'kquartly14');

-- insert data for rooms table
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Kautzer LLC','Ouidah',14,'Water',497,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Orn, Nader and McDermott','Yulin',16,'Water',283,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Howe-Pfeffer','Zhaoxian',2,'Wall',61,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Terry LLC','Ketangi',11,'Street',311,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Conroy LLC','Malbork',58,'Water',418,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Conroy Group','Waingapu',85,'Mountains',144,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Lind-Stroman','Ushi',48,'Mountains',149,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Reinger, Sporer and Marvin','Lelystad',36,'Street',159,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Walsh, Denesik and Tromp','Nongoma',26,'Trees',299,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Wolf, Treutel and Hansen','Leiria',38,'Trees',475,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Fahey Inc','Zvenyhorodka',100,'Trees',147,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Towne-Wisoky','Netolice',29,'Street',62,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Dickinson-Jerde','Fufang',34,'Trees',177,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Murray Group','Lenīnskīy',95,'Water',68,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Aufderhar, Zieme and Halvorson','Himeji',1,'Street',500,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Hamill Group','Paris 16',98,'Water',476,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Sanford-Willms','Santa Fé do Sul',21,'Trees',109,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Weimann, Lockman and Schuppe','Luchenza',73,'Water',27,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('D''Amore-Reichert','Panyingkiran',2,'Wall',346,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Deckow-Rempel','Tarascon',79,'Street',321,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Purdy LLC','Ashibetsu',75,'Mountains',22,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Dietrich-Keebler','Chixi',89,'Street',493,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Howe and Sons','Kawalimukti',73,'Wall',35,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Renner, Wuckert and Dietrich','Anjie',40,'Water',364,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Jast-Rutherford','Saint Croix',85,'Street',166,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Luettgen LLC','Hongxi',5,'Water',355,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Lehner, Shields and Ebert','El Viejo',47,'Street',227,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Walker LLC','Darwin',62,'Street',125,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Larson, Bechtelar and Witting','Sanhe',8,'Street',19,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Lockman LLC','Stockholm',9,'Water',468,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Harvey Group','Blobo',99,'Water',255,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Cartwright and Sons','Tegalsari',79,'Wall',386,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Lang-D''Amore','Jiangluo',45,'Trees',498,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Abbott-Emard','Alegrete',52,'Water',405,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Williamson Inc','Žiželice',23,'Trees',77,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Balistreri Inc','Tomakomai',15,'Street',276,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Padberg, Cremin and Berge','Smolenka',31,'Mountains',468,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Schimmel, Schultz and Gerhold','Parczew',37,'Water',317,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('McClure LLC','Mthatha',73,'Street',28,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Macejkovic Group','Dalumangcob',39,'Water',390,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Simonis-Lind','Rio Grande da Serra',95,'Mountains',144,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Conroy Group','Atap',90,'Mountains',181,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Simonis Inc','Villa Ocampo',62,'Trees',365,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Hand Group','Itupiranga',55,'Water',62,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Kunde LLC','Sestroretsk',1,'Trees',303,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Bode, Jacobson and Boyle','Matarraque',29,'Water',105,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Dickens, McGlynn and Wisozk','Franca',37,'Mountains',327,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Hermiston, Hammes and Orn','Santol',13,'Water',406,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Streich, Smith and Reilly','Diriomo',45,'Water',199,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Jacobson-Hegmann','Nam Sách',1,'Trees',208,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Fritsch, Barrows and Yost','Jinchang',77,'Mountains',235,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Satterfield LLC','Åkersberga',14,'Wall',186,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Gutkowski, Crist and Stroman','Tiwi',91,'Trees',401,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Medhurst and Sons','Jinji',17,'Water',83,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Kirlin LLC','Manorom',61,'Trees',331,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Carter-Kovacek','Olszanica',44,'Trees',152,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Block LLC','Poggio di Chiesanuova',42,'Trees',193,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Medhurst LLC','Valongo',14,'Trees',233,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Rutherford Inc','Mt Peto',60,'Water',468,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Gutmann-MacGyver','Manado',78,'Street',389,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Hansen-Lemke','Wasilków',5,'Wall',215,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Considine, Kerluke and Brown','Toulouse',55,'Water',27,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Hoeger, King and Veum','Mahdia',59,'Mountains',430,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('McLaughlin-Schroeder','Zall-Dardhë',84,'Water',373,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Littel-Orn','Cali',51,'Water',443,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Blanda LLC','Usa River',36,'Street',467,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Yost, Botsford and Morar','Vĩnh Tường',84,'Water',159,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Roberts, Daniel and Feeney','Milwaukee',67,'Water',358,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Jacobs Inc','Göteborg',46,'Water',295,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Wyman, McKenzie and Ullrich','Dongbang',43,'Water',450,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Ziemann-Tremblay','Lodhrān',90,'Wall',465,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Wunsch and Sons','Senahú',49,'Wall',461,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Hansen-Herzog','Huaping',55,'Street',491,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Cassin-Murray','Isfana',93,'Water',165,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Mante-Collier','Kalamáta',72,'Water',311,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Casper, Rowe and Effertz','Baziqiao',79,'Water',378,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Ebert Group','Batangan',45,'Street',464,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Ryan, Blanda and Pacocha','Puutura',24,'Mountains',23,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Treutel-Dare','Rājshāhi',10,'Street',12,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Hermiston Inc','Porsgrunn',2,'Trees',130,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Ward LLC','Velingrad',92,'Street',440,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Roob-Rice','Reisdorf',52,'Mountains',446,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Erdman-Thompson','Corzuela',84,'Street',259,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('D''Amore-Price','Tongjiaxi',16,'Street',431,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Spinka LLC','Falun',87,'Water',372,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Kessler and Sons','Belos Ares',69,'Water',459,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Little, DuBuque and VonRueden','Warmare',83,'Street',383,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Dietrich Group','Elaiochóri',68,'Water',308,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Hickle and Sons','Penang',96,'Wall',16,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Romaguera, Volkman and McGlynn','Cestas',56,'Water',495,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Sporer LLC','Siguinon',20,'Water',482,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Monahan, Bruen and Upton','Kliteh',54,'Water',352,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Koss, Weber and Lueilwitz','Ainaži',13,'Water',499,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Ernser and Sons','Guanban',80,'Water',130,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('McLaughlin LLC','Sunbu',2,'Water',316,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Lueilwitz LLC','Xianshuigu',90,'Wall',101,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Reinger, Corkery and Kutch','Chinch''ŏn',37,'Mountains',167,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Lind, Kulas and Morissette','Paulpietersburg',30,'Trees',28,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Leuschke Group','Valenciennes',22,'Street',426,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Stehr and Sons','Mayhan',17,'Mountains',400,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Kautzer LLC','Ouidah',74,'Wall',279,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Orn, Nader and McDermott','Yulin',62,'Mountains',401,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Howe-Pfeffer','Zhaoxian',66,'Street',40,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Terry LLC','Ketangi',88,'Mountains',91,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Conroy LLC','Malbork',54,'Mountains',259,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Conroy Group','Waingapu',68,'Water',36,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Lind-Stroman','Ushi',33,'Mountains',385,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Reinger, Sporer and Marvin','Lelystad',88,'Mountains',57,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Walsh, Denesik and Tromp','Nongoma',30,'Mountains',350,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Wolf, Treutel and Hansen','Leiria',97,'Wall',279,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Fahey Inc','Zvenyhorodka',8,'Wall',208,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Towne-Wisoky','Netolice',58,'Wall',138,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Dickinson-Jerde','Fufang',4,'Trees',15,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Murray Group','Lenīnskīy',39,'Wall',113,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Aufderhar, Zieme and Halvorson','Himeji',83,'Trees',51,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Hamill Group','Paris 16',2,'Mountains',194,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Sanford-Willms','Santa Fé do Sul',13,'Mountains',329,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Weimann, Lockman and Schuppe','Luchenza',7,'Street',76,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('D''Amore-Reichert','Panyingkiran',80,'Street',238,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Deckow-Rempel','Tarascon',33,'Mountains',220,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Purdy LLC','Ashibetsu',10,'Trees',446,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Dietrich-Keebler','Chixi',80,'Water',488,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Howe and Sons','Kawalimukti',31,'Mountains',429,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Renner, Wuckert and Dietrich','Anjie',68,'Water',77,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Jast-Rutherford','Saint Croix',23,'Street',221,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Luettgen LLC','Hongxi',65,'Water',201,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Lehner, Shields and Ebert','El Viejo',95,'Mountains',484,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Walker LLC','Darwin',47,'Mountains',227,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Larson, Bechtelar and Witting','Sanhe',15,'Water',355,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Lockman LLC','Stockholm',57,'Mountains',379,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Harvey Group','Blobo',70,'Trees',70,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Cartwright and Sons','Tegalsari',22,'Trees',215,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Lang-D''Amore','Jiangluo',50,'Trees',171,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Abbott-Emard','Alegrete',66,'Wall',123,1);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Williamson Inc','Žiželice',54,'Wall',178,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Balistreri Inc','Tomakomai',55,'Water',443,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Padberg, Cremin and Berge','Smolenka',8,'Street',53,2);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Schimmel, Schultz and Gerhold','Parczew',32,'Mountains',456,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('McClure LLC','Mthatha',1,'Trees',381,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Macejkovic Group','Dalumangcob',59,'Trees',447,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Simonis-Lind','Rio Grande da Serra',32,'Street',63,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Conroy Group','Atap',44,'Street',105,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Simonis Inc','Villa Ocampo',76,'Trees',461,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Hand Group','Itupiranga',29,'Street',200,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Kunde LLC','Sestroretsk',70,'Mountains',125,4);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Bode, Jacobson and Boyle','Matarraque',17,'Wall',330,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Dickens, McGlynn and Wisozk','Franca',35,'Street',69,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Hermiston, Hammes and Orn','Santol',1,'Street',271,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Streich, Smith and Reilly','Diriomo',53,'Wall',500,3);
INSERT INTO Rooms(Name,City,Number,View,Price,NumBeds) VALUES ('Jacobson-Hegmann','Nam Sách',82,'Wall',215,4);

-- insert data for travelgroups table
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('bbarcroft0','Blithe Barcroft','Barcroft');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('ehauxby1','Enriqueta Hauxby','Hauxby');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('aguiel2','Alfie Guiel','Guiel');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('zchallenor3','Zerk Challenor','Challenor');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('ayule4','Andrea Yule','Yule');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('tleverage5','Theda Leverage','Leverage');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('knornasell6','Kirsten Nornasell','Nornasell');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('sdevericks7','Shermy Devericks','Devericks');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('cstileman8','Cindy Stileman','Stileman');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('mkhilkov9','Malva Khilkov','Khilkov');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('csybea','Cornie Sybe','Sybe');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('thedylstoneb','Thalia Hedylstone','Hedylstone');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('frodmellc','Friederike Rodmell','Rodmell');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('ralvard','Rosemaria Alvar','Alvar');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('sciottie','Sander Ciotti','Ciotti');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('bpiffef','Benny Piffe','Piffe');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('kphysickg','Kaja Physick','Physick');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('lkennaghh','Leif Kennagh','Kennagh');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('eiltchevi','Esta Iltchev','Iltchev');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('rcarruthj','Rog Carruth','Carruth');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('cdomengek','Catherina Domenge','Domenge');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('mrigbyel','Marje Rigbye','Rigbye');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('egrigolettim','Efren Grigoletti','Grigoletti');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('tbreckenridgen','Theodosia Breckenridge','Breckenridge');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('aproscheko','Alyssa Proschek','Proschek');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('opellingtonp','Odelia Pellington','Pellington');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('mpacittiq','Marcos Pacitti','Pacitti');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('csargoodr','Charlean Sargood','Sargood');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('pnunsons','Paula Nunson','Nunson');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('sjendryst','Seana Jendrys','Jendrys');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('nmedwayu','Nikkie Medway','Medway');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('bsammesv','Brocky Sammes','Sammes');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('jhurringw','Jedd Hurring','Hurring');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('amcasgillx','Ase McAsgill','McAsgill');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('lshelmardiney','Lindsey Shelmardine','Shelmardine');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('ncustz','Nertie Cust','Cust');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('kkeasey10','Killian Keasey','Keasey');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('msmaleman11','Manolo Smaleman','Smaleman');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('gbampford12','Godfrey Bampford','Bampford');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('igreatreax13','Ira Greatreax','Greatreax');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('jshade14','Jobye Shade','Shade');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('jullrich15','Jeramey Ullrich','Ullrich');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('jclive16','Jammal Clive','Clive');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('ereddick17','Eleanor Reddick','Reddick');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('dshenley18','Debor Shenley','Shenley');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('blangford19','Bernete Langford','Langford');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('ksteynor1a','Kym Steynor','Steynor');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('caubrey1b','Cyndy Aubrey','Aubrey');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('scavendish1c','Shurlocke Cavendish','Cavendish');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('eboucher1d','Esme Boucher','Boucher');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('ylorne1e','Yancey Lorne','Lorne');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('djohnsee1f','Dominik Johnsee','Johnsee');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('whandrik1g','Wye Handrik','Handrik');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('xmcmanamen1h','Xena McManamen','McManamen');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('uvain1i','Ulrikaumeko Vain','Vain');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('scrampsy1j','Sela Crampsy','Crampsy');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('mfake1k','Merle Fake','Fake');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('kwiddop1l','Kiley Widdop','Widdop');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('kmcnaught1m','Karlotte McNaught','McNaught');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('wchrismas1n','Wilbert Chrismas','Chrismas');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('ispyer1o','Ignazio Spyer','Spyer');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('hlipp1p','Heddie Lipp','Lipp');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('fblasing1q','Faina Blasing','Blasing');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('fneads1r','Francklin Neads','Neads');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('awellwood1s','Anna Wellwood','Wellwood');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('cbodker1t','Celie Bodker','Bodker');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('bbatrip1u','Betteann Batrip','Batrip');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('kheadland1v','Kaycee Headland','Headland');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('sfilon1w','Stephen Filon','Filon');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('mtigwell1x','Melany Tigwell','Tigwell');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('tmacnulty1y','Templeton MacNulty','MacNulty');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('hscarlett1z','Hailey Scarlett','Scarlett');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('writeley20','Warren Riteley','Riteley');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('wadshed21','Welch Adshed','Adshed');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('gdaly22','Garek Daly','Daly');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('roglesbee23','Roy Oglesbee','Oglesbee');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('amcgifford24','Alasdair McGifford','McGifford');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('abosnell25','Aurore Bosnell','Bosnell');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('ncluderay26','Neely Cluderay','Cluderay');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('msalan27','Myranda Salan','Salan');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('nrestieaux28','Neil Restieaux','Restieaux');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('mboath29','Marisa Boath','Boath');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('mfarryan2a','Marlie Farryan','Farryan');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('rtuley2b','Rea Tuley','Tuley');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('ttieman2c','Tailor Tieman','Tieman');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('sleedes2d','Sanders Leedes','Leedes');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('noliphand2e','Nickolas Oliphand','Oliphand');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('atytterton2f','Amara Tytterton','Tytterton');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('lmelendez2g','Lovell Melendez','Melendez');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('fbaber2h','Felecia Baber','Baber');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('mstarkings2i','Madella Starkings','Starkings');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('lbeel2j','Lannie Beel','Beel');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('fgiamitti2k','Felita Giamitti','Giamitti');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('nchatten2l','Nora Chatten','Chatten');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('ghowroyd2m','Gertrude Howroyd','Howroyd');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('kscurrah2n','Kalila Scurrah','Scurrah');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('hvaudin2o','Howie Vaudin','Vaudin');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('mtollit2p','Mathew Tollit','Tollit');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('lculcheth2q','Loy Culcheth','Culcheth');
INSERT INTO TravelGroups(Name,Organizer,Destination) VALUES ('cbracegirdle2r','Cliff Bracegirdle','Bracegirdle');

-- insert data for discounts table
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Meevee',27,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Feedbug',22,'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Dabfeed',39,'Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Photobug',89,'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Roomm',59,'Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Skaboo',62,'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Dabtype',67,'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Jetwire',52,'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Flashpoint',16,'Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Jamia',79,'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Eadel',53,'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Dynabox',92,'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Twitterlist',79,'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Gabtune',36,'Integer tincidunt ante vel ipsum.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Devcast',40,'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Browseblab',53,'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Meembee',99,'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Gabtype',50,'Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Youfeed',89,'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Bluejam',81,'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Feedbug',36,'Etiam vel augue.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Rhynoodle',60,'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Pixope',34,'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Oyoba',73,'Ut tellus. Nulla ut erat id mauris vulputate elementum.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Jamia',22,'Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Blogpad',76,'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Chatterbridge',93,'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Myworks',43,'Nullam varius. Nulla facilisi.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Oyoyo',4,'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Twiyo',44,'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Eimbee',64,'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Kwideo',26,'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Wikivu',76,'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Meembee',54,'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Skiptube',82,'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Thoughtworks',28,'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Flashdog',43,'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Trilia',90,'Duis bibendum.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Wikido',53,'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Twinder',10,'Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Pixope',62,'Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Realbuzz',95,'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Fanoodle',3,'Curabitur convallis.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Tagfeed',50,'Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Pixoboo',87,'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Zoombeat',80,'Donec dapibus. Duis at velit eu est congue elementum.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Flipbug',84,'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Photojam',12,'Sed ante.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Agimba',17,'Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Skajo',20,'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Skyndu',73,'Nulla ut erat id mauris vulputate elementum. Nullam varius.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Topicstorm',56,'Nunc nisl.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Babbleopia',78,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Mydeo',62,'Praesent blandit lacinia erat.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Quaxo',47,'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Dynabox',49,'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Tekfly',45,'Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Centimia',74,'Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Wikido',54,'Duis at velit eu est congue elementum.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Lajo',41,'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Brainbox',44,'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Topicblab',63,'Donec posuere metus vitae ipsum. Aliquam non mauris.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Jabberbean',80,'Donec semper sapien a libero. Nam dui.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Realcube',80,'Proin eu mi.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Jabbersphere',46,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Blogtag',51,'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Linkbuzz',18,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Quimm',11,'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Dynava',30,'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Oyondu',86,'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Cogilith',69,'Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Vitz',85,'Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Kamba',6,'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Minyx',36,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Quimba',81,'Proin at turpis a pede posuere nonummy.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Jayo',37,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Layo',86,'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Brainsphere',14,'Integer ac neque. Duis bibendum.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Youspan',74,'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Edgepulse',82,'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Photobug',20,'In sagittis dui vel nisl. Duis ac nibh.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Jatri',73,'In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Lajo',21,'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Youbridge',67,'Donec ut mauris eget massa tempor convallis.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Jaxspan',13,'Proin eu mi.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Zava',80,'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Livetube',61,'Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Roombo',79,'Integer non velit.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Flipstorm',7,'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Yata',74,'Aenean lectus. Pellentesque eget nunc.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Oodoo',33,'Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Twitterwire',5,'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Buzzdog',92,'Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Ozu',41,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Devcast',11,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Agivu',34,'Donec posuere metus vitae ipsum.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Jabbertype',62,'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Oyoloo',28,'Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Quaxo',52,'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');
INSERT INTO Discounts(Name,DealPercent,Description) VALUES ('Wikizz',30,'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');

-- insert data for advertisements table
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('nfolfvsacc',NULL,NULL,134,'cgreguolir','hindgs1');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('yzyqtqhncq',NULL,NULL,144,'jhandyt','bmclardie5');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('ruewcxqllg',NULL,NULL,147,'srosengarten5','cchaplainu');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('whhhfhzokg',NULL,NULL,75,'jjarmyn6','bantoniutti18');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('gageoshgha',NULL,NULL,176,'hmaccoughen0','ngyse6');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('tvtygktgyv',NULL,NULL,156,'ctomczykiewicz7','ngyse6');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('jamctfgndl',NULL,NULL,129,'kmellenby9','fbengerr');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('qbdheernvm',NULL,NULL,6,'rfosberryh','ydodsworth16');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('jobxmnmniq',NULL,NULL,33,'mweatherall19','bgerhold1d');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('ewaulvjagg',NULL,NULL,191,'hslaffordz','abernardinelli0');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('bhpewgxmce',NULL,NULL,186,'nceschinin','cbidgode');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('zzpithyrwy',NULL,NULL,33,'mhansterl','lwoollam11');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('zkwgudecuf',NULL,NULL,19,'msellenk','bkarpushkin1b');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('gvlfyzjeqj',NULL,NULL,76,'hmaccoughen0','hkenderd');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('lrtqpwfcxr',NULL,NULL,136,'dbrogi3','ngyse6');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('gzohiqmane',NULL,NULL,186,'cfrancaisc','abernardinelli0');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('cqagutwysb',NULL,NULL,117,'jbarthod1d','sslatenf');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('hhabhsscrq',NULL,NULL,125,'dbrogi3','rrobinetx');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('ysupyikgmk',NULL,NULL,158,'ctomczykiewicz7','skitherl');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('fjrqqlbcso',NULL,NULL,88,'kquartly14','phasnip2');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('zjqwxmbysk',NULL,NULL,13,'rnutoni','gprevettw');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('cesyfednem',NULL,NULL,56,'vangrick2','theersm');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('xezreoyast',NULL,NULL,68,'mharriagno','bantoniutti18');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('krbeazgdgk',NULL,NULL,53,'jjarmyn6','ikolodziejj');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('uocjtnhewo',NULL,NULL,188,'ctomczykiewicz7','pturpiek');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('cmcgljazii',NULL,NULL,84,'hslaffordz','wditty14');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('clobrzkkgy',NULL,NULL,132,'kmellenby9','ngyse6');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('yviktiovql',NULL,NULL,26,'cfinci16','fbengerr');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('zkqvaxnisp',NULL,NULL,64,'rpenddrethq','chainey4');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('dtouvezeuy',NULL,NULL,106,'xgrangier1b','ydodsworth16');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('lolrzricwk',NULL,NULL,83,'ssevina','phasnip2');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('xqazrnkvui',NULL,NULL,25,'kmellenby9','dblanden8');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('siwiuroeup',NULL,NULL,158,'rpenddrethq','wghilardi17');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('qmvsorxbih',NULL,NULL,165,'lflear1a','scarayol19');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('lpksolmmiy',NULL,NULL,199,'tbalasini11','xwibrow7');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('zpfskqjttw',NULL,NULL,31,'hslaffordz','nomullaney15');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('bxvuptwcuf',NULL,NULL,43,'hmaccoughen0','hingramc');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('tldccdrrfk',NULL,NULL,13,'clevecque1','lwoollam11');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('nzrackffah',NULL,NULL,163,'bhartle18','cbidgode');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('fxhmmbupgt',NULL,NULL,118,'kquartly14','jsetteringtonn');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('hlkyncnzpu',NULL,NULL,79,'tbalasini11','abernardinelli0');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('orvxwwdtua',NULL,NULL,167,'cgymblettd','wditty14');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('dtfyxzbvdu',NULL,NULL,47,'roshavlany','adrogan1a');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('jilmxvxenn',NULL,NULL,8,'msellenk','oubachv');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('jhqgnfluqn',NULL,NULL,30,'fgrene10','ydodsworth16');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('xqhkihiymy',NULL,NULL,36,'lscrimshawx','gprevettw');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('tvbyuexpvc',NULL,NULL,157,'glulham15','nomullaney15');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('bxjasulggp',NULL,NULL,163,'xgrangier1b','wghilardi17');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('xxoerkpner',NULL,NULL,137,'hmaccoughen0','hattfieldi');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('cyipbqlvfj',NULL,NULL,97,'nceschinin','mtownes1c');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('snuyqavopv',NULL,NULL,65,'cfinci16','chainey4');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('ptgkjprafc',NULL,NULL,196,'hslaffordz','lswatey');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('kilfnaltax',NULL,NULL,105,'rfosberryh','dblanden8');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('atkitjbijw',NULL,NULL,38,'mlewendonw','estatherg');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('fichmcnmuj',NULL,NULL,25,'jbarthod1d','nomullaney15');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('rnufrtdygl',NULL,NULL,135,'vangrick2','lwoollam11');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('hhyqaofcwl',NULL,NULL,1,'llowings1c','wghilardi17');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('kuqrembjpn',NULL,NULL,47,'lmarderp','bantoniutti18');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('jsyvwzpywp',NULL,NULL,149,'cgreguolir','xwibrow7');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('fcvydijdte',NULL,NULL,194,'hmaccoughen0','bkarpushkin1b');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('iomdrtypwu',NULL,NULL,152,'lflear1a','bgerhold1d');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('xccioarmfe',NULL,NULL,68,'mweatherall19','lashby10');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('pwszsphwmi',NULL,NULL,182,'dbrogi3','pturpiek');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('dwiuxxclfi',NULL,NULL,157,'bhartle18','mtownes1c');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('qixvcivqfq',NULL,NULL,137,'kquartly14','hkenderd');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('ykmyvsvwfr',NULL,NULL,21,'lflear1a','lswatey');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('xryxpyczse',NULL,NULL,151,'srosengarten5','bmclardie5');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('ruptgmhhrh',NULL,NULL,173,'fgrene10','theersm');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('gcbtyktele',NULL,NULL,119,'bnapper12','ikolodziejj');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('olhxzklzze',NULL,NULL,193,'lmendes8','hkenderd');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('qebnznoffm',NULL,NULL,54,'amayoh13','jsetteringtonn');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('rkannfqkbb',NULL,NULL,91,'jquarton4','ngyse6');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('fapcxmwakx',NULL,NULL,63,'roshavlany','rroscowt');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('lrwbdgadoa',NULL,NULL,80,'xgrangier1b','estatherg');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('apxmunhfih',NULL,NULL,2,'cgreguolir','cdenisovichq');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('rcytdgossl',NULL,NULL,82,'rcoppensm','bantoniutti18');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('fvhcnlgqmc',NULL,NULL,76,'icrudginton17','ikolodziejj');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('mkwmnoryab',NULL,NULL,7,'atonryu','xwibrow7');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('xcqhgisqqy',NULL,NULL,186,'cfinci16','chainey4');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('ftvggedtqv',NULL,NULL,40,'tbalasini11','cchaplainu');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('iggoezhejv',NULL,NULL,8,'tcastelloneb','bkarpushkin1b');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('grfjkkxxkd',NULL,NULL,98,'lmendes8','hingramc');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('tcrkdjqswx',NULL,NULL,175,'xgrangier1b','fbengerr');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('wpkbtxdimb',NULL,NULL,178,'msellenk','hindgs1');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('ihohnytnyj',NULL,NULL,149,'rcoppensm','ikolodziejj');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('wwacbyekjt',NULL,NULL,130,'mhansterl','scarayol19');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('uwadqzlala',NULL,NULL,89,'icrudginton17','hkenderd');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('kkwlajnrox',NULL,NULL,183,'cfrancaisc','swickendonb');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('hrwyamrggm',NULL,NULL,191,'lscrimshawx','fdimitrievs');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('kzqetvuucp',NULL,NULL,20,'jquarton4','hindgs1');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('elzmyzbckg',NULL,NULL,79,'amayoh13','xwibrow7');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('lzxfxjsldv',NULL,NULL,176,'msellenk','cdenisovichq');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('ekaavhjbar',NULL,NULL,26,'clevecque1','sslatenf');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('ylomknncut',NULL,NULL,175,'bnapper12','lswatey');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('etoabwdzqn',NULL,NULL,178,'mharriagno','bkarpushkin1b');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('xkqkmbvmtv',NULL,NULL,117,'roshavlany','bkarpushkin1b');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('wxesuwiypc',NULL,NULL,76,'cfrancaisc','hkenderd');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('tbdmvflvcg',NULL,NULL,57,'llowings1c','adrogan1a');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('hddeogehvz',NULL,NULL,81,'vangrick2','ngyse6');
INSERT INTO Advertisements(Name,StartDate,EndDate,Cost,HostAdvertiser,PlannerAdvertiser) VALUES ('aqydupwihd',NULL,NULL,9,'mlewendonw','rrobinetx');

-- insert data for itineraries table
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('oecvzarnfb','spurdom1d','rhampshawa',4779);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('jtzbggqnvc','mslessar14','fdimitrievs',2639);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('bvslgxggqz','cdcruze19','lswatey',5492);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('zaggjtzvau','cbleasdalew','bmclardie5',9984);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('dwifiodzhc','zborlandl','bantoniutti18',3470);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('zrswwwdfnf','lgrimshawq','jsetteringtonn',1789);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('qkabgaoqnr','cbleasdalew','bmclardie5',4563);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('yhwqogfkxb','cbaudrys','bgerhold1d',7489);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('bahmfauzee','edetloffv','lbowrah',9108);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('tbddjwqrfn','rcullabinem','dfriatt13',9309);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('yazphogpnx','tfullstoneo','nomullaney15',4121);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('kwozfpcfko','cmarikhin2','dblanden8',9099);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('xbqkoullns','rsmithsone','bantoniutti18',3601);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('hunnoizvul','showles1c','adrogan1a',1956);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('zrlfknstgn','sprothero3','bgerhold1d',7704);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('pvbdjqzozg','lgrimshawq','bmclardie5',9375);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('ghlrwsxvwt','cbaudrys','lwoollam11',2680);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('oqfglvtlkm','tfullstoneo','bgerhold1d',241);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('purfecepke','cbleasdalew','dblanden8',5919);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('ddwzovhsph','scansdill0','bkarpushkin1b',8629);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('uewftmvrqi','rcullabinem','estatherg',3725);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('tmqealpjil','eliddyf','lbowrah',356);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('hefdgbpqeg','cbleasdalew','rroscowt',7817);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('scruaiqulq','edetloffv','cbidgode',1617);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('icpffvmqda','spurdom1d','adrogan1a',4322);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('czcekajwfr','gstodart1b','jsetteringtonn',3001);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('zkabfsensu','sdruett17','rroscowt',6441);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('dbdicrdfac','spurdom1d','phasnip2',9494);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('lqmpreivuk','bsalter8','gprevettw',5083);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('etsqcnlzal','lnanii','fdimitrievs',7374);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('fejrqkyoth','rskate1','bkarpushkin1b',8776);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('mwzyynmxog','cdavitashviliz','lashby10',5055);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('fzmykvjfgr','tsheppey11','bdupreyp',1154);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('hoclmhamvf','sprothero3','estatherg',5334);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('tfdfcvckik','flankham7','hingramc',6612);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('jzsdobkgvg','cdavitashviliz','hindgs1',8842);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('rbqtusnnsx','gstodart1b','scarayol19',8655);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('fyrbnobagg','fmcleodc','lswatey',9958);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('exowjwsfqz','rpassler16','fbengerr',7406);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('zvtvoxmoja','sprothero3','abernardinelli0',7487);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('ujrbefzilo','vrubinowk','skitherl',1529);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('qkpqsgodvh','rpassler16','bmccaghan9',7733);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('oculuekqxz','vphilpb','hindgs1',1265);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('molwuoblbt','jseekingsu','lashby10',1903);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('vppbleqjog','zborlandl','abernardinelli0',8195);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('pzuxiohtdt','lgrimshawq','bdupreyp',7214);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('pxddtuxolm','hmoulton10','rroscowt',4024);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('zdhgecmggk','mshobrookh','xwibrow7',888);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('gijwtdhbdm','vphilpb','chainey4',2685);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('fjifyrwaho','lnanii','pturpiek',6927);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('mfpgopueqc','kmaccallesterj','wditty14',8014);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('firhixtpjj','hmoulton10','bantoniutti18',3328);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('sdburbofge','hjerrardr','lwoollam11',6161);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('jtfscnbfpf','tsheppey11','cchaplainu',7907);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('cgwkmlpicx','zborlandl','fphayre3',7646);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('ujswwhxxui','eliddyf','cdenisovichq',2889);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('acrshjbwjg','rsmithsone','bgerhold1d',2932);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('bnhqmynjtw','cmarikhin2','lwoollam11',7554);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('sgmevxlbtz','hmoulton10','ydodsworth16',7325);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('ofjgrspigs','hboag18','cchaplainu',1958);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('xlzvnzonnh','zborlandl','wditty14',2515);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('cgqahbbklt','hjerrardr','fbengerr',7263);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('rvtcqpztln','gstodart1b','lbowrah',4195);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('cgdyemozct','ispratt1a','hattfieldi',1249);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('xzqxfpzbjx','vphilpb','jsetteringtonn',5847);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('vmesnknjde','mshobrookh','lbowrah',7559);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('cewthpvwpy','eliddyf','wditty14',5723);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('sbalrvrutm','hjerrardr','fbengerr',9359);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('dgpntznygl','mpiensy','scarayol19',1109);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('rgvgkfiaht','cbleasdalew','rroscowt',7343);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('ftsimvvtmh','bsalter8','hindgs1',9182);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('leqqyhupsa','hmoulton10','sslatenf',8004);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('bbhvtbvcsc','nreaperx','ikolodziejj',7102);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('ipgdelnzjc','scansdill0','bgerhold1d',2377);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('zbucmplvtw','mcush4','jsidaryo',5501);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('twwcetumyd','scansdill0','dblanden8',7810);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('xbptuaquiq','vphilpb','bantoniutti18',5557);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('pebkydlnhd','cdavitashviliz','nomullaney15',4246);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('reaigkkmuz','edetloffv','rroscowt',7320);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('jyrcnavqej','kmaccallesterj','ikolodziejj',3580);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('rfkjymenac','lgrimshawq','jsetteringtonn',3827);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('ktsaqdkujf','hjerrardr','ngyse6',7642);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('ahbmfiysae','rsmithsone','gprevettw',1835);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('wwxxfsuzna','gstodart1b','fphayre3',9326);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('mwsjcluoit','imccullouch5','wghilardi17',6692);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('nkfmpfynxs','vdeyenhardt12','wghilardi17',9926);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('ecltlwrjqb','cbaudrys','cdenisovichq',3547);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('uboyzihtjt','cmarikhin2','phasnip2',1194);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('smtkyajbcq','rpassler16','gprevettw',1388);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('aphnottmwj','sprothero3','bkarpushkin1b',9487);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('waeyippdhe','flankham7','jsidaryo',4899);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('pvzjqiivcv','tsheppey11','ngyse6',9178);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('vskrayxrmm','cchilds13','rhampshawa',8901);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('invmgzdtqv','ispratt1a','bmclardie5',2646);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('vyldoagiyv','mshobrookh','chainey4',433);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('qxhukbmegv','nreaperx','wghilardi17',6368);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('ntdaarogxl','hjerrardr','bdupreyp',197);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('gjmwlfelsr','flankham7','ikolodziejj',4966);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('diyppbfwai','jblinkhorng','eaynscombez',8449);
INSERT INTO Itineraries(Name,TravelerOrganizer,PlannerOrganizer,TotalPrice) VALUES ('xrbbourotb','scansdill0','lashby10',8959);

-- insert data for pictures table
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Kautzer LLC','Ouidah','http://dummyimage.com/817x.png/5fa2dd/ffffff','BlanditNonInterdum.avi','Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Orn, Nader and McDermott','Yulin','http://dummyimage.com/875x.png/dddddd/000000','UtTellus.ppt','Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Howe-Pfeffer','Zhaoxian','http://dummyimage.com/834x.png/dddddd/000000','TristiqueFusceCongue.mp3','Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Terry LLC','Ketangi','http://dummyimage.com/909x.png/dddddd/000000','Cubilia.xls','Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Conroy LLC','Malbork','http://dummyimage.com/657x.png/5fa2dd/ffffff','SitAmet.jpeg','Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Conroy Group','Waingapu','http://dummyimage.com/601x.png/cc0000/ffffff','DolorSit.avi','Morbi non quam nec dui luctus rutrum. Nulla tellus.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Lind-Stroman','Ushi','http://dummyimage.com/357x.png/cc0000/ffffff','Et.mp3','Donec posuere metus vitae ipsum. Aliquam non mauris.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Reinger, Sporer and Marvin','Lelystad','http://dummyimage.com/355x.png/5fa2dd/ffffff','QuisqueErat.mpeg','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Walsh, Denesik and Tromp','Nongoma','http://dummyimage.com/701x.png/ff4444/ffffff','AccumsanFelis.jpeg','Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Wolf, Treutel and Hansen','Leiria','http://dummyimage.com/567x.png/5fa2dd/ffffff','MaurisEgetMassa.xls','Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Fahey Inc','Zvenyhorodka','http://dummyimage.com/384x.png/5fa2dd/ffffff','NequeVestibulumEget.xls','In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Towne-Wisoky','Netolice','http://dummyimage.com/784x.png/dddddd/000000','Mauris.avi','Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Dickinson-Jerde','Fufang','http://dummyimage.com/61x.png/ff4444/ffffff','TinciduntNulla.tiff','Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Murray Group','Lenīnskīy','http://dummyimage.com/646x.png/ff4444/ffffff','AnteIpsum.mov','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Aufderhar, Zieme and Halvorson','Himeji','http://dummyimage.com/392x.png/ff4444/ffffff','TurpisEgetElit.mp3','Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Hamill Group','Paris 16','http://dummyimage.com/529x.png/cc0000/ffffff','Tincidunt.txt','Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Sanford-Willms','Santa Fé do Sul','http://dummyimage.com/636x.png/ff4444/ffffff','PosuereMetusVitae.tiff','Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Weimann, Lockman and Schuppe','Luchenza','http://dummyimage.com/561x.png/cc0000/ffffff','Justo.mp3','Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('D''Amore-Reichert','Panyingkiran','http://dummyimage.com/94x.png/ff4444/ffffff','EuOrciMauris.ppt','Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Deckow-Rempel','Tarascon','http://dummyimage.com/764x.png/5fa2dd/ffffff','FaucibusCursus.ppt','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Purdy LLC','Ashibetsu','http://dummyimage.com/593x.png/ff4444/ffffff','Enim.mpeg','Praesent id massa id nisl venenatis lacinia.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Dietrich-Keebler','Chixi','http://dummyimage.com/710x.png/5fa2dd/ffffff','LectusPellentesque.ppt','Etiam vel augue. Vestibulum rutrum rutrum neque.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Howe and Sons','Kawalimukti','http://dummyimage.com/251x.png/dddddd/000000','SociisNatoque.avi','Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Renner, Wuckert and Dietrich','Anjie','http://dummyimage.com/251x.png/5fa2dd/ffffff','DictumstEtiamFaucibus.tiff','Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Jast-Rutherford','Saint Croix','http://dummyimage.com/412x.png/cc0000/ffffff','SitAmet.doc','Nulla facilisi.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Luettgen LLC','Hongxi','http://dummyimage.com/191x.png/ff4444/ffffff','Convallis.png','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Lehner, Shields and Ebert','El Viejo','http://dummyimage.com/216x.png/cc0000/ffffff','UtMauris.xls','Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Walker LLC','Darwin','http://dummyimage.com/688x.png/ff4444/ffffff','Quis.avi','In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Larson, Bechtelar and Witting','Sanhe','http://dummyimage.com/414x.png/cc0000/ffffff','Ante.mp3','Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Lockman LLC','Stockholm','http://dummyimage.com/212x.png/ff4444/ffffff','AugueVestibulumRutrum.pdf','Aliquam erat volutpat. In congue.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Harvey Group','Blobo','http://dummyimage.com/730x.png/5fa2dd/ffffff','PellentesqueVolutpat.ppt','Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Cartwright and Sons','Tegalsari','http://dummyimage.com/452x.png/ff4444/ffffff','ParturientMontesNascetur.mp3','Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Lang-D''Amore','Jiangluo','http://dummyimage.com/909x.png/5fa2dd/ffffff','SapienUt.mp3','Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Abbott-Emard','Alegrete','http://dummyimage.com/283x.png/ff4444/ffffff','AugueASuscipit.avi','Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Williamson Inc','Žiželice','http://dummyimage.com/921x.png/cc0000/ffffff','TurpisDonecPosuere.pdf','Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Balistreri Inc','Tomakomai','http://dummyimage.com/381x.png/5fa2dd/ffffff','Vivamus.jpeg','Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Padberg, Cremin and Berge','Smolenka','http://dummyimage.com/648x.png/dddddd/000000','TellusSemperInterdum.mp3','In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Schimmel, Schultz and Gerhold','Parczew','http://dummyimage.com/47x.png/cc0000/ffffff','AliquamSit.mpeg','Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('McClure LLC','Mthatha','http://dummyimage.com/815x.png/cc0000/ffffff','Nam.jpeg','Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Macejkovic Group','Dalumangcob','http://dummyimage.com/248x.png/ff4444/ffffff','Lobortis.tiff','Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Simonis-Lind','Rio Grande da Serra','http://dummyimage.com/550x.png/5fa2dd/ffffff','MaecenasTincidunt.tiff','Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Conroy Group','Atap','http://dummyimage.com/849x.png/5fa2dd/ffffff','AliquamLacusMorbi.mp3','Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Simonis Inc','Villa Ocampo','http://dummyimage.com/463x.png/5fa2dd/ffffff','Sit.mp3','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Hand Group','Itupiranga','http://dummyimage.com/165x.png/dddddd/000000','DuisFaucibusAccumsan.ppt','In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Kunde LLC','Sestroretsk','http://dummyimage.com/538x.png/ff4444/ffffff','Dapibus.ppt','Proin risus.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Bode, Jacobson and Boyle','Matarraque','http://dummyimage.com/724x.png/cc0000/ffffff','LiberoUt.xls','Proin at turpis a pede posuere nonummy.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Dickens, McGlynn and Wisozk','Franca','http://dummyimage.com/184x.png/dddddd/000000','OrciLuctusEt.ppt','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Hermiston, Hammes and Orn','Santol','http://dummyimage.com/298x.png/dddddd/000000','CrasMiPede.png','Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Streich, Smith and Reilly','Diriomo','http://dummyimage.com/759x.png/dddddd/000000','Ullamcorper.ppt','Suspendisse accumsan tortor quis turpis.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Jacobson-Hegmann','Nam Sách','http://dummyimage.com/658x.png/ff4444/ffffff','NullamPorttitorLacus.xls','Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Fritsch, Barrows and Yost','Jinchang','http://dummyimage.com/626x.png/5fa2dd/ffffff','VehiculaCondimentum.mp3','Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Satterfield LLC','Åkersberga','http://dummyimage.com/195x.png/cc0000/ffffff','HacHabitasse.mov','Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Gutkowski, Crist and Stroman','Tiwi','http://dummyimage.com/545x.png/5fa2dd/ffffff','AnteIpsumPrimis.avi','Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Medhurst and Sons','Jinji','http://dummyimage.com/702x.png/ff4444/ffffff','ConvallisTortor.ppt','Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Kirlin LLC','Manorom','http://dummyimage.com/624x.png/ff4444/ffffff','Maecenas.avi','Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Carter-Kovacek','Olszanica','http://dummyimage.com/41x.png/ff4444/ffffff','IntegerTincidunt.txt','Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Block LLC','Poggio di Chiesanuova','http://dummyimage.com/403x.png/cc0000/ffffff','LiberoNullam.avi','Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Medhurst LLC','Valongo','http://dummyimage.com/986x.png/ff4444/ffffff','QuisOdioConsequat.avi','Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Rutherford Inc','Mt Peto','http://dummyimage.com/872x.png/5fa2dd/ffffff','LacusMorbi.mp3','Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Gutmann-MacGyver','Manado','http://dummyimage.com/344x.png/ff4444/ffffff','Enim.png','Praesent blandit.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Hansen-Lemke','Wasilków','http://dummyimage.com/543x.png/dddddd/000000','Interdum.mp3','Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Considine, Kerluke and Brown','Toulouse','http://dummyimage.com/813x.png/cc0000/ffffff','Odio.tiff','In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Hoeger, King and Veum','Mahdia','http://dummyimage.com/43x.png/5fa2dd/ffffff','SedNislNunc.mp3','In est risus, auctor sed, tristique in, tempus sit amet, sem.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('McLaughlin-Schroeder','Zall-Dardhë','http://dummyimage.com/434x.png/ff4444/ffffff','VelDapibusAt.avi','Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Littel-Orn','Cali','http://dummyimage.com/964x.png/5fa2dd/ffffff','AmetDiam.mp3','Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Blanda LLC','Usa River','http://dummyimage.com/38x.png/cc0000/ffffff','Amet.xls','Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Yost, Botsford and Morar','Vĩnh Tường','http://dummyimage.com/51x.png/ff4444/ffffff','ViverraDiamVitae.mpeg','Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Roberts, Daniel and Feeney','Milwaukee','http://dummyimage.com/789x.png/dddddd/000000','AeneanSit.txt','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Jacobs Inc','Göteborg','http://dummyimage.com/705x.png/5fa2dd/ffffff','PedePosuereNonummy.xls','Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Wyman, McKenzie and Ullrich','Dongbang','http://dummyimage.com/797x.png/dddddd/000000','Lectus.mov','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Ziemann-Tremblay','Lodhrān','http://dummyimage.com/621x.png/5fa2dd/ffffff','JustoIn.xls','Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Wunsch and Sons','Senahú','http://dummyimage.com/533x.png/dddddd/000000','RidiculusMusVivamus.pdf','Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Hansen-Herzog','Huaping','http://dummyimage.com/796x.png/ff4444/ffffff','LigulaSuspendisseOrnare.ppt','Mauris lacinia sapien quis libero.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Cassin-Murray','Isfana','http://dummyimage.com/909x.png/5fa2dd/ffffff','DonecQuis.xls','In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Mante-Collier','Kalamáta','http://dummyimage.com/680x.png/5fa2dd/ffffff','Vestibulum.xls','Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Casper, Rowe and Effertz','Baziqiao','http://dummyimage.com/530x.png/ff4444/ffffff','MorbiAIpsum.mp3','Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Ebert Group','Batangan','http://dummyimage.com/273x.png/cc0000/ffffff','Blandit.ppt','Aenean auctor gravida sem.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Ryan, Blanda and Pacocha','Puutura','http://dummyimage.com/617x.png/dddddd/000000','Non.xls','Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Treutel-Dare','Rājshāhi','http://dummyimage.com/461x.png/5fa2dd/ffffff','Mus.avi','Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Hermiston Inc','Porsgrunn','http://dummyimage.com/795x.png/dddddd/000000','Sit.mp3','Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Ward LLC','Velingrad','http://dummyimage.com/638x.png/cc0000/ffffff','Dui.xls','Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Roob-Rice','Reisdorf','http://dummyimage.com/869x.png/cc0000/ffffff','MalesuadaInImperdiet.xls','Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Erdman-Thompson','Corzuela','http://dummyimage.com/665x.png/dddddd/000000','GravidaNisiAt.xls','Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('D''Amore-Price','Tongjiaxi','http://dummyimage.com/563x.png/ff4444/ffffff','NisiEuOrci.mp3','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Spinka LLC','Falun','http://dummyimage.com/74x.png/5fa2dd/ffffff','NullaFacilisi.ppt','Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Kessler and Sons','Belos Ares','http://dummyimage.com/530x.png/5fa2dd/ffffff','AtLorem.gif','In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Little, DuBuque and VonRueden','Warmare','http://dummyimage.com/323x.png/dddddd/000000','IdLobortisConvallis.xls','Cras in purus eu magna vulputate luctus.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Dietrich Group','Elaiochóri','http://dummyimage.com/525x.png/5fa2dd/ffffff','Tortor.avi','Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Hickle and Sons','Penang','http://dummyimage.com/238x.png/ff4444/ffffff','OdioInHac.jpeg','Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Romaguera, Volkman and McGlynn','Cestas','http://dummyimage.com/961x.png/5fa2dd/ffffff','VariusIntegerAc.avi','Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Sporer LLC','Siguinon','http://dummyimage.com/358x.png/5fa2dd/ffffff','LuctusEt.avi','In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Monahan, Bruen and Upton','Kliteh','http://dummyimage.com/217x.png/5fa2dd/ffffff','NonummyInteger.avi','Vivamus tortor. Duis mattis egestas metus.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Koss, Weber and Lueilwitz','Ainaži','http://dummyimage.com/453x.png/dddddd/000000','PotentiIn.tiff','In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Ernser and Sons','Guanban','http://dummyimage.com/738x.png/dddddd/000000','SitAmet.pdf','In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('McLaughlin LLC','Sunbu','http://dummyimage.com/931x.png/5fa2dd/ffffff','IdOrnareImperdiet.ppt','Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Lueilwitz LLC','Xianshuigu','http://dummyimage.com/436x.png/dddddd/000000','A.xls','Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Reinger, Corkery and Kutch','Chinch''ŏn','http://dummyimage.com/952x.png/cc0000/ffffff','LaoreetUtRhoncus.ppt','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Lind, Kulas and Morissette','Paulpietersburg','http://dummyimage.com/699x.png/dddddd/000000','Potenti.jpeg','Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Leuschke Group','Valenciennes','http://dummyimage.com/216x.png/ff4444/ffffff','LectusAliquamSit.mpeg','Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.');
INSERT INTO Pictures(LodgingName,City,ImageURL,Name,Description) VALUES ('Stehr and Sons','Mayhan','http://dummyimage.com/153x.png/cc0000/ffffff','EuSapien.png','Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.');

-- insert data for reviews table
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('dsyalvester0','Lehner and Sons','Nulla facilisi.',NULL,1,'Kautzer LLC','Ouidah','Grimes-Lemke','Chamical');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('tholmes1','Collins Inc','Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.',NULL,1,'Orn, Nader and McDermott','Yulin','Williamson-Gottlieb','Joliet');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('cfrostdyke2','Beahan, Koelpin and Schimmel','Mauris lacinia sapien quis libero.',NULL,1,'Howe-Pfeffer','Zhaoxian','Marks Inc','Storozhnytsya');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('clodin3','Beier, Monahan and Gislason','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.',NULL,1,'Terry LLC','Ketangi','O''Keefe-Toy','Malabar');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('khuskisson4','West-Cormier','In quis justo.',NULL,0,'Conroy LLC','Malbork','Cassin-Klocko','Yangchun');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('eanthonies5','Johns-O''Keefe','Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.',NULL,5,'Conroy Group','Waingapu','Daniel, Roob and Schultz','Panamá');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('sbeamiss6','Hudson-Kris','Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.',NULL,4,'Lind-Stroman','Ushi','Gleason-Roob','Kyshtym');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('umatyushenko7','Runolfsdottir LLC','Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.',NULL,3,'Reinger, Sporer and Marvin','Lelystad','Padberg-Schmitt','Shihuajian');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('mblamphin8','Parker-Russel','Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',NULL,2,'Walsh, Denesik and Tromp','Nongoma','Kris Group','Hexing');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('ppettican9','Klocko-Hoeger','Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.',NULL,0,'Wolf, Treutel and Hansen','Leiria','White, Beer and Flatley','Carapicuíba');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('kalnera','Funk, Morissette and Heathcote','Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.',NULL,5,'Fahey Inc','Zvenyhorodka','Braun Inc','Rogów');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('mmaystonb','Hilll-Borer','Aenean sit amet justo. Morbi ut odio.',NULL,1,'Towne-Wisoky','Netolice','Legros-Mitchell','Szubin');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('sebrallc','Harber Inc','Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',NULL,4,'Dickinson-Jerde','Fufang','Hilpert-Konopelski','Kalanchak');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('icorriead','Gottlieb-Johnson','Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',NULL,0,'Murray Group','Lenīnskīy','Ortiz, Boyer and Gottlieb','Yanggu');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('cvintere','Bailey and Sons','In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.',NULL,5,'Aufderhar, Zieme and Halvorson','Himeji','Conroy-Schiller','Margotuhu Kidul');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('mmongeotf','Hills Group','Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.',NULL,5,'Hamill Group','Paris 16','Marquardt-Schmitt','Andongrejo');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('nsalzeng','Harris, Leuschke and Mosciski','Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.',NULL,0,'Sanford-Willms','Santa Fé do Sul','Pfannerstill-Hauck','Kromasan');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('jmauntonh','Reilly LLC','Suspendisse ornare consequat lectus.',NULL,4,'Weimann, Lockman and Schuppe','Luchenza','Fay LLC','Al Manşūrah');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('ocrosskelli','Koelpin LLC','Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.',NULL,2,'D''Amore-Reichert','Panyingkiran','Kirlin, Rau and Russel','Chía');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('bchidlowj','Witting-West','Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.',NULL,1,'Deckow-Rempel','Tarascon','Howe, Runte and Romaguera','Oslo');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('lkellek','Rutherford, Wolff and Mueller','Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.',NULL,5,'Purdy LLC','Ashibetsu','Reynolds, Lockman and Steuber','Péfki');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('mfarrynl','Heathcote LLC','Proin interdum mauris non ligula pellentesque ultrices.',NULL,0,'Dietrich-Keebler','Chixi','Schuppe-Abernathy','Metlika');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('fonealm','Borer and Sons','Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.',NULL,5,'Howe and Sons','Kawalimukti','Quigley-Glover','Hidalgo');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('pspranklingn','Sporer Inc','In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.',NULL,0,'Renner, Wuckert and Dietrich','Anjie','Franecki Inc','Monastyryshche');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('etippino','Yundt, Cummings and Grimes','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.',NULL,1,'Jast-Rutherford','Saint Croix','Cassin, Schimmel and Kshlerin','Mascote');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('adwerryhousep','Price Inc','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.',NULL,2,'Luettgen LLC','Hongxi','Hamill, Quigley and Johns','Lyuban’');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('lgarroodq','Kerluke Inc','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.',NULL,1,'Lehner, Shields and Ebert','El Viejo','Langosh and Sons','Loures');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('ycullipr','Padberg and Sons','Mauris sit amet eros.',NULL,1,'Walker LLC','Darwin','Bergnaum and Sons','El Hermel');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('acejkas','Dickens LLC','Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.',NULL,4,'Larson, Bechtelar and Witting','Sanhe','Nienow and Sons','Blagnac');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('jhousont','Cole Group','Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.',NULL,5,'Lockman LLC','Stockholm','Bergstrom-Fisher','Batu');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('eahmadu','Corkery-Schaefer','Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.',NULL,1,'Harvey Group','Blobo','Collier LLC','Santa Luzia');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('hbraysherv','Toy-Trantow','Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.',NULL,2,'Cartwright and Sons','Tegalsari','Haley and Sons','Sima');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('curidgew','Macejkovic-Jaskolski','Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.',NULL,2,'Lang-D''Amore','Jiangluo','Romaguera Inc','Guangfu');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('rvaskinx','Stoltenberg-Towne','Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis.',NULL,1,'Abbott-Emard','Alegrete','Jacobs and Sons','Gombong');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('bwestheady','Macejkovic, Kihn and Mante','In eleifend quam a odio. In hac habitasse platea dictumst.',NULL,2,'Williamson Inc','Žiželice','Kassulke-Harvey','El Águila');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('klepickz','Parisian Group','Etiam pretium iaculis justo. In hac habitasse platea dictumst.',NULL,2,'Balistreri Inc','Tomakomai','Kuhn-Wilderman','Ambato Boeny');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('jradclyffe10','McDermott Inc','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.',NULL,1,'Padberg, Cremin and Berge','Smolenka','Wolff-Stark','Alcorriol');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('srogans11','Kessler, Predovic and Hansen','Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.',NULL,5,'Schimmel, Schultz and Gerhold','Parczew','Hagenes-Grady','Krechevitsy');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('rrenbold12','Mraz-Hamill','Duis bibendum. Morbi non quam nec dui luctus rutrum.',NULL,0,'McClure LLC','Mthatha','Wehner Inc','Lindian');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('bcommander13','Bogan, Ullrich and Torp','Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.',NULL,4,'Macejkovic Group','Dalumangcob','Hammes-Rath','Privodino');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('lerdes14','Little, Swaniawski and Lynch','Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.',NULL,2,'Simonis-Lind','Rio Grande da Serra','Kihn-Williamson','Katipunan');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('msturges15','Mraz-Connelly','Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.',NULL,5,'Conroy Group','Atap','Bailey Group','Xieshui');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('jrippin16','Spinka LLC','In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.',NULL,3,'Simonis Inc','Villa Ocampo','Nienow-Wisozk','Piraju');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('nstrowlger17','Weissnat, Jacobs and Halvorson','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.',NULL,1,'Hand Group','Itupiranga','Wilkinson Inc','Alkmaar');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('atwohig18','Russel and Sons','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.',NULL,3,'Kunde LLC','Sestroretsk','Haag Inc','Novokayakent');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('ksvanetti19','Graham-Gibson','Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.',NULL,3,'Bode, Jacobson and Boyle','Matarraque','Heathcote-Botsford','Tangnan');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('vkolinsky1a','Lakin Group','Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.',NULL,0,'Dickens, McGlynn and Wisozk','Franca','Hamill-Koelpin','Henggang');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('blottrington1b','Nienow-Haley','Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.',NULL,3,'Hermiston, Hammes and Orn','Santol','Vandervort and Sons','Pereleshino');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('rbranchet1c','Runolfsson, Bernier and Gislason','Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.',NULL,5,'Streich, Smith and Reilly','Diriomo','Tillman, Grimes and Sipes','Lons-le-Saunier');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('hbranno1d','Brakus Group','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.',NULL,1,'Jacobson-Hegmann','Nam Sách','Lakin, Thiel and Kris','Dongxiang');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('dsnewin1e','Ferry-Dare','Duis mattis egestas metus. Aenean fermentum.',NULL,0,'Fritsch, Barrows and Yost','Jinchang','Zieme, Tromp and Rau','Pô');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('lbonus1f','Bogisich, Trantow and Schowalter','Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',NULL,3,'Satterfield LLC','Åkersberga','Jast Inc','Gongjiahe');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('dlyster1g','Schulist Inc','Nullam porttitor lacus at turpis.',NULL,1,'Gutkowski, Crist and Stroman','Tiwi','Effertz, Murphy and Herman','Beiyang');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('bmion1h','Lebsack-Heathcote','Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.',NULL,5,'Medhurst and Sons','Jinji','Graham, Mitchell and Hudson','Dzhayrakh');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('pflewitt1i','Kassulke-Nolan','Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.',NULL,1,'Kirlin LLC','Manorom','Kessler LLC','Lianshi');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('dgoodwyn1j','Little-VonRueden','Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.',NULL,0,'Carter-Kovacek','Olszanica','Hoppe, Dare and Daugherty','Papeete');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('scloutt1k','Bins, Torp and Reichel','Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.',NULL,2,'Block LLC','Poggio di Chiesanuova','Pouros-Green','Huafeng');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('avandrill1l','Okuneva, Heaney and Johnston','Morbi a ipsum. Integer a nibh. In quis justo.',NULL,0,'Medhurst LLC','Valongo','Cole Inc','Grojec');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('cdevile1m','Ruecker Group','Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.',NULL,2,'Rutherford Inc','Mt Peto','Hegmann-Wunsch','Zhifang');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('lsandlin1n','Weissnat, Wisoky and Senger','Donec ut dolor.',NULL,3,'Gutmann-MacGyver','Manado','Goodwin LLC','Huangdimiao');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('tfaircley1o','Zboncak, Halvorson and Bahringer','Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.',NULL,2,'Hansen-Lemke','Wasilków','Murphy and Sons','Estância Velha');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('gweson1p','Towne-Satterfield','Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.',NULL,5,'Considine, Kerluke and Brown','Toulouse','Mohr Inc','Demak');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('rsails1q','Deckow-Durgan','Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.',NULL,4,'Hoeger, King and Veum','Mahdia','Osinski and Sons','Elmira');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('kmessier1r','Stoltenberg, Treutel and Hane','Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero.',NULL,3,'McLaughlin-Schroeder','Zall-Dardhë','Toy, Hirthe and Willms','Limulan');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('hgrimditch1s','Veum, Sporer and Mitchell','Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.',NULL,4,'Littel-Orn','Cali','Simonis-Sipes','Llocllapampa');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('fmee1t','Mertz Group','Nullam sit amet turpis elementum ligula vehicula consequat.',NULL,0,'Blanda LLC','Usa River','Leuschke-Bergstrom','Pokrov');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('dstihl1u','Koss, Hermiston and Hintz','Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.',NULL,1,'Yost, Botsford and Morar','Vĩnh Tường','Hackett LLC','Galátsi');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('kphilippeaux1v','Ankunding, Pacocha and Willms','Aenean lectus. Pellentesque eget nunc.',NULL,0,'Roberts, Daniel and Feeney','Milwaukee','Stoltenberg-Thompson','Xinghe Chengguanzhen');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('dhourican1w','Koepp Inc','Etiam pretium iaculis justo. In hac habitasse platea dictumst.',NULL,0,'Jacobs Inc','Göteborg','Batz and Sons','Pereyaslav-Khmel’nyts’kyy');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('nmaneylaws1x','Brown and Sons','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',NULL,3,'Wyman, McKenzie and Ullrich','Dongbang','Runolfsdottir LLC','Jambean');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('fbang1y','Green, Cartwright and Kunde','Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.',NULL,1,'Ziemann-Tremblay','Lodhrān','Wintheiser-Douglas','Ranambeling');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('okonrad1z','Leuschke, Champlin and Haag','In blandit ultrices enim.',NULL,0,'Wunsch and Sons','Senahú','D''Amore, Weissnat and Hansen','Huangsha');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('xworshall20','Swaniawski, Mayer and Mayert','Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.',NULL,5,'Hansen-Herzog','Huaping','Greenholt Group','Sacramento');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('tweitzel21','Abshire LLC','Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.',NULL,1,'Cassin-Murray','Isfana','Witting-Fisher','La Courneuve');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('kdonaway22','Carter, Schmeler and Reichel','Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.',NULL,2,'Mante-Collier','Kalamáta','Hagenes LLC','Renxian');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('rteese23','Kessler, Jacobs and D''Amore','In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.',NULL,0,'Casper, Rowe and Effertz','Baziqiao','Breitenberg-Cummerata','Kuvshinovo');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('tmaling24','Schaden and Sons','Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.',NULL,5,'Ebert Group','Batangan','Reichel Inc','Unidad');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('dreilingen25','Schneider-Schaden','Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.',NULL,5,'Ryan, Blanda and Pacocha','Puutura','VonRueden-Spinka','Gândara');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('orippon26','Dickinson and Sons','Aenean lectus. Pellentesque eget nunc.',NULL,1,'Treutel-Dare','Rājshāhi','Flatley, Gerhold and Reinger','Meruge');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('jswannell27','Feil Group','Proin leo odio, porttitor id, consequat in, consequat ut, nulla.',NULL,4,'Hermiston Inc','Porsgrunn','Macejkovic and Sons','Gowa');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('bivers28','Satterfield-Shields','Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.',NULL,0,'Ward LLC','Velingrad','Oberbrunner, Kris and Morar','Pretoria');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('wgrimwad29','Renner, Moen and Morissette','Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.',NULL,1,'Roob-Rice','Reisdorf','Hirthe Group','Victoriaville');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('ycardenas2a','Ortiz-Langosh','Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.',NULL,0,'Erdman-Thompson','Corzuela','Schaefer-Breitenberg','Brckovljani');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('wgilhouley2b','West, Willms and Adams','Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.',NULL,1,'D''Amore-Price','Tongjiaxi','Gorczany-Erdman','Neftekamsk');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('abergin2c','Greenholt-O''Connell','Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.',NULL,5,'Spinka LLC','Falun','Lindgren LLC','Jejkowice');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('agreasley2d','Lakin Inc','Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.',NULL,2,'Kessler and Sons','Belos Ares','Parisian-Lynch','Ingenio La Esperanza');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('dgemlbett2e','Denesik and Sons','Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.',NULL,1,'Little, DuBuque and VonRueden','Warmare','Rosenbaum-Kuhic','Bonoua');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('bkersaw2f','Koelpin, Metz and Conn','Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.',NULL,3,'Dietrich Group','Elaiochóri','Morar-McDermott','Libacao');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('cranson2g','Fay LLC','Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.',NULL,4,'Hickle and Sons','Penang','Rutherford LLC','Senglea');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('smalthouse2h','Bergstrom-McClure','Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.',NULL,5,'Romaguera, Volkman and McGlynn','Cestas','Mayert and Sons','Pellegrini');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('fbrodie2i','Zieme-Shields','Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.',NULL,4,'Sporer LLC','Siguinon','Hilpert LLC','San Roque');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('croebuck2j','Becker, Becker and Miller','Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum.',NULL,0,'Monahan, Bruen and Upton','Kliteh','Koss, Bins and Blick','Kimil’tey');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('ahumpatch2k','Friesen Group','Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.',NULL,2,'Koss, Weber and Lueilwitz','Ainaži','Hammes, Donnelly and Lowe','Napenay');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('lfardy2l','Nolan Inc','In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl.',NULL,4,'Ernser and Sons','Guanban','Klocko and Sons','Palatine');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('rbatterbee2m','Abernathy-Mertz','Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.',NULL,4,'McLaughlin LLC','Sunbu','Daugherty, Keebler and Rau','Ash Shaykh ‘Uthmān');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('lcrumpe2n','Hagenes-Schulist','Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.',NULL,5,'Lueilwitz LLC','Xianshuigu','Daugherty-Waelchi','Waterloo');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('zhazelden2o','Armstrong-Dickinson','Nullam porttitor lacus at turpis.',NULL,5,'Reinger, Corkery and Kutch','Chinch''ŏn','DuBuque-Koelpin','Capitán Bermúdez');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('mhugonnet2p','Haag Group','Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.',NULL,3,'Lind, Kulas and Morissette','Paulpietersburg','Lakin, Dickens and Runte','Lianhe');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('ozmitrovich2q','Schimmel-Strosin','Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.',NULL,5,'Leuschke Group','Valenciennes','Bins, Marvin and Bednar','Coruña, A');
INSERT INTO Reviews(Poster,Target,Comment,Date,Rating,LodgingName,City,ActivityName,Location) VALUES ('radame2r','Nicolas, Barton and Waters','Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.',NULL,5,'Stehr and Sons','Mayhan','Hegmann and Sons','Astghadzor');

-- insert data for trav_act table
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('mcush4','Grimes-Lemke','Chamical');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('lgrimshawq','Williamson-Gottlieb','Joliet');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('flankham7','Marks Inc','Storozhnytsya');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('jseekingsu','O''Keefe-Toy','Malabar');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('mirvingn','Cassin-Klocko','Yangchun');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('eliddyf','Daniel, Roob and Schultz','Panamá');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('lnanii','Gleason-Roob','Kyshtym');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cbleasdalew','Padberg-Schmitt','Shihuajian');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('flankham7','Kris Group','Hexing');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('rskate1','White, Beer and Flatley','Carapicuíba');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('zborlandl','Braun Inc','Rogów');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('edetloffv','Legros-Mitchell','Szubin');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('sprothero3','Hilpert-Konopelski','Kalanchak');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('gstodart1b','Ortiz, Boyer and Gottlieb','Yanggu');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cbleasdalew','Conroy-Schiller','Margotuhu Kidul');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('gstodart1b','Marquardt-Schmitt','Andongrejo');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('eliddyf','Pfannerstill-Hauck','Kromasan');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cmarikhin2','Fay LLC','Al Manşūrah');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('hjerrardr','Kirlin, Rau and Russel','Chía');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('sdruett17','Howe, Runte and Romaguera','Oslo');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('psiegertsza','Reynolds, Lockman and Steuber','Péfki');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('jblinkhorng','Schuppe-Abernathy','Metlika');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('vrubinowk','Quigley-Glover','Hidalgo');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cmarikhin2','Franecki Inc','Monastyryshche');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('lnanii','Cassin, Schimmel and Kshlerin','Mascote');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('rskate1','Hamill, Quigley and Johns','Lyuban’');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('mshobrookh','Langosh and Sons','Loures');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cbleasdalew','Bergnaum and Sons','El Hermel');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('lnanii','Nienow and Sons','Blagnac');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cdcruze19','Bergstrom-Fisher','Batu');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('flankham7','Collier LLC','Santa Luzia');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('kmaccallesterj','Haley and Sons','Sima');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('wstirript','Romaguera Inc','Guangfu');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('hjerrardr','Jacobs and Sons','Gombong');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('mcush4','Kassulke-Harvey','El Águila');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('lkelberer15','Kuhn-Wilderman','Ambato Boeny');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cdavitashviliz','Wolff-Stark','Alcorriol');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('ablind9','Hagenes-Grady','Krechevitsy');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('mpiensy','Wehner Inc','Lindian');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('sdruett17','Hammes-Rath','Privodino');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('flankham7','Kihn-Williamson','Katipunan');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('scansdill0','Bailey Group','Xieshui');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('hboag18','Nienow-Wisozk','Piraju');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('mpiensy','Wilkinson Inc','Alkmaar');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('lgrimshawq','Haag Inc','Novokayakent');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('zborlandl','Heathcote-Botsford','Tangnan');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('kmaccallesterj','Hamill-Koelpin','Henggang');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('jseekingsu','Vandervort and Sons','Pereleshino');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('hboag18','Tillman, Grimes and Sipes','Lons-le-Saunier');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('ispratt1a','Lakin, Thiel and Kris','Dongxiang');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('mshobrookh','Zieme, Tromp and Rau','Pô');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('spurdom1d','Jast Inc','Gongjiahe');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('lkelberer15','Effertz, Murphy and Herman','Beiyang');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('tfullstoneo','Graham, Mitchell and Hudson','Dzhayrakh');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('rsmithsone','Kessler LLC','Lianshi');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('zborlandl','Hoppe, Dare and Daugherty','Papeete');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('lkittles6','Pouros-Green','Huafeng');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('bsalter8','Cole Inc','Grojec');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('sprothero3','Hegmann-Wunsch','Zhifang');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('hjerrardr','Goodwin LLC','Huangdimiao');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('scansdill0','Murphy and Sons','Estância Velha');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('showles1c','Mohr Inc','Demak');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('hjerrardr','Osinski and Sons','Elmira');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('rskate1','Toy, Hirthe and Willms','Limulan');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cmarikhin2','Simonis-Sipes','Llocllapampa');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('mshobrookh','Leuschke-Bergstrom','Pokrov');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cdcruze19','Hackett LLC','Galátsi');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('imccullouch5','Stoltenberg-Thompson','Xinghe Chengguanzhen');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('mslessar14','Batz and Sons','Pereyaslav-Khmel’nyts’kyy');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('gstodart1b','Runolfsdottir LLC','Jambean');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('eliddyf','Wintheiser-Douglas','Ranambeling');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('mirvingn','D''Amore, Weissnat and Hansen','Huangsha');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('vrubinowk','Greenholt Group','Sacramento');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('wstirript','Witting-Fisher','La Courneuve');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('ablind9','Hagenes LLC','Renxian');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('nreaperx','Breitenberg-Cummerata','Kuvshinovo');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('spurdom1d','Reichel Inc','Unidad');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cdavitashviliz','VonRueden-Spinka','Gândara');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cbaudrys','Flatley, Gerhold and Reinger','Meruge');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('hmoulton10','Macejkovic and Sons','Gowa');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('mcush4','Oberbrunner, Kris and Morar','Pretoria');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('rskate1','Hirthe Group','Victoriaville');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('fmcleodc','Schaefer-Breitenberg','Brckovljani');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('kmaccallesterj','Gorczany-Erdman','Neftekamsk');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cdcruze19','Lindgren LLC','Jejkowice');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('mpiensy','Parisian-Lynch','Ingenio La Esperanza');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cdavitashviliz','Rosenbaum-Kuhic','Bonoua');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('spurdom1d','Morar-McDermott','Libacao');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cmarikhin2','Rutherford LLC','Senglea');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('cbaudrys','Mayert and Sons','Pellegrini');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('mirvingn','Hilpert LLC','San Roque');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('sdruett17','Koss, Bins and Blick','Kimil’tey');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('rpassler16','Hammes, Donnelly and Lowe','Napenay');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('tfullstoneo','Klocko and Sons','Palatine');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('lkittles6','Daugherty, Keebler and Rau','Ash Shaykh ‘Uthmān');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('lnanii','Daugherty-Waelchi','Waterloo');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('rcullabinem','DuBuque-Koelpin','Capitán Bermúdez');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('eliddyf','Lakin, Dickens and Runte','Lianhe');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('lkittles6','Bins, Marvin and Bednar','Coruña, A');
INSERT INTO Trav_Act(Username,Name,Location) VALUES ('showles1c','Hegmann and Sons','Astghadzor');

-- insert data for trav_lodg table
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mshobrookh','Kautzer LLC','Ouidah');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('jblinkhorng','Orn, Nader and McDermott','Yulin');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('lgrimshawq','Howe-Pfeffer','Zhaoxian');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cchilds13','Terry LLC','Ketangi');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mpiensy','Conroy LLC','Malbork');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('imccullouch5','Conroy Group','Waingapu');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('kmaccallesterj','Lind-Stroman','Ushi');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('lgrimshawq','Reinger, Sporer and Marvin','Lelystad');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mslessar14','Walsh, Denesik and Tromp','Nongoma');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('zborlandl','Wolf, Treutel and Hansen','Leiria');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('tfullstoneo','Fahey Inc','Zvenyhorodka');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cchilds13','Towne-Wisoky','Netolice');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('sprothero3','Dickinson-Jerde','Fufang');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mpiensy','Murray Group','Lenīnskīy');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('hjerrardr','Aufderhar, Zieme and Halvorson','Himeji');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('bsalter8','Hamill Group','Paris 16');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('sprothero3','Sanford-Willms','Santa Fé do Sul');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('rpassler16','Weimann, Lockman and Schuppe','Luchenza');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('vphilpb','D''Amore-Reichert','Panyingkiran');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('sdruett17','Deckow-Rempel','Tarascon');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cbleasdalew','Purdy LLC','Ashibetsu');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('hjerrardr','Dietrich-Keebler','Chixi');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('imccullouch5','Howe and Sons','Kawalimukti');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('kmaccallesterj','Renner, Wuckert and Dietrich','Anjie');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mirvingn','Jast-Rutherford','Saint Croix');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('fbissetp','Luettgen LLC','Hongxi');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('tsheppey11','Lehner, Shields and Ebert','El Viejo');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('hjerrardr','Walker LLC','Darwin');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cchilds13','Larson, Bechtelar and Witting','Sanhe');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mirvingn','Lockman LLC','Stockholm');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cbaudrys','Harvey Group','Blobo');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('tfullstoneo','Cartwright and Sons','Tegalsari');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('scansdill0','Lang-D''Amore','Jiangluo');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('zborlandl','Abbott-Emard','Alegrete');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cbleasdalew','Williamson Inc','Žiželice');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('wstirript','Balistreri Inc','Tomakomai');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('showles1c','Padberg, Cremin and Berge','Smolenka');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cmarikhin2','Schimmel, Schultz and Gerhold','Parczew');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mshobrookh','McClure LLC','Mthatha');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('kmaccallesterj','Macejkovic Group','Dalumangcob');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('fbissetp','Simonis-Lind','Rio Grande da Serra');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('lnanii','Conroy Group','Atap');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('flankham7','Simonis Inc','Villa Ocampo');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('vrubinowk','Hand Group','Itupiranga');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cchilds13','Kunde LLC','Sestroretsk');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('hjerrardr','Bode, Jacobson and Boyle','Matarraque');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cmarikhin2','Dickens, McGlynn and Wisozk','Franca');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('rcullabinem','Hermiston, Hammes and Orn','Santol');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('spurdom1d','Streich, Smith and Reilly','Diriomo');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cbleasdalew','Jacobson-Hegmann','Nam Sách');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('nreaperx','Fritsch, Barrows and Yost','Jinchang');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('vdeyenhardt12','Satterfield LLC','Åkersberga');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('jblinkhorng','Gutkowski, Crist and Stroman','Tiwi');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cchilds13','Medhurst and Sons','Jinji');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('hboag18','Kirlin LLC','Manorom');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('hboag18','Carter-Kovacek','Olszanica');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('hjerrardr','Block LLC','Poggio di Chiesanuova');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('tfullstoneo','Medhurst LLC','Valongo');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('kmaccallesterj','Rutherford Inc','Mt Peto');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('rsmithsone','Gutmann-MacGyver','Manado');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('spurdom1d','Hansen-Lemke','Wasilków');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('bsalter8','Considine, Kerluke and Brown','Toulouse');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('hjerrardr','Hoeger, King and Veum','Mahdia');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cmarikhin2','McLaughlin-Schroeder','Zall-Dardhë');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('showles1c','Littel-Orn','Cali');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mslessar14','Blanda LLC','Usa River');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('rcullabinem','Yost, Botsford and Morar','Vĩnh Tường');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mpiensy','Roberts, Daniel and Feeney','Milwaukee');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('psiegertsza','Jacobs Inc','Göteborg');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('fbissetp','Wyman, McKenzie and Ullrich','Dongbang');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('sprothero3','Ziemann-Tremblay','Lodhrān');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('scansdill0','Wunsch and Sons','Senahú');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('showles1c','Hansen-Herzog','Huaping');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('hmoulton10','Cassin-Murray','Isfana');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('rsmithsone','Mante-Collier','Kalamáta');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('hboag18','Casper, Rowe and Effertz','Baziqiao');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('lkittles6','Ebert Group','Batangan');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mshobrookh','Ryan, Blanda and Pacocha','Puutura');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('sprothero3','Treutel-Dare','Rājshāhi');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('fmcleodc','Hermiston Inc','Porsgrunn');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('flankham7','Ward LLC','Velingrad');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cchilds13','Roob-Rice','Reisdorf');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mslessar14','Erdman-Thompson','Corzuela');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('kmaccallesterj','D''Amore-Price','Tongjiaxi');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cbleasdalew','Spinka LLC','Falun');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('lgrimshawq','Kessler and Sons','Belos Ares');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('fbissetp','Little, DuBuque and VonRueden','Warmare');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mpiensy','Dietrich Group','Elaiochóri');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('bsalter8','Hickle and Sons','Penang');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('cdcruze19','Romaguera, Volkman and McGlynn','Cestas');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('sdruett17','Sporer LLC','Siguinon');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mcush4','Monahan, Bruen and Upton','Kliteh');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('jseekingsu','Koss, Weber and Lueilwitz','Ainaži');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('jblinkhorng','Ernser and Sons','Guanban');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('hmoulton10','McLaughlin LLC','Sunbu');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('rcullabinem','Lueilwitz LLC','Xianshuigu');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('ispratt1a','Reinger, Corkery and Kutch','Chinch''ŏn');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('fmcleodc','Lind, Kulas and Morissette','Paulpietersburg');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('vphilpb','Leuschke Group','Valenciennes');
INSERT INTO Trav_Lodg(Username,Name,City) VALUES ('mirvingn','Stehr and Sons','Mayhan');

-- insert data for trav_group table
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('sprothero3','bbarcroft0','Blithe Barcroft');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('cchilds13','ehauxby1','Enriqueta Hauxby');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('tfullstoneo','aguiel2','Alfie Guiel');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('vrubinowk','zchallenor3','Zerk Challenor');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('wstirript','ayule4','Andrea Yule');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('kmaccallesterj','tleverage5','Theda Leverage');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('imccullouch5','knornasell6','Kirsten Nornasell');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('cmarikhin2','sdevericks7','Shermy Devericks');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('rskate1','cstileman8','Cindy Stileman');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('fmcleodc','mkhilkov9','Malva Khilkov');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('nreaperx','csybea','Cornie Sybe');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('cdcruze19','thedylstoneb','Thalia Hedylstone');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('jseekingsu','frodmellc','Friederike Rodmell');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('sdruett17','ralvard','Rosemaria Alvar');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('mpiensy','sciottie','Sander Ciotti');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('hmoulton10','bpiffef','Benny Piffe');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('fbissetp','kphysickg','Kaja Physick');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('scansdill0','lkennaghh','Leif Kennagh');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('tfullstoneo','eiltchevi','Esta Iltchev');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('tsheppey11','rcarruthj','Rog Carruth');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('nreaperx','cdomengek','Catherina Domenge');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('mcush4','mrigbyel','Marje Rigbye');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('kmaccallesterj','egrigolettim','Efren Grigoletti');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('cmarikhin2','tbreckenridgen','Theodosia Breckenridge');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('cbleasdalew','aproscheko','Alyssa Proschek');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('fmcleodc','opellingtonp','Odelia Pellington');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('cbleasdalew','mpacittiq','Marcos Pacitti');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('tsheppey11','csargoodr','Charlean Sargood');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('lkelberer15','pnunsons','Paula Nunson');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('zborlandl','sjendryst','Seana Jendrys');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('ispratt1a','nmedwayu','Nikkie Medway');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('rtschirschkyd','bsammesv','Brocky Sammes');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('eliddyf','jhurringw','Jedd Hurring');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('showles1c','amcasgillx','Ase McAsgill');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('mpiensy','lshelmardiney','Lindsey Shelmardine');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('mshobrookh','ncustz','Nertie Cust');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('nreaperx','kkeasey10','Killian Keasey');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('hmoulton10','msmaleman11','Manolo Smaleman');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('rpassler16','gbampford12','Godfrey Bampford');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('hjerrardr','igreatreax13','Ira Greatreax');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('imccullouch5','jshade14','Jobye Shade');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('lkelberer15','jullrich15','Jeramey Ullrich');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('jblinkhorng','jclive16','Jammal Clive');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('mshobrookh','ereddick17','Eleanor Reddick');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('hjerrardr','dshenley18','Debor Shenley');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('hboag18','blangford19','Bernete Langford');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('jseekingsu','ksteynor1a','Kym Steynor');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('bsalter8','caubrey1b','Cyndy Aubrey');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('rcullabinem','scavendish1c','Shurlocke Cavendish');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('cbaudrys','eboucher1d','Esme Boucher');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('hboag18','ylorne1e','Yancey Lorne');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('vphilpb','djohnsee1f','Dominik Johnsee');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('rcullabinem','whandrik1g','Wye Handrik');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('tfullstoneo','xmcmanamen1h','Xena McManamen');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('nreaperx','uvain1i','Ulrikaumeko Vain');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('vdeyenhardt12','scrampsy1j','Sela Crampsy');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('zborlandl','mfake1k','Merle Fake');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('mpiensy','kwiddop1l','Kiley Widdop');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('hmoulton10','kmcnaught1m','Karlotte McNaught');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('mshobrookh','wchrismas1n','Wilbert Chrismas');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('fbissetp','ispyer1o','Ignazio Spyer');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('mshobrookh','hlipp1p','Heddie Lipp');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('flankham7','fblasing1q','Faina Blasing');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('scansdill0','fneads1r','Francklin Neads');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('sprothero3','awellwood1s','Anna Wellwood');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('mcush4','cbodker1t','Celie Bodker');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('imccullouch5','bbatrip1u','Betteann Batrip');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('lgrimshawq','kheadland1v','Kaycee Headland');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('hboag18','sfilon1w','Stephen Filon');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('rsmithsone','mtigwell1x','Melany Tigwell');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('cdcruze19','tmacnulty1y','Templeton MacNulty');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('showles1c','hscarlett1z','Hailey Scarlett');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('hboag18','writeley20','Warren Riteley');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('nreaperx','wadshed21','Welch Adshed');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('sprothero3','gdaly22','Garek Daly');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('wstirript','roglesbee23','Roy Oglesbee');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('jseekingsu','amcgifford24','Alasdair McGifford');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('lkelberer15','abosnell25','Aurore Bosnell');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('tfullstoneo','ncluderay26','Neely Cluderay');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('edetloffv','msalan27','Myranda Salan');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('mslessar14','nrestieaux28','Neil Restieaux');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('cdavitashviliz','mboath29','Marisa Boath');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('psiegertsza','mfarryan2a','Marlie Farryan');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('sprothero3','rtuley2b','Rea Tuley');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('vphilpb','ttieman2c','Tailor Tieman');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('cdavitashviliz','sleedes2d','Sanders Leedes');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('ispratt1a','noliphand2e','Nickolas Oliphand');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('vrubinowk','atytterton2f','Amara Tytterton');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('ablind9','lmelendez2g','Lovell Melendez');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('mpiensy','fbaber2h','Felecia Baber');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('spurdom1d','mstarkings2i','Madella Starkings');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('rpassler16','lbeel2j','Lannie Beel');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('edetloffv','fgiamitti2k','Felita Giamitti');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('psiegertsza','nchatten2l','Nora Chatten');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('mpiensy','ghowroyd2m','Gertrude Howroyd');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('cbaudrys','kscurrah2n','Kalila Scurrah');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('rskate1','hvaudin2o','Howie Vaudin');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('lnanii','mtollit2p','Mathew Tollit');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('imccullouch5','lculcheth2q','Loy Culcheth');
INSERT INTO Trav_Group(Username,Name,Organizer) VALUES ('scansdill0','cbracegirdle2r','Cliff Bracegirdle');

-- insert data for host_plan table
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('dbrogi3','abernardinelli0');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('jhandyt','nomullaney15');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('mharriagno','rroscowt');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cbrittong','bkarpushkin1b');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('tbalasini11','fphayre3');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('atonryu','dblanden8');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('rfosberryh','ikolodziejj');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('clevecque1','oubachv');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('amayoh13','eaynscombez');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cfrancaisc','wditty14');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('lscrimshawx','hindgs1');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('vangrick2','lswatey');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('mharriagno','bdupreyp');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('glulham15','lashby10');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('roshavlany','bmccaghan9');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('lmarderp','lwoollam11');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('mweatherall19','bmccaghan9');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('bnapper12','rroscowt');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('srosengarten5','fdimitrievs');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cbrittong','jsetteringtonn');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('mlewendonw','bkarpushkin1b');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('fgrene10','bgerhold1d');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cbrittong','pturpiek');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('rcoppensm','cchaplainu');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('jjarmyn6','dblanden8');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cgymblettd','rroscowt');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('roshavlany','dblanden8');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cfinci16','rhampshawa');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('ctomczykiewicz7','chainey4');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('hslaffordz','fbengerr');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('vangrick2','scarayol19');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('mharriagno','bantoniutti18');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('ctomczykiewicz7','ikolodziejj');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('kmellenby9','bdupreyp');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('roshavlany','ydodsworth16');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('ssevina','jsidaryo');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('jjarmyn6','rrobinetx');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('mweatherall19','wghilardi17');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('jbarthod1d','hindgs1');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('vangrick2','bkarpushkin1b');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('rnutoni','cbidgode');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cfinci16','bmclardie5');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('lscrimshawx','jsetteringtonn');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('rcoppensm','scarayol19');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('tcastelloneb','bantoniutti18');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cgreguolir','chainey4');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('ssevina','cbidgode');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('nceschinin','torford12');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('lmarderp','ydodsworth16');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cfinci16','fdimitrievs');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('mlewendonw','gprevettw');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('mharriagno','swickendonb');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cgymblettd','hindgs1');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('tcastelloneb','rhampshawa');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('lscrimshawx','bdupreyp');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('mhansterl','ydodsworth16');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('amayoh13','bdupreyp');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('ctomczykiewicz7','lashby10');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('icrudginton17','pturpiek');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('mlewendonw','pturpiek');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('icrudginton17','dblanden8');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('srosengarten5','nomullaney15');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('rpylkynytons','hkenderd');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('ctomczykiewicz7','lbowrah');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('bhartle18','bantoniutti18');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('llowings1c','ikolodziejj');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('rpylkynytons','gprevettw');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('jquarton4','rrobinetx');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('xgrangier1b','bantoniutti18');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('rfosberryh','cchaplainu');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('jquarton4','hingramc');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('fgrene10','torford12');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('llowings1c','hkenderd');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('ctomczykiewicz7','jsetteringtonn');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('dbrogi3','phasnip2');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cgymblettd','bgerhold1d');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('jbarthod1d','jsidaryo');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('clevecque1','bmccaghan9');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cfinci16','theersm');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('lscrimshawx','skitherl');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('hmaccoughen0','cchaplainu');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('jquarton4','swickendonb');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('tbalasini11','hattfieldi');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cgreguolir','eaynscombez');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cfrancaisc','estatherg');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('lflear1a','cdenisovichq');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('hslaffordz','dblanden8');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('bhartle18','lwoollam11');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('jquarton4','hattfieldi');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('cgreguolir','fdimitrievs');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('mhansterl','bmclardie5');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('rcoppensm','lwoollam11');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('nceschinin','bdupreyp');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('clevecque1','cbidgode');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('tbalasini11','fdimitrievs');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('vangrick2','hingramc');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('roshavlany','sslatenf');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('fgrene10','lashby10');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('tbalasini11','eaynscombez');
INSERT INTO Host_Plan(HostUsername,PlannerName) VALUES ('rfosberryh','cdenisovichq');

-- insert data for host_disc table
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('hmaccoughen0','Meevee',27);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rfosberryh','Feedbug',22);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('tcastelloneb','Dabfeed',39);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('lscrimshawx','Photobug',89);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('hslaffordz','Roomm',59);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rpenddrethq','Skaboo',62);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('wizkoviciv','Dabtype',67);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('vangrick2','Jetwire',52);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('jquarton4','Flashpoint',16);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('lmendes8','Jamia',79);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('ssevina','Eadel',53);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('msellenk','Dynabox',92);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('vangrick2','Twitterlist',79);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('cfrancaisc','Gabtune',36);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('bnapper12','Devcast',40);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('bnapper12','Browseblab',53);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('ctomczykiewicz7','Meembee',99);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('cgymblettd','Gabtype',50);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('kmellenby9','Youfeed',89);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('lmendes8','Bluejam',81);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('wizkoviciv','Feedbug',36);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('jhandyt','Rhynoodle',60);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('tdavione','Pixope',34);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('glulham15','Oyoba',73);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('bnapper12','Jamia',22);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('mhansterl','Blogpad',76);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('lmarderp','Chatterbridge',93);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('llowings1c','Myworks',43);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('mlewendonw','Oyoyo',4);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rnutoni','Twiyo',44);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('ctomczykiewicz7','Eimbee',64);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rfosberryh','Kwideo',26);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('jquarton4','Wikivu',76);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rcoppensm','Meembee',54);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('msellenk','Skiptube',82);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('lscrimshawx','Thoughtworks',28);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('glulham15','Flashdog',43);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('fgrene10','Trilia',90);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('lflear1a','Wikido',53);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('mlewendonw','Twinder',10);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('hslaffordz','Pixope',62);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('amayoh13','Realbuzz',95);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('llowings1c','Fanoodle',3);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('glulham15','Tagfeed',50);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('roshavlany','Pixoboo',87);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('amayoh13','Zoombeat',80);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rfosberryh','Flipbug',84);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('cfrancaisc','Photojam',12);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('lflear1a','Agimba',17);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('jquarton4','Skajo',20);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('clevecque1','Skyndu',73);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('glulham15','Topicstorm',56);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('hmaccoughen0','Babbleopia',78);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('ssevina','Mydeo',62);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('jbarthod1d','Quaxo',47);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rfosberryh','Dynabox',49);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rcoppensm','Tekfly',45);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('cbrittong','Centimia',74);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('icrudginton17','Wikido',54);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('tcastelloneb','Lajo',41);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('bhartle18','Brainbox',44);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('kmellenby9','Topicblab',63);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rpylkynytons','Jabberbean',80);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('wizkoviciv','Realcube',80);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('cgymblettd','Jabbersphere',46);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('jdeclercj','Blogtag',51);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('bnapper12','Linkbuzz',18);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('clevecque1','Quimm',11);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('hmaccoughen0','Dynava',30);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('hsurcombef','Oyondu',86);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rfosberryh','Cogilith',69);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('cgymblettd','Vitz',85);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rcoppensm','Kamba',6);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('srosengarten5','Minyx',36);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('cgreguolir','Quimba',81);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rpenddrethq','Jayo',37);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('fgrene10','Layo',86);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('mlewendonw','Brainsphere',14);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('icrudginton17','Youspan',74);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rnutoni','Edgepulse',82);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('bhartle18','Photobug',20);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('jjarmyn6','Jatri',73);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rpylkynytons','Lajo',21);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('jbarthod1d','Youbridge',67);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('mharriagno','Jaxspan',13);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('bnapper12','Zava',80);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('srosengarten5','Livetube',61);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('lscrimshawx','Roombo',79);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('hmaccoughen0','Flipstorm',7);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('jquarton4','Yata',74);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('rpylkynytons','Oodoo',33);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('hslaffordz','Twitterwire',5);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('jdeclercj','Buzzdog',92);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('bnapper12','Ozu',41);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('tbalasini11','Devcast',11);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('srosengarten5','Agivu',34);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('glulham15','Jabbertype',62);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('mharriagno','Oyoloo',28);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('vangrick2','Quaxo',52);
INSERT INTO Host_Disc(Username,Name,DealPercent) VALUES ('msellenk','Wikizz',30);

-- insert data for plan_disc table
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('fdimitrievs','Meevee',27);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('eaynscombez','Feedbug',22);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('hkenderd','Dabfeed',39);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('torford12','Photobug',89);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('bantoniutti18','Roomm',59);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('adrogan1a','Skaboo',62);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('mtownes1c','Dabtype',67);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('torford12','Jetwire',52);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('xwibrow7','Flashpoint',16);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('lbowrah','Jamia',79);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('bdupreyp','Eadel',53);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('cbidgode','Dynabox',92);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('hindgs1','Twitterlist',79);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('rroscowt','Gabtune',36);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('dfriatt13','Devcast',40);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('phasnip2','Browseblab',53);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('lswatey','Meembee',99);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('hindgs1','Gabtype',50);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('abernardinelli0','Youfeed',89);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('cbidgode','Bluejam',81);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('ydodsworth16','Feedbug',36);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('fdimitrievs','Rhynoodle',60);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('hkenderd','Pixope',34);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('bgerhold1d','Oyoba',73);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('phasnip2','Jamia',22);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('xwibrow7','Blogpad',76);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('sslatenf','Chatterbridge',93);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('fbengerr','Myworks',43);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('gprevettw','Oyoyo',4);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('hingramc','Twiyo',44);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('ngyse6','Eimbee',64);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('cbidgode','Kwideo',26);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('bdupreyp','Wikivu',76);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('bantoniutti18','Meembee',54);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('gprevettw','Skiptube',82);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('wghilardi17','Thoughtworks',28);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('lswatey','Flashdog',43);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('cbidgode','Trilia',90);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('scarayol19','Wikido',53);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('xwibrow7','Twinder',10);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('hkenderd','Pixope',62);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('eaynscombez','Realbuzz',95);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('oubachv','Fanoodle',3);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('wditty14','Tagfeed',50);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('jsetteringtonn','Pixoboo',87);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('hkenderd','Zoombeat',80);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('bmclardie5','Flipbug',84);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('swickendonb','Photojam',12);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('cchaplainu','Agimba',17);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('bdupreyp','Skajo',20);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('hkenderd','Skyndu',73);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('gprevettw','Topicstorm',56);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('cdenisovichq','Babbleopia',78);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('oubachv','Mydeo',62);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('phasnip2','Quaxo',47);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('lswatey','Dynabox',49);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('hindgs1','Tekfly',45);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('cbidgode','Centimia',74);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('lbowrah','Wikido',54);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('hattfieldi','Lajo',41);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('jsetteringtonn','Brainbox',44);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('theersm','Topicblab',63);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('phasnip2','Jabberbean',80);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('swickendonb','Realcube',80);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('dblanden8','Jabbersphere',46);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('cchaplainu','Blogtag',51);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('mtownes1c','Linkbuzz',18);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('gprevettw','Quimm',11);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('skitherl','Dynava',30);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('lwoollam11','Oyondu',86);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('hindgs1','Cogilith',69);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('lswatey','Vitz',85);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('pturpiek','Kamba',6);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('mtownes1c','Minyx',36);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('fdimitrievs','Quimba',81);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('bkarpushkin1b','Jayo',37);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('oubachv','Layo',86);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('chainey4','Brainsphere',14);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('jsidaryo','Youspan',74);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('lbowrah','Edgepulse',82);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('hingramc','Photobug',20);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('pturpiek','Jatri',73);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('cbidgode','Lajo',21);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('skitherl','Youbridge',67);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('theersm','Jaxspan',13);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('lwoollam11','Zava',80);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('abernardinelli0','Livetube',61);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('nomullaney15','Roombo',79);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('phasnip2','Flipstorm',7);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('wditty14','Yata',74);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('fphayre3','Oodoo',33);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('cdenisovichq','Twitterwire',5);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('rrobinetx','Buzzdog',92);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('bkarpushkin1b','Ozu',41);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('bmclardie5','Devcast',11);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('adrogan1a','Agivu',34);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('oubachv','Jabbertype',62);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('fbengerr','Oyoloo',28);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('chainey4','Quaxo',52);
INSERT INTO Plan_Disc(Username,Name,DealPercent) VALUES ('mtownes1c','Wikizz',30);

-- insert data for trav_plan table
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('spurdom1d','wditty14');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('wstirript','swickendonb');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('fbissetp','hingramc');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('hboag18','cbidgode');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('lkittles6','rroscowt');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('flankham7','scarayol19');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('sdruett17','fbengerr');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('lkelberer15','bmccaghan9');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('hmoulton10','oubachv');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('scansdill0','hattfieldi');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('imccullouch5','phasnip2');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cmarikhin2','fbengerr');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('zborlandl','lashby10');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('sdruett17','swickendonb');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('flankham7','dblanden8');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('rsmithsone','jsetteringtonn');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cdavitashviliz','lbowrah');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('jseekingsu','wghilardi17');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('sdruett17','scarayol19');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('fmcleodc','lashby10');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('rtschirschkyd','jsidaryo');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('imccullouch5','hkenderd');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('kmaccallesterj','hindgs1');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('fmcleodc','lwoollam11');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('hjerrardr','bmclardie5');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('gstodart1b','cdenisovichq');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('lnanii','lbowrah');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('hboag18','phasnip2');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cdcruze19','dblanden8');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('lgrimshawq','hattfieldi');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('rpassler16','ngyse6');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('fbissetp','torford12');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cchilds13','dblanden8');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('jseekingsu','rhampshawa');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('rsmithsone','hattfieldi');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('rpassler16','lwoollam11');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('nreaperx','dblanden8');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('rsmithsone','pturpiek');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('imccullouch5','dfriatt13');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cbleasdalew','ikolodziejj');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('lgrimshawq','dfriatt13');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('rpassler16','hindgs1');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('jblinkhorng','sslatenf');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('mshobrookh','torford12');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('showles1c','ydodsworth16');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cdcruze19','lswatey');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cdavitashviliz','pturpiek');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('mcush4','fphayre3');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('rpassler16','mtownes1c');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('wstirript','estatherg');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cdcruze19','hindgs1');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('lgrimshawq','bmccaghan9');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('sdruett17','lbowrah');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('mirvingn','phasnip2');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cbaudrys','cbidgode');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('fbissetp','fbengerr');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('flankham7','dfriatt13');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('mslessar14','nomullaney15');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('nreaperx','bgerhold1d');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('vrubinowk','wghilardi17');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cchilds13','rhampshawa');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('fmcleodc','gprevettw');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('flankham7','hkenderd');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('rcullabinem','ngyse6');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('mslessar14','bkarpushkin1b');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('rcullabinem','scarayol19');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('jseekingsu','rrobinetx');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('rpassler16','hkenderd');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('flankham7','torford12');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('showles1c','lswatey');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('rpassler16','ydodsworth16');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('eliddyf','eaynscombez');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cchilds13','mtownes1c');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cdavitashviliz','skitherl');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('hjerrardr','cchaplainu');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('flankham7','lswatey');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('vrubinowk','fbengerr');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('tfullstoneo','jsidaryo');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('hboag18','swickendonb');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('spurdom1d','bgerhold1d');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cbleasdalew','estatherg');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('tsheppey11','rroscowt');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('tfullstoneo','ngyse6');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('scansdill0','xwibrow7');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('vrubinowk','xwibrow7');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('ablind9','hindgs1');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cdavitashviliz','bmccaghan9');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('ispratt1a','sslatenf');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('spurdom1d','hingramc');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cbaudrys','bantoniutti18');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('hboag18','adrogan1a');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('gstodart1b','wghilardi17');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('sdruett17','ngyse6');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('vrubinowk','bkarpushkin1b');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('cchilds13','fphayre3');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('lkelberer15','hingramc');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('mslessar14','jsidaryo');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('bsalter8','theersm');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('spurdom1d','ngyse6');
INSERT INTO Trav_Plan(TravelerUsername,PlannerUsername) VALUES ('tsheppey11','ydodsworth16');

-- insert data for act_itin table
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Toy, Hirthe and Willms','Limulan','jzsdobkgvg',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Gleason-Roob','Kyshtym','leqqyhupsa',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Wolff-Stark','Alcorriol','gjmwlfelsr',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Reynolds, Lockman and Steuber','Péfki','diyppbfwai',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Schaefer-Breitenberg','Brckovljani','reaigkkmuz',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Franecki Inc','Monastyryshche','pvzjqiivcv',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Flatley, Gerhold and Reinger','Meruge','sgmevxlbtz',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Lakin, Thiel and Kris','Dongxiang','vskrayxrmm',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Wehner Inc','Lindian','ahbmfiysae',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Williamson-Gottlieb','Joliet','aphnottmwj',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Koss, Bins and Blick','Kimil’tey','aphnottmwj',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Witting-Fisher','La Courneuve','pzuxiohtdt',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Oberbrunner, Kris and Morar','Pretoria','mfpgopueqc',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('D''Amore, Weissnat and Hansen','Huangsha','fejrqkyoth',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Gorczany-Erdman','Neftekamsk','molwuoblbt',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Braun Inc','Rogów','cgqahbbklt',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Cassin, Schimmel and Kshlerin','Mascote','czcekajwfr',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Langosh and Sons','Loures','cewthpvwpy',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Runolfsdottir LLC','Jambean','zdhgecmggk',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Lakin, Dickens and Runte','Lianhe','xrbbourotb',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Cole Inc','Grojec','cgqahbbklt',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Legros-Mitchell','Szubin','kwozfpcfko',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Toy, Hirthe and Willms','Limulan','jtfscnbfpf',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('VonRueden-Spinka','Gândara','gjmwlfelsr',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Kessler LLC','Lianshi','aphnottmwj',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('D''Amore, Weissnat and Hansen','Huangsha','gijwtdhbdm',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Murphy and Sons','Estância Velha','nkfmpfynxs',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Rosenbaum-Kuhic','Bonoua','dwifiodzhc',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Kirlin, Rau and Russel','Chía','uewftmvrqi',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Daugherty-Waelchi','Waterloo','jzsdobkgvg',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Nienow and Sons','Blagnac','zrlfknstgn',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Oberbrunner, Kris and Morar','Pretoria','icpffvmqda',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Collier LLC','Santa Luzia','reaigkkmuz',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Hegmann and Sons','Astghadzor','qxhukbmegv',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Greenholt Group','Sacramento','pvbdjqzozg',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Kuhn-Wilderman','Ambato Boeny','gjmwlfelsr',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Padberg-Schmitt','Shihuajian','zkabfsensu',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Hoppe, Dare and Daugherty','Papeete','ecltlwrjqb',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Wolff-Stark','Alcorriol','twwcetumyd',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Hegmann and Sons','Astghadzor','diyppbfwai',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Cassin, Schimmel and Kshlerin','Mascote','uewftmvrqi',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Oberbrunner, Kris and Morar','Pretoria','lqmpreivuk',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Cassin-Klocko','Yangchun','tfdfcvckik',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Tillman, Grimes and Sipes','Lons-le-Saunier','oecvzarnfb',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Gorczany-Erdman','Neftekamsk','gijwtdhbdm',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Conroy-Schiller','Margotuhu Kidul','rvtcqpztln',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Ortiz, Boyer and Gottlieb','Yanggu','jzsdobkgvg',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Legros-Mitchell','Szubin','fejrqkyoth',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Hilpert LLC','San Roque','nkfmpfynxs',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Franecki Inc','Monastyryshche','tfdfcvckik',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Heathcote-Botsford','Tangnan','fejrqkyoth',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Bailey Group','Xieshui','vmesnknjde',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Marquardt-Schmitt','Andongrejo','reaigkkmuz',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Kessler LLC','Lianshi','jtfscnbfpf',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Marks Inc','Storozhnytsya','aphnottmwj',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Jacobs and Sons','Gombong','jtfscnbfpf',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Bailey Group','Xieshui','molwuoblbt',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Pfannerstill-Hauck','Kromasan','leqqyhupsa',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Braun Inc','Rogów','invmgzdtqv',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Oberbrunner, Kris and Morar','Pretoria','dbdicrdfac',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Rutherford LLC','Senglea','zrswwwdfnf',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Pouros-Green','Huafeng','cgqahbbklt',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Schuppe-Abernathy','Metlika','ktsaqdkujf',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Howe, Runte and Romaguera','Oslo','leqqyhupsa',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Pfannerstill-Hauck','Kromasan','reaigkkmuz',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Kessler LLC','Lianshi','twwcetumyd',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Cassin-Klocko','Yangchun','bvslgxggqz',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Koss, Bins and Blick','Kimil’tey','waeyippdhe',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Kihn-Williamson','Katipunan','dbdicrdfac',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Morar-McDermott','Libacao','aphnottmwj',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Fay LLC','Al Manşūrah','gijwtdhbdm',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Bergnaum and Sons','El Hermel','ujswwhxxui',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Franecki Inc','Monastyryshche','xbptuaquiq',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Padberg-Schmitt','Shihuajian','dwifiodzhc',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Cassin-Klocko','Yangchun','smtkyajbcq',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Daugherty-Waelchi','Waterloo','waeyippdhe',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Hagenes LLC','Renxian','cgqahbbklt',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Klocko and Sons','Palatine','ecltlwrjqb',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Hagenes-Grady','Krechevitsy','pebkydlnhd',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Jast Inc','Gongjiahe','leqqyhupsa',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Kirlin, Rau and Russel','Chía','tfdfcvckik',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Nienow and Sons','Blagnac','zvtvoxmoja',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Oberbrunner, Kris and Morar','Pretoria','reaigkkmuz',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Wolff-Stark','Alcorriol','xrbbourotb',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Wintheiser-Douglas','Ranambeling','firhixtpjj',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('White, Beer and Flatley','Carapicuíba','pxddtuxolm',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Hamill, Quigley and Johns','Lyuban’','cgqahbbklt',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Oberbrunner, Kris and Morar','Pretoria','xzqxfpzbjx',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Wintheiser-Douglas','Ranambeling','dgpntznygl',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Pfannerstill-Hauck','Kromasan','zdhgecmggk',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Rutherford LLC','Senglea','acrshjbwjg',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Grimes-Lemke','Chamical','pxddtuxolm',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Ortiz, Boyer and Gottlieb','Yanggu','zvtvoxmoja',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('VonRueden-Spinka','Gândara','jtfscnbfpf',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Daugherty-Waelchi','Waterloo','qkpqsgodvh',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Parisian-Lynch','Ingenio La Esperanza','oecvzarnfb',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Reichel Inc','Unidad','pzuxiohtdt',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Simonis-Sipes','Llocllapampa','xzqxfpzbjx',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('DuBuque-Koelpin','Capitán Bermúdez','vskrayxrmm',NULL);
INSERT INTO Act_Itin(ActivityName,Location,ItineraryName,Datetime) VALUES ('Graham, Mitchell and Hudson','Dzhayrakh','ujswwhxxui',NULL);

-- insert data for travgroup_members table
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Enriqueta Hauxby','ehauxby1','ffarrin0');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Wilbert Chrismas','wchrismas1n','bdrysdall1');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Cindy Stileman','cstileman8','mmachan2');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Amara Tytterton','atytterton2f','ktomlett3');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Kym Steynor','ksteynor1a','aleggat4');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Nertie Cust','ncustz','afike5');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Jeramey Ullrich','jullrich15','cmacinherney6');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Neil Restieaux','nrestieaux28','omacandrew7');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Francklin Neads','fneads1r','laslum8');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Yancey Lorne','ylorne1e','mhollington9');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Benny Piffe','bpiffef','jdowdlea');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Rog Carruth','rcarruthj','cbilbieb');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Seana Jendrys','sjendryst','hlymbournec');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Bernete Langford','blangford19','rsiemanteld');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Nora Chatten','nchatten2l','lleete');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Anna Wellwood','awellwood1s','feverittf');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Roy Oglesbee','roglesbee23','amalamoreg');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Blithe Barcroft','bbarcroft0','ltrenbayh');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Faina Blasing','fblasing1q','cgarzi');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Aurore Bosnell','abosnell25','mfulfordj');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Theodosia Breckenridge','tbreckenridgen','rstanilandk');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Rog Carruth','rcarruthj','mgrittonl');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Lovell Melendez','lmelendez2g','kmeneerm');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Nickolas Oliphand','noliphand2e','sgeistn');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Killian Keasey','kkeasey10','wdykinso');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Kalila Scurrah','kscurrah2n','fpietp');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Cornie Sybe','csybea','dgligorijevicq');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Howie Vaudin','hvaudin2o','mmuzzlewhiter');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Gertrude Howroyd','ghowroyd2m','kgrigores');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Sela Crampsy','scrampsy1j','parthurst');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Felecia Baber','fbaber2h','ggribbleu');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Templeton MacNulty','tmacnulty1y','ecleavelandv');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Karlotte McNaught','kmcnaught1m','tlicencew');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Melany Tigwell','mtigwell1x','eedysonx');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Manolo Smaleman','msmaleman11','yalexsandrowiczy');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Jeramey Ullrich','jullrich15','ddopsonz');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Templeton MacNulty','tmacnulty1y','mmower10');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Warren Riteley','writeley20','smackilpatrick11');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Ira Greatreax','igreatreax13','ldulinty12');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Merle Fake','mfake1k','jdewitt13');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Seana Jendrys','sjendryst','mgillott14');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Kiley Widdop','kwiddop1l','atuison15');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Marje Rigbye','mrigbyel','mcamings16');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Cindy Stileman','cstileman8','cconan17');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Esme Boucher','eboucher1d','istickford18');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Alasdair McGifford','amcgifford24','nmenpes19');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Theodosia Breckenridge','tbreckenridgen','cblaiklock1a');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Warren Riteley','writeley20','elittler1b');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Kaycee Headland','kheadland1v','drappa1c');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Nora Chatten','nchatten2l','dseydlitz1d');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Kirsten Nornasell','knornasell6','vgainsford1e');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Amara Tytterton','atytterton2f','rrossbrook1f');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Yancey Lorne','ylorne1e','omunn1g');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Alasdair McGifford','amcgifford24','cbrasher1h');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Sanders Leedes','sleedes2d','iguittet1i');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Jammal Clive','jclive16','kcadle1j');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Bernete Langford','blangford19','hdooher1k');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Nertie Cust','ncustz','gfenlon1l');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Benny Piffe','bpiffef','jblunsen1m');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Rog Carruth','rcarruthj','kfeighry1n');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Odelia Pellington','opellingtonp','cfanthome1o');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Charlean Sargood','csargoodr','obarton1p');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Anna Wellwood','awellwood1s','mdoyle1q');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Heddie Lipp','hlipp1p','gwhaplington1r');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Godfrey Bampford','gbampford12','slukock1s');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Myranda Salan','msalan27','hplaistowe1t');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Felita Giamitti','fgiamitti2k','rmcguirk1u');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Celie Bodker','cbodker1t','ashorten1v');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Sela Crampsy','scrampsy1j','jellyatt1w');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Wye Handrik','whandrik1g','mraynard1x');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Ignazio Spyer','ispyer1o','yboys1y');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Leif Kennagh','lkennaghh','lbaudin1z');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Kaja Physick','kphysickg','ghowler20');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Loy Culcheth','lculcheth2q','bgajownik21');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Betteann Batrip','bbatrip1u','bpoppleton22');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Lovell Melendez','lmelendez2g','etaw23');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Seana Jendrys','sjendryst','hrosenbusch24');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Jeramey Ullrich','jullrich15','ebabst25');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Sander Ciotti','sciottie','sdurn26');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Felecia Baber','fbaber2h','astubbley27');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Friederike Rodmell','frodmellc','gbrockman28');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Theodosia Breckenridge','tbreckenridgen','aronca29');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Shermy Devericks','sdevericks7','kkuhlen2a');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Killian Keasey','kkeasey10','dfluck2b');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Lovell Melendez','lmelendez2g','aleman2c');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Faina Blasing','fblasing1q','klinford2d');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Jammal Clive','jclive16','adillingston2e');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Templeton MacNulty','tmacnulty1y','amorfey2f');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Nora Chatten','nchatten2l','kalmond2g');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Aurore Bosnell','abosnell25','etassell2h');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Lannie Beel','lbeel2j','mkimmerling2i');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Karlotte McNaught','kmcnaught1m','shenrique2j');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Lindsey Shelmardine','lshelmardiney','kbamblett2k');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Myranda Salan','msalan27','mloos2l');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Charlean Sargood','csargoodr','dattow2m');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Marisa Boath','mboath29','vboarleyson2n');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Madella Starkings','mstarkings2i','tburstowe2o');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Howie Vaudin','hvaudin2o','bhankard2p');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Kirsten Nornasell','knornasell6','mhattersley2q');
INSERT INTO TravGroup_Members(Organizer,Name,Member) VALUES ('Theda Leverage','tleverage5','abispo2r');

-- insert data for trav_likes_dislikes table
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('kmaccallesterj','amet lobortis sapien sapien non mi integer ac neque duis');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('hboag18','ridiculus mus etiam vel augue vestibulum rutrum rutrum neque');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mslessar14','nulla');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('rtschirschkyd','at feugiat non');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('eliddyf','fusce congue diam id ornare imperdiet sapien');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('tfullstoneo','ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('cbleasdalew','sapien cursus');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('edetloffv','integer non velit');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('nreaperx','posuere metus vitae ipsum');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('scansdill0','placerat ante nulla justo aliquam quis turpis eget');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('eliddyf','at vulputate vitae');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('vdeyenhardt12','sapien urna');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('edetloffv','lorem quisque ut erat curabitur gravida nisi');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('zborlandl','ipsum primis in');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('spurdom1d','curabitur in');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('lgrimshawq','curae mauris viverra diam');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('vphilpb','erat tortor sollicitudin');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('jblinkhorng','sagittis nam congue risus semper');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mcush4','donec semper sapien a libero nam dui');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('rcullabinem','vel lectus in quam fringilla rhoncus mauris enim');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('cdavitashviliz','vestibulum ante ipsum primis in faucibus orci luctus et ultrices');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('flankham7','quisque id');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('jseekingsu','ultrices posuere cubilia curae donec pharetra magna vestibulum');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('wstirript','habitasse platea dictumst etiam');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mslessar14','tempor convallis nulla neque libero convallis');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('fmcleodc','potenti cras in purus eu');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mpiensy','vestibulum ac est lacinia nisi venenatis tristique');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mslessar14','sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('hjerrardr','mauris ullamcorper purus sit amet nulla quisque arcu libero');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('tsheppey11','feugiat non pretium quis lectus suspendisse potenti in');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mshobrookh','vel augue vestibulum ante');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('rskate1','augue');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mpiensy','blandit nam nulla integer pede justo lacinia eget tincidunt eget');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('sprothero3','convallis nulla neque libero convallis eget eleifend luctus ultricies');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('lkittles6','nisi volutpat eleifend donec ut dolor');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('vdeyenhardt12','risus semper porta volutpat quam pede');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mshobrookh','tortor duis mattis egestas');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('vphilpb','et magnis dis parturient montes nascetur');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mcush4','lobortis est phasellus sit amet erat nulla tempus vivamus in');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mslessar14','odio condimentum id luctus nec molestie sed justo pellentesque');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mcush4','proin leo odio porttitor id consequat in consequat ut');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('cdavitashviliz','duis bibendum morbi non');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('rsmithsone','sit amet cursus id turpis');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('lkelberer15','elit proin risus praesent lectus vestibulum quam');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('jblinkhorng','eget semper rutrum nulla nunc purus phasellus in felis donec');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('fbissetp','parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('vrubinowk','aliquet pulvinar sed nisl nunc');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('psiegertsza','montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('ablind9','tempus vel pede morbi porttitor lorem id ligula suspendisse ornare');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('flankham7','a feugiat et eros vestibulum ac');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('cmarikhin2','sapien');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mshobrookh','erat id mauris vulputate elementum nullam varius nulla facilisi');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('lkelberer15','ac leo pellentesque ultrices mattis odio donec vitae nisi');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('vdeyenhardt12','potenti cras in');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('tfullstoneo','amet consectetuer adipiscing');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('nreaperx','purus eu magna vulputate luctus cum sociis natoque penatibus');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mslessar14','feugiat et');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('lgrimshawq','quisque arcu libero rutrum ac lobortis vel dapibus at diam');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('hboag18','convallis morbi odio odio elementum eu interdum eu');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('cbleasdalew','sapien urna pretium nisl ut volutpat sapien arcu');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('showles1c','amet consectetuer adipiscing elit proin');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('fbissetp','sed lacus morbi sem mauris laoreet ut');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('sdruett17','vulputate justo in blandit');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('vdeyenhardt12','nisi');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('tsheppey11','amet cursus id turpis integer aliquet');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('ablind9','ac lobortis vel dapibus at');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('cchilds13','ante ipsum primis');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('edetloffv','nisl duis bibendum');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('fmcleodc','at feugiat non pretium quis lectus');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('lkelberer15','viverra pede ac diam cras pellentesque');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('scansdill0','vel enim sit');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('zborlandl','dolor sit amet consectetuer adipiscing');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('hboag18','ipsum');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('ispratt1a','luctus et ultrices posuere cubilia curae duis');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('fmcleodc','lacus morbi sem mauris');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('jblinkhorng','sed tristique in tempus');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('rcullabinem','donec quis orci eget orci vehicula condimentum');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('cbleasdalew','quis odio consequat varius integer ac leo pellentesque');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('vphilpb','ante ipsum primis in faucibus orci luctus et ultrices');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('eliddyf','orci luctus et ultrices posuere');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('flankham7','quam pharetra');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('rsmithsone','bibendum imperdiet nullam orci');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('spurdom1d','turpis');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('rpassler16','nisi nam ultrices libero non');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('vdeyenhardt12','suscipit');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('fmcleodc','cum sociis natoque penatibus');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('lkittles6','donec dapibus duis at velit eu est congue elementum');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('eliddyf','lectus in quam fringilla rhoncus mauris enim leo');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('lkelberer15','habitasse platea dictumst morbi vestibulum velit id pretium iaculis');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('sdruett17','erat curabitur');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('rskate1','vestibulum ante');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('rsmithsone','sed augue aliquam erat volutpat in congue etiam');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('mslessar14','ultrices phasellus');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('jblinkhorng','nulla suscipit ligula');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('hmoulton10','venenatis non sodales');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('gstodart1b','praesent blandit lacinia erat vestibulum sed magna at nunc');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('lkittles6','vel pede morbi porttitor lorem id ligula suspendisse');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('tsheppey11','pharetra magna ac consequat metus');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('tfullstoneo','justo etiam pretium iaculis justo in hac habitasse platea dictumst');
INSERT INTO Trav_Likes_Dislikes(Username,Like_Dislike) VALUES ('vrubinowk','cras mi pede malesuada in');

-- insert data for adv_targetaudience table
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('gcbtyktele','Males');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('qbdheernvm','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('ruptgmhhrh','Families');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('gageoshgha','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('wwacbyekjt','Families');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('ylomknncut','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('apxmunhfih','Families');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('xxoerkpner','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('uwadqzlala','Males');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('zkqvaxnisp','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('clobrzkkgy','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('cqagutwysb','Families');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('lrtqpwfcxr','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('gvlfyzjeqj','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('xkqkmbvmtv','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('xxoerkpner','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('hrwyamrggm','Males');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('lolrzricwk','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('jsyvwzpywp','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('qmvsorxbih','Males');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('qbdheernvm','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('nfolfvsacc','Families');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('xcqhgisqqy','Females');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('tvtygktgyv','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('ekaavhjbar','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('ptgkjprafc','Females');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('dwiuxxclfi','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('jsyvwzpywp','Families');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('lrwbdgadoa','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('bxjasulggp','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('qixvcivqfq','Families');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('ruewcxqllg','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('qbdheernvm','Families');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('jhqgnfluqn','Families');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('olhxzklzze','Females');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('gcbtyktele','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('etoabwdzqn','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('ftvggedtqv','Females');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('cqagutwysb','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('lzxfxjsldv','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('dtfyxzbvdu','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('etoabwdzqn','Females');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('ylomknncut','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('kuqrembjpn','Males');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('nfolfvsacc','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('mkwmnoryab','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('lrwbdgadoa','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('elzmyzbckg','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('fxhmmbupgt','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('xcqhgisqqy','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('uwadqzlala','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('dwiuxxclfi','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('atkitjbijw','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('qixvcivqfq','Males');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('lpksolmmiy','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('hhyqaofcwl','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('hlkyncnzpu','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('kuqrembjpn','Females');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('jamctfgndl','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('jhqgnfluqn','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('clobrzkkgy','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('bhpewgxmce','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('xcqhgisqqy','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('ruptgmhhrh','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('lpksolmmiy','Females');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('ruptgmhhrh','Males');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('jsyvwzpywp','Males');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('jilmxvxenn','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('hddeogehvz','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('zkqvaxnisp','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('tvtygktgyv','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('ruewcxqllg','Families');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('nfolfvsacc','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('tldccdrrfk','Males');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('ewaulvjagg','Males');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('rkannfqkbb','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('fichmcnmuj','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('lpksolmmiy','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('orvxwwdtua','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('atkitjbijw','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('dtfyxzbvdu','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('kkwlajnrox','Families');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('iggoezhejv','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('kilfnaltax','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('etoabwdzqn','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('zpfskqjttw','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('jobxmnmniq','Families');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('xezreoyast','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('qixvcivqfq','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('qebnznoffm','5+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('jilmxvxenn','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('fichmcnmuj','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('jobxmnmniq','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('hhyqaofcwl','Under 18');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('xqhkihiymy','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('dtfyxzbvdu','All ages');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('ewaulvjagg','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('xxoerkpner','Males');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('siwiuroeup','18+');
INSERT INTO Adv_TargetAudience(Name,TargetAudience) VALUES ('jhqgnfluqn','Females');

-- insert data for act_restrictions table
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Grimes-Lemke','Chamical','quam a odio in hac habitasse');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Williamson-Gottlieb','Joliet','augue luctus tincidunt nulla mollis');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Marks Inc','Storozhnytsya','accumsan tortor quis turpis sed ante vivamus tortor duis');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('O''Keefe-Toy','Malabar','amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Cassin-Klocko','Yangchun','platea dictumst etiam faucibus cursus urna ut tellus nulla');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Daniel, Roob and Schultz','Panamá','praesent blandit nam nulla integer pede justo lacinia eget tincidunt');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Gleason-Roob','Kyshtym','odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Padberg-Schmitt','Shihuajian','tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Kris Group','Hexing','libero rutrum ac lobortis vel dapibus at diam nam tristique tortor eu');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('White, Beer and Flatley','Carapicuíba','malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Braun Inc','Rogów','at nulla');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Legros-Mitchell','Szubin','montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Hilpert-Konopelski','Kalanchak','eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Ortiz, Boyer and Gottlieb','Yanggu','turpis eget elit sodales scelerisque mauris sit');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Conroy-Schiller','Margotuhu Kidul','vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Marquardt-Schmitt','Andongrejo','nonummy integer non velit donec diam neque');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Pfannerstill-Hauck','Kromasan','ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Fay LLC','Al Manşūrah','amet justo morbi ut');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Kirlin, Rau and Russel','Chía','ut massa volutpat convallis morbi odio odio elementum');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Howe, Runte and Romaguera','Oslo','quisque id justo sit');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Reynolds, Lockman and Steuber','Péfki','tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Schuppe-Abernathy','Metlika','viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Quigley-Glover','Hidalgo','adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Franecki Inc','Monastyryshche','praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Cassin, Schimmel and Kshlerin','Mascote','suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Hamill, Quigley and Johns','Lyuban’','ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Langosh and Sons','Loures','penatibus et magnis dis parturient montes nascetur');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Bergnaum and Sons','El Hermel','vitae nisi nam ultrices libero non');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Nienow and Sons','Blagnac','enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Bergstrom-Fisher','Batu','curae duis faucibus accumsan');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Collier LLC','Santa Luzia','tincidunt lacus at velit vivamus vel nulla eget eros elementum');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Haley and Sons','Sima','sem fusce consequat nulla nisl nunc');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Romaguera Inc','Guangfu','consequat in consequat ut nulla');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Jacobs and Sons','Gombong','ac nulla sed');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Kassulke-Harvey','El Águila','nonummy integer non velit donec');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Kuhn-Wilderman','Ambato Boeny','in hac habitasse platea');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Wolff-Stark','Alcorriol','erat fermentum justo nec condimentum neque sapien placerat ante nulla');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Hagenes-Grady','Krechevitsy','ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Wehner Inc','Lindian','est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Hammes-Rath','Privodino','ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Kihn-Williamson','Katipunan','sed accumsan felis ut at dolor quis odio consequat varius');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Bailey Group','Xieshui','bibendum imperdiet');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Nienow-Wisozk','Piraju','turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Wilkinson Inc','Alkmaar','turpis adipiscing lorem');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Haag Inc','Novokayakent','a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Heathcote-Botsford','Tangnan','mus etiam vel augue vestibulum rutrum rutrum neque');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Hamill-Koelpin','Henggang','interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Vandervort and Sons','Pereleshino','id turpis integer aliquet massa id lobortis convallis');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Tillman, Grimes and Sipes','Lons-le-Saunier','sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Lakin, Thiel and Kris','Dongxiang','non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Zieme, Tromp and Rau','Pô','tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Jast Inc','Gongjiahe','lectus vestibulum quam sapien varius ut blandit non interdum in');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Effertz, Murphy and Herman','Beiyang','vel pede');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Graham, Mitchell and Hudson','Dzhayrakh','ut nulla');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Kessler LLC','Lianshi','sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Hoppe, Dare and Daugherty','Papeete','mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Pouros-Green','Huafeng','amet nulla');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Cole Inc','Grojec','tempus vivamus in felis eu sapien cursus');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Hegmann-Wunsch','Zhifang','massa id nisl venenatis lacinia aenean');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Goodwin LLC','Huangdimiao','dictumst etiam faucibus cursus urna ut tellus');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Murphy and Sons','Estância Velha','odio elementum eu interdum eu tincidunt in leo');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Mohr Inc','Demak','diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Osinski and Sons','Elmira','feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Toy, Hirthe and Willms','Limulan','sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Simonis-Sipes','Llocllapampa','eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Leuschke-Bergstrom','Pokrov','vel nulla eget eros elementum pellentesque quisque porta volutpat');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Hackett LLC','Galátsi','amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Stoltenberg-Thompson','Xinghe Chengguanzhen','habitasse platea dictumst etiam');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Batz and Sons','Pereyaslav-Khmel’nyts’kyy','integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Runolfsdottir LLC','Jambean','libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Wintheiser-Douglas','Ranambeling','iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('D''Amore, Weissnat and Hansen','Huangsha','mauris enim leo rhoncus sed vestibulum sit amet');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Greenholt Group','Sacramento','posuere felis sed lacus morbi sem');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Witting-Fisher','La Courneuve','imperdiet sapien urna pretium nisl ut volutpat sapien');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Hagenes LLC','Renxian','lobortis ligula sit amet eleifend pede libero');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Breitenberg-Cummerata','Kuvshinovo','in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Reichel Inc','Unidad','pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('VonRueden-Spinka','Gândara','at ipsum ac tellus semper interdum mauris ullamcorper purus');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Flatley, Gerhold and Reinger','Meruge','pede justo');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Macejkovic and Sons','Gowa','purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Oberbrunner, Kris and Morar','Pretoria','elit proin risus praesent');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Hirthe Group','Victoriaville','eleifend quam a odio in hac habitasse');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Schaefer-Breitenberg','Brckovljani','id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Gorczany-Erdman','Neftekamsk','maecenas tincidunt lacus at velit vivamus vel nulla eget eros');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Lindgren LLC','Jejkowice','sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Parisian-Lynch','Ingenio La Esperanza','erat tortor sollicitudin mi');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Rosenbaum-Kuhic','Bonoua','nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Morar-McDermott','Libacao','porttitor lorem id ligula suspendisse ornare consequat lectus in est');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Rutherford LLC','Senglea','curabitur in libero ut massa volutpat convallis morbi odio');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Mayert and Sons','Pellegrini','viverra diam vitae quam suspendisse potenti nullam');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Hilpert LLC','San Roque','aliquam sit amet');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Koss, Bins and Blick','Kimil’tey','ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Hammes, Donnelly and Lowe','Napenay','sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Klocko and Sons','Palatine','diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Daugherty, Keebler and Rau','Ash Shaykh ‘Uthmān','sollicitudin ut suscipit a feugiat et eros vestibulum ac');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Daugherty-Waelchi','Waterloo','aliquam convallis');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('DuBuque-Koelpin','Capitán Bermúdez','neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Lakin, Dickens and Runte','Lianhe','at turpis donec');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Bins, Marvin and Bednar','Coruña, A','non sodales sed tincidunt eu felis fusce');
INSERT INTO Act_Restrictions(Name,Location,Restrictions) VALUES ('Hegmann and Sons','Astghadzor','aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis');
