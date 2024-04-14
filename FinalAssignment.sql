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


CREATE TABLE Tenants (
    TenantID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    ContactNumber VARCHAR(15) CHECK (ContactNumber LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
    CreditScore INT NOT NULL,
    Email VARCHAR(100) NOT NULL
)


CREATE TABLE LeaseAgreement (
    LeaseID INT PRIMARY KEY,
    unitID INT NOT NULL,
    agentID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    FOREIGN KEY (unitID) REFERENCES Unit(unitID),
    FOREIGN KEY (agentID) REFERENCES Employee(employeeID)
)


CREATE TABLE MaintenanceRequests (
    requestID INT PRIMARY KEY,
    unitID INT NOT NULL, 
    reportTo INT NOT NULL,
    requestDate DATE NOT NULL,
    issueDescription VARCHAR(MAX) NOT NULL,
    vendorID INT NOT NULL,
    cost INT NOT NULL,
    status VARCHAR(100) CHECK (status IN ('Open', 'In Progress', 'Closed')),
    FOREIGN KEY (vendorID) REFERENCES Vendor(vendorID),
    FOREIGN KEY (reportTo) REFERENCES Employee(employeeID)
);


CREATE TABLE Vendors (
    vendorID INT PRIMARY KEY,
    serviceType VARCHAR(25) DEFAULT 'Cleaning',
    phone VARCHAR(11) NOT NULL,
    email VARCHAR(50) NOT NULL
);

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    Name VARCHAR(255),
    Phone VARCHAR(255),
    Location VARCHAR(255)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID)
);

