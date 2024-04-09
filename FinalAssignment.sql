-- DBS211 ZGG Final Project Milestone 3-Group 8

CREATE TABLE Properties (
    PropertyID INT IDENTITY(1,1) PRIMARY KEY,
    OwnerID INT NOT NULL,
    Address VARCHAR(255) NOT NULL,
    PropertyType VARCHAR(100) CHECK (PropertyType IN ('House', 'Condo', 'Apartment', 'Townhouse')),
    Status VARCHAR(100) CHECK (Status IN ('Available', 'Occupied')),
    RentPrice NUMBER(7,2),
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID)
)


CREATE TABLE Owner (
    OwnerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(15) CHECK (ContactNumber LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
    Email VARCHAR(100) NOT NULL
)


CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    
)
