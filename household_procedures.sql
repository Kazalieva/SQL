DROP PROCEDURE IF EXISTS calculate_budget;
DELIMITER |
CREATE PROCEDURE calculate_budget(IN m VARCHAR(255), IN y YEAR)
BEGIN
	DECLARE m_income double;
    DECLARE m_expense double;
    DECLARE budget double;
    DECLARE fam_id int;
    DECLARE fam_name VARCHAR(100);
    
    DECLARE finished INT;
    
    DECLARE budgetCursor CURSOR FOR
		SELECT family_members.id, income.amount, expense.amount, (income.amount - expense.amount) as budget
        FROM family_members JOIN income ON income.family_income = family_members.id
        JOIN expense ON expense.family_expense = family_members.id
        WHERE m = income.month AND y = year(income.income_data)
				AND m = expense.month AND y = year(expense.expense_data);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    
	CREATE TEMPORARY TABLE  household_system.results(
		id INT PRIMARY KEY AUTO_INCREMENT,
         fam_id INT, 
         m_income DOUBLE, 
         m_expense DOUBLE, 
         budget DOUBLE
    )ENGINE = MEMORY;
    
    SET finished = 0;
    OPEN budgetCursor;
    WHILE(finished = 0)
    DO
		FETCH budgetCursor
        INTO fam_id, m_income, m_expense, budget;
        IF finished = 1 THEN
			CLOSE budgetCursor;
		ELSE
			IF budget > 0 THEN
				INSERT INTO results(fam_id, m_income, m_expense, budget)
                SELECT fam_id, m_income, m_expense, budget;
			ELSE
				SELECT CONCAT("Expenxes are more than income. ", ABS(budget)) AS "not enought";
			END IF;
        END IF;
	END WHILE;
    
    SELECT * FROM results;
    DROP TABLE results;
END;
|
DELIMITER ;

