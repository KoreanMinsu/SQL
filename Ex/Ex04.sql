--EQUI JOIN
SELECT
    first_name,
    department_name,
    em.department_id,
    de.department_id
FROM
    employees    em,
    departments  de
WHERE
    em.department_id = de.department_id;

--예제
SELECT
    first_name,
    em.department_id, de.department_id,
    jo.job_id, em.job_id 
    
FROM
    employees    em,
    departments  de,
    jobs         jo
WHERE
    em.department_id = de.department_id
    AND em.job_id = jo.job_id;

--LEFT OUTER JOIN
select e.department_id, e.first_name, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

select e.department_id, e.first_name, d.department_name
from employees e , departments d
where e.department_id = d.department_id(+);

--Right outer Join
select e.department_id, e.first_name, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

select e.department_id, e.first_name, d.department_name
from employees e , departments d
where e.department_id(+) = d.department_id; 

--right outer join-> left outer join
select em.emploee_id, em.first_name, em.department_id, de.department_name
from departments de outer join employyes em 
where em.;

--full outer join
select e.department_id, e.first_name, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

--SELF join
select    em.employee_id, 
            em.first_name,
            em.manager_id,
            ma.employee_id,
            ma.first_name,
            ma.phone_number
from employees em, employees ma
where em.manager_id = ma.employee_id;