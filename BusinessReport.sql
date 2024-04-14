-- DBS211 ZGG Final Project Milestone 3 - Group 8
-- - Henry Lau (121235238)
-- - Hiu Fung Chan (106184237)
-- - Trung Kien Phan (123266231)
-- Date: 14 April 2024

-- Topic: Database for Rental Property Management System - Business Report

/*
   Case 1: Identifying the Top Real Estate Agent of the Month

   Purpose:
   The view is created in order to identify who is the most successful real estate agent of a particular month, based on how many
   valid leasing contracts they have initiated within the month. The number is determined by counting the number of the leasing contracts
   with their starting date within the current month and is associated with a particular real estate agent.
   
   Benefits:
   This view could management level to recognize and reward the agent staff with the top performance. It could not only provide more
   incentive to the staff members, but also motivates other staff to strive for better performance so as to compete for the award. On the other
   hand, by comparing the leasing contracts initiased by various agent staff, management could also realise those underperformed agent staff and
   could suggest extra training to them for their improvement. Lastly, based on the trend of the number of valid leasing contracts, management
   could understand the business environment, which could faciliate subsequent strategic planning that could antipicate the market demand and
   allocate the resources more effciently.
*/

-- SQL Query for view
-- List the information of each leasing contract, including the start date and the corresponding real estate agent
CREATE VIEW LeaseAgentDate AS
SELECT 
    la.LeaseID, 
    e.firstName, 
    e.lastName, 
    la.StartDate
FROM 
    LeaseAgreement la
JOIN 
    Employees e ON la.agentID = e.employeeID;

-- Query the view to get the best agent for each month
SELECT 
    lad1.firstName, 
    lad1.lastName, 
    lad1.StartDate AS Month,
    (SELECT lad2.LeaseID FROM LeaseAgentDate lad2 
     WHERE lad2.firstName = lad1.firstName AND lad2.lastName = lad1.lastName AND lad2.StartDate = lad1.StartDate) AS LeaseID
FROM 
    LeaseAgentDate lad1
LEFT JOIN 
    LeaseAgentDate lad3 ON lad1.firstName = lad3.firstName AND lad1.lastName = lad3.lastName AND lad1.StartDate = lad3.StartDate
WHERE 
    lad3.LeaseID IS NULL OR lad1.LeaseID < lad3.LeaseID
ORDER BY 
    Month DESC, 
    LeaseID DESC;

/*
   Case 2: Identifying the backlog of Maintenance Requests

   Purpose:
   The view is to find out which maintenance request already there for at least 1 months not being closed or completed.

   Benefits:
   By checking if there are a backlog of maintenance requests, we could inform the person in charge to prioritise their tasks to take care of those tasks.
*/ 

CREATE VIEW MAINTENANCEREQBACKLOG AS
        SELECT
            E.EMPLOYEEID,
            E.FIRSTNAME,
            E.LASTNAME,
            E.EMAIL,
            ROUND(MONTHS_BETWEEN(SYSDATE, MR.REQUESTDATE), 1) AS MONTHDIFF,
            MR.REQUESTID,
            u.code,
            p.address,
            p.name
        FROM
            MAINTENANCEREQUESTS MR
            JOIN EMPLOYEE E
               ON MR.SUPERINTENDENT = E.EMPLOYEE
            JOIN UNITS u
               ON MR.UNITID = u.UNITID
            JOIN Properties p
               On p.PropertyID = u.propertyID
        WHERE
            MONTHS_BETWEEN(SYSDATE, MR.REQUESTDATE) > 1
            AND MR.STATUS IN ('Open', 'In Progress')
        ORDER BY
            MONTHDIFF DESC;


/*
   Case 3: List all properties per Owner.

   Purpose: This view displays the number of properties each owner has.

   Benefits: It can be beneficial for segmenting the market or discovering potential clients.
*/

CREATE OR REPLACE VIEW PropertiesPerOwner AS
SELECT Owner.OwnerID, 
    Owner.ContactNumber,
    Owner.FirstName || ' ' || Owner.LastName AS "Full Name",
    COUNT(Properties.PropertyID) AS NumOfProperties
FROM Owner
JOIN Properties ON Owner.OwnerID == Properties.OwnerID
GROUP BY Owner.OwnerID, Owner.ContactNumber


