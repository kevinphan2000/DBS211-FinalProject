-- DBS211 ZGG Final Project Milestone 3 - Group 8 (Create Table Script)
-- - Henry Lau (121235238)
-- - Hiu Fung Chan (106184237)
-- - Trung Kien Phan (123266231)
-- Date: 14 April 2024

/* Properties table creation */
CREATE TABLE Properties (
    PropertyID INT PRIMARY KEY,
    OwnerID INT NOT NULL,
    Address VARCHAR(255) NOT NULL,
    PropertyType VARCHAR(100) CHECK (PropertyType IN ('House', 'Condo', 'Apartment', 'Townhouse')),
    Status VARCHAR(50) CHECK (Status IN ('Available', 'Occupied')),
    RentPrice INT,
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID)
);

/* Owner table creation */
CREATE TABLE Owner (
    OwnerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(15) CHECK (ContactNumber LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
    Email VARCHAR(100) NOT NULL
);

/* Payment table creation */
CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    LeaseID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    AmountToPay DECIMAL(8,2) NOT NULL,
    Status VARCHAR(50) CHECK (LOWER(Status) IN ('initiated', 'pending', 'completed', 'cancelled')),
    PayMethod VARCHAR(50) CHECK (Method IN ('Cheque', 'Credit', 'Cash')),
    Purpose VARCHAR(50),
    FOREIGN KEY (LeaseID) REFERENCES Lease_Agreement(LeaseID)
);

/* Tenants table creation */
CREATE TABLE Tenants (
    TenantID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    ContactNumber VARCHAR(15) CHECK (ContactNumber LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
    CreditScore INT NOT NULL,
    Email VARCHAR(100) NOT NULL
);

/*Lease Agreement table creation*/
CREATE TABLE LeaseAgreement (
    LeaseID INT PRIMARY KEY,
    unitID INT NOT NULL,
    agentID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    FOREIGN KEY (unitID) REFERENCES Unit(unitID),
    FOREIGN KEY (agentID) REFERENCES Employee(employeeID)
);

/* MaintenanceRequest Table Creation */
CREATE TABLE MaintenanceRequests (
    requestID INT PRIMARY KEY,
    unitID INT NOT NULL, 
    superintendent INT NOT NULL,
    requestDate DATE NOT NULL,
    issueDescription VARCHAR(MAX) NOT NULL,
    vendorID INT NOT NULL,
    cost INT NOT NULL,
    status VARCHAR(100) CHECK (status IN ('Open', 'In Progress', 'Closed')),
    FOREIGN KEY (vendorID) REFERENCES Vendor(vendorID),
    FOREIGN KEY (superintendent) REFERENCES Employee(employeeID)
    FOREIGN KEY (unitID) REFERENCES Units(unitID)
);

/* Vendors table creation */
CREATE TABLE Vendors (
    vendorID INT PRIMARY KEY,
    serviceType VARCHAR(25) DEFAULT 'Cleaning',
    phone VARCHAR(11) NOT NULL,
    email VARCHAR(50) NOT NULL
);

/* Department table Creation */
CREATE TABLE Department (
    departmentID INT PRIMARY KEY,
    name VARCHAR(255),
    phone VARCHAR(15) CHECK (ContactNumber LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
    location VARCHAR(255)
);

/* Employees table Creation */
CREATE TABLE Employees (
    employeeID INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15) CHECK (ContactNumber LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
    departmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID)
);

/* Lease_Tenant table creation */
CREATE TABLE LeaseTenant (
    leaseID INT,
    tenantID INT,
    rentAmount DECIMAL(8,2) NOT NULL,
    downPayment DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (leaseID, tenantID),
    FOREIGN KEY (leaseID) REFERENCES LeaseAgreement(leaseID),
    FOREIGN KEY (tenantID) REFERENCES Tenants(tenantID),
);

/* Unit table creation */
CREATE TABLE Units (
    unitID INT PRIMARY KEY,
    propertyID INT,
    unitType VARCHAR(20) NOT NULL,
    area DECIMAL(8,2) NOT NULL,
    code VARCHAR(10) NOT NULL,
    FOREIGN KEY (propertyID) REFERENCES Properties(propertyID)
);

