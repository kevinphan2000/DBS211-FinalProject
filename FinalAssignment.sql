-- DBS211 ZGG Final Project Milestone 3-Group 8

CREATE TABLE Properties (
    PropertyID INT IDENTITY(1,1) PRIMARY KEY,
    OwnerID INT NOT NULL,
    Address VARCHAR(255) NOT NULL,
    PropertyType VARCHAR(100) CHECK (PropertyType IN ('House', 'Condo', 'Apartment', 'Townhouse')),
    Status VARCHAR(50) CHECK (Status IN ('Available', 'Occupied')),
    RentPrice INT,
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
    LeaseID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    AmountToPay DECIMAL(8,2) NOT NULL,
    Status VARCHAR(50) CHECK (Status IN ('Available', 'Occupied')),
    PayMethod VARCHAR(50) CHECK (Method IN ('Cheque', 'Credit', 'Cash')),
    Purpose VARCHAR(50),
    FOREIGN KEY (LeaseID) REFERENCES Lease_Agreement(LeaseID)
)

