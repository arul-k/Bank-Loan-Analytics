SELECT * FROM `credit history`;
SELECT * FROM `loan data`;
DESC `loan data`;
DESC `credit history`;

-- KPI 1: Year-wise loan amount Stats
SELECT 
    YEAR(STR_TO_DATE(issue_d, '%d-%m-%Y')) AS `Year`,
    CONCAT(ROUND((SUM(loan_amnt)/1000000),2), "M") AS `Loan Amount`
FROM
    `loan data`
    GROUP BY `Year` ORDER BY `Year`;
-- ________________________________________________________________________________________________________________________
-- ________________________________________________________________________________________________________________________     
   
-- KPI 2: Grade and sub-grade wise revolving balance
SELECT 
    grade, sub_grade, CONCAT(ROUND((SUM(revol_bal)/1000000),2), "M") `Revolving Balance`
FROM
    `loan data` l
        LEFT JOIN
    `credit history` c ON l.id = c.id
GROUP BY grade , sub_grade ORDER BY grade, sub_grade;
-- ________________________________________________________________________________________________________________________    
-- Pass an valid argument: Either "ALL" or "A-G" procedure name is "kpi2"
CALL `kpi2`("ALL");
CALL `kpi2`("A");
CALL `kpi2`("B");
CALL `kpi2`("C");
CALL `kpi2`("D");
CALL `kpi2`("E");
CALL `kpi2`("F");
CALL `kpi2`("G");
CALL `kpi2`("Group 5 Project demo");
-- ________________________________________________________________________________________________________________________  
-- ________________________________________________________________________________________________________________________    
  
-- KPI 3: Total Payment for Verified Status Vs Total Payment for Non Verified Status
SELECT 
    verification_status,
    CONCAT(ROUND((SUM(total_pymnt) / (SELECT 
            SUM(total_pymnt)
        FROM
            `credit history`))*100,2), "%") total_payment
FROM
    `loan data` l
        LEFT JOIN
    `credit history` c ON l.id = c.id
GROUP BY verification_status;
-- ________________________________________________________________________________________________________________________    
-- ________________________________________________________________________________________________________________________    

-- KPI 4: State-wise and month-wise loan status
# Parameter 1: States
-- AK, AL, AR, AZ, CA, CO, CT, DC, DE, FL, GA, HI, IA, ID, IL, IN, KS, KY, LA, MA, MD, ME, MI, MN,
-- MO, MS, MT, NC, NE, NJ, NM, NV, NY, OH, OK, OR, PA, RI, SC, SD, TN, TX, UT, VA, VT, WA, WI, WV, WY
# Parameter 2: loan status : 
-- Current, Charged off, Fully Paid
CALL `kpi4`("AK");
CALL `kpi4`("AL");
-- ________________________________________________________________________________________________________________________
-- ________________________________________________________________________________________________________________________   

-- KPI 5 Home ownership Vs last payment date stats
-- UPDATE `loan data` SET home_ownership = "OTHER" WHERE home_ownership = "NONE";
SELECT * FROM `credit history`;
SELECT 
    YEAR(STR_TO_DATE(last_pymnt_d, '%d-%m-%Y')) `Year`,
    home_ownership,
    COUNT(*) `count`
FROM
    `loan data` l
        LEFT JOIN
    `credit history` c ON l.id = c.id 
GROUP BY home_ownership , `Year` HAVING `Year` IS NOT NULL
ORDER BY `Year`; 
-- year is from 2008 to 2016, input parameter is year
CALL `kpi5`(2008);
CALL `kpi5`(2012);
CALL `kpi5`(2016);
-- ___________________________________________________________________________________________________________________________________




