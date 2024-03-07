USE household_system;
DROP TRIGGER IF EXISTS family_member_trigger;
DROP TRIGGER IF EXISTS update_family_members;

DELIMITER *
CREATE TRIGGER family_member_trigger BEFORE INSERT ON family_members
FOR EACH ROW
BEGIN
IF (CHAR_LENGTH(NEW.egn) < 10) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The EGN must be 10 characters!';
END IF;
IF (CHAR_LENGTH(NEW.name) = 0) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The name have not be null!';
END IF;
IF (NEW.income_month < 0 ) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The month have not be negative number!';
END IF;
END;
*
DELIMITER ;

CREATE TABLE IF NOT EXISTS family_members_log(
id INT AUTO_INCREMENT PRIMARY KEY,
operation ENUM('INSERT', 'DELETE' , 'UPDATE') NOT NULL,
old_address VARCHAR(255),
new_address VARCHAR(255),
old_phone VARCHAR(10),
new_phone VARCHAR(10),
old_income_month DOUBLE,
new_income_month DOUBLE,
dateOfLog DATETIME
);

DELIMITER *
CREATE TRIGGER update_family_members AFTER UPDATE ON family_members
FOR EACH ROW
BEGIN
INSERT INTO family_members_log(operation, old_address,new_address, old_phone, new_phone, old_income_month, new_income_month,dateOfLog)
VALUES ('UPDATE', 
		OLD.address,
        CASE NEW.address WHEN OLD.address THEN NULL ELSE NEW.address END,
        OLD.phone,
        CASE NEW.phone WHEN OLD.phone THEN NULL ELSE NEW.phone END,
        OLD.income_month,
        CASE NEW.income_month WHEN OLD.income_month THEN NULL ELSE NEW.income_month END,
        NOW());
 END; 
 *
 DELIMITER ;
 

use household_system;
/*
INSERT INTO family_members (egn, name, gender, address, email, phone, income_month)
VALUES 
('1234567897', '', 'M', '123 Main St, Los Angeles USA', 'johnsmith@gmail.com', '555-1234', -5000);
*/
UPDATE family_members 
SET income_month = '3000' WHERE id = 1;
# SELECT * FROM family_members_log;

UPDATE family_members 
SET address = 'Galileo Galilei' WHERE id = 1;
SELECT * FROM family_members_log;




