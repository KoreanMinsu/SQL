/* 그룹함수 */

--단일행함수
SELECT
    first_name,
    round(salary, - 4)
FROM
    employees;

--그룹함수 -> 오류발생 (이유 확인)
SELECT
    first_name,
    AVG(salary)
FROM
    employees;

--그룹함수 avg()
SELECT
    AVG(salary)
FROM
    employees;

--그룹함수 count()
SELECT
    COUNT(*), --null 포함
    COUNT(first_name),
    COUNT(commission_pct)--null 제외 카운트
FROM
    employees;

--count()  + 조건추가
SELECT
    COUNT(*)
FROM
    employees
WHERE
    salary > 16000;

--그룹함수 sum()
SELECT
    SUM(salary),
    COUNT(*) -- 각각 하나의 row 로 에러 발생 X
FROM
    employees;

--avg() null도 포함되어 계산되므로 null값을 0으로 바꿔 사용
SELECT
    COUNT(*), --107
    COUNT(commission_pct), --커미션 있는 35
    sum(commission_pct), -- 전체 합
    
    avg(commission_pct), -- null값 제외한 35인원으로 계산
    sum(commission_pct)/count(commission_pct), -- null 값 제외
    
    avg(nvl(commission_pct,0)), -- null ->0 으로 계산되어 평균반영
    sum(commission_pct)/count(*) -- null값 포함
from employees;

--그룹함수 max()/min()
select max(salary), min(commission_pct)
from employees;

select first_name, max(salary) --에러발생
from employees;

-------
/*group by*/
select department_id,count(*), sum(salary) 
--group by에 참여 컬럼&그룹만 가능
from employees
group by deparment_id;

--안되는경우
select department_id, job_id, count(*), avg(salary) --job_id
from employees;
group by department_id;

--그룹세분화
select department_id, job_id, avg(salary)
from employees
group by department_id, job_id;

--그룹화 예제 // group 함수는 where사용 불가 (where) 단일 row
select department_id, count(*), sum(salary)
from employees
--where sum(salary) >=20000 불가
group by department_id;

--having 절
select department_id, count(*), sum(salary)
from employees
having sum(salary) >=20000 --having - 
group by department_id;

select department_id, count(*), sum(salary)
from employees
group by department_id
having sum(salary) >=20000
and department_id=100;

--그룹함수 case ~ end // if~ else 와 유사
select  employee_id,
        job_id,
        salary,
case when job_id = 'ac_accunt' then salary + salary*0.1
when job_id = 'sa_rep' then salary + salary*0.2
when job_id = 'st_clerk' then salary + salary*0.3
else salary
end realsalary
from employees;

--예제
select  first_name,
		department_id, 
		case when department_id >= 10 and department_id <= 50 then 'A-Team'
			 when department_id >= 60 and department_id <= 100 then 'A-Team'
			 when department_id >= 110 and department_id <= 150 then 'A-Team'
			 else '팀없음'
		end as team
from employees;

--decode(컬럼, 조건, ture 값, false 값) ==일때만 가능
select employee_id,
    salary,
    decode(job_id, 'ac_account', salary+salary*0.1,
    'sa_rep', salary + salary*0.2,
    'st_clerk',salary + salary*0.3,
    salary) realSalary
from employees;    

