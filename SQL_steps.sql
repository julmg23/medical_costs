-- Create medical insurance db insurance
create database medical_insurance;

use medical_insurance;

-- Create table and import data from csv
CREATE TABLE `medical_insurance`.`insurance` (`age` int, `sex` text, `bmi` double, `children` int, `smoker` text, `region` text, `charges` double)
PREPARE stmt FROM 'INSERT INTO `medical_insurance`.`insurance` (`age`,`sex`,`bmi`,`children`,`smoker`,`region`,`charges`) VALUES(?,?,?,?,?,?,?)'

SELECT * FROM insurance

-- Remove duplicates

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER(
    PARTITION BY age,
				sex,
                region,
                charges
                ORDER BY
					charges
                    ) row_num
FROM medical_insurance.insurance
)
SELECT *
FROM RowNumCTE
WHERE row_num > 1

-- Found 1 duplicte. male 19 BMI 30.59 charges 1639.5631

DELETE
FROM medical_insurance.insurance
WHERE sex = 'male'
	AND bmi = 30.59
    AND charges = 1639.5631

-- Change charges column from double to money datatype

ALTER TABLE insurance MODIFY charges DECIMAL(16,4)

DESCRIBE insurance

-- Export as csv file

SELECT `age`,`sex`,`bmi`,`children`,`smoker`,`region`,`charges` 
FROM `medical_insurance`.`insurance`

