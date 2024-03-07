use household_system;

/*
-- смяна на адрес
UPDATE shops
SET address = 'Tsar Osvoboditel'
where id = 4;
*/

-- пропуска за месец септември
/*
INSERT INTO income (amount, income_data, month, description, family_income) 
VALUES (1500.00, '2022-09-05', 'September', 'Salary', 1),
		(1500.00, '2022-09-06', 'September', 'Freelance projects', 1),
		(3500.00, '2022-09-05', 'September', 'Freelance', 1);
*/  

-- 2
SELECT shops.name, shops.address, shops.phone AS INFO
FROM shops
WHERE shops.town = 'Sofia' AND shops.address = 'Tsar Osvoboditel';

-- 3
SELECT SUM(expense.amount) AS 'all expenses',expense.month AS month, MAX(expense.amount) AS max
FROM expense
GROUP BY expense.month
ORDER BY expense.month;

-- 4
SELECT belongings.name AS belonging, shops.name AS shop, manufacturers.name AS manufacturer, categories.name AS category
FROM belongings
JOIN  shops ON shops.id = belongings.shop_id
JOIN manufacturers ON manufacturers.id = belongings.manufacturer_id
JOIN categories ON categories.id = belongings.category_id
ORDER BY belongings.name;

-- 5
SELECT belongings.name AS belonging, belongings.data_buying AS 'data of buying', repairs.name AS repair, repairs.status AS status, repairs.description AS description
FROM belongings
LEFT JOIN repairs ON repairs.id = belongings.repair_id
ORDER BY belongings.data_buying DESC;

-- 6
SELECT family_members.name AS person, tasks.name AS task
FROM family_members
JOIN tasks ON family_members.id IN 
			(SELECT family_member_task.member_id
            FROM family_member_task
            WHERE family_member_task.task_id = tasks.id
            );
            
-- 7
SELECT family_members.name AS name, SUM(income.amount) AS 'income for month',income.month AS month
FROM family_members
JOIN income ON income.family_income = family_members.id
GROUP BY income.month,family_members.name
LIMIT 12;


            
    




