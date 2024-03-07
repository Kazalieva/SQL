-- 1
DROP TRIGGER if exists before_salarypayment_delete;
delimiter |
CREATE TRIGGER before_salarypayment_delete BEFORE DELETE ON salarypayments
FOR EACH ROW
BEGIN
INSERT INTO salarypayments_log(operation, old_coach_id, old_month, old_salaryAmount, old_dateOfPayment, dateOfLog)
VALUES ('DELETE', OLD.coach_id, OLD.month, OLD.year, OLD.salaryAmount, OLD.dateOfPayment, NOW());
END;
|
delimiter ;

-- 2
INSERT INTO salaryPayments(coach_id, month, year, salaryAmount, dateOfPayment)
SELECT old_coach_id, old_month, old_year, old_salaryAmount, old_dateOfPayment FROM salarypayments_log
WHERE salarypayments_log.operation = 'DELETE';


-- 3 

drop trigger if exists before_student_sport_insert;
delimiter |
create trigger before_student_sport_insert before insert on student_sport
FOR EACH ROW
BEGIN
	declare gr_count int;
    select COUNT(NEW.student_id) into gr_count from student_sport;
    if gr_count > 2 then signal sqlstate "45000" set message_text = "already participates in 2 groups";
    end if;
end;
|
delimiter ;

-- 4 
drop view if exists student_groups;
create view student_groups as
select students.name, COUNT (student_sport.student_id)
from students JOIN student_sport on students.id = student_sport.student_id
group by students.name;

-- 5 

drop procedure if exists coaches_sports;
delimiter |
create procedure coaches_sports(in sportname varchar(50))
begin 
	select coaches.name, sportgroups.location, sportgroups.dayOfWeek, sportgroups.hoursOfTraining
    from coaches JOIN sportgroups ON coaches.id = sportgroups.coach_id
    JOIN sports ON sports.id = sportgroups.sport_id
    WHERE sports.name = sportname;
end;
|
delimiter ;