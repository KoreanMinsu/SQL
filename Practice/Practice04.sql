--문제1: 평균 급여보다 적은 급여을 받는 직원
SELECT
    COUNT(salary)
FROM
    employees
WHERE
    salary < (
        SELECT
            AVG(salary)
        FROM
            employees
    );
                
--문제2: 평균급여 이상, 최대급여 이하의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세
SELECT
    employee_id,
    first_name,
    e.salary
FROM
    employees e
    
WHERE
    salary >= ( select avg(salary) aSal
                from employees )
order by e.salary asc;

--문제3: Steven King 의 부서 주소를 알아보고자함. 
--도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 나라아이디(country_id) 를 출력
SELECT
    lo.location_id,
    street_address,
    postal_code,
    city,
    state_province,
    country_id
FROM
    locations  lo,
    (
        SELECT
            location_id
        FROM
            employees    em,
            departments  de
        WHERE
                em.department_id = de.department_id
                AND first_name = 'Steven'
                AND last_name = 'King'
    )   sk
WHERE
    sk.location_id = lo.location_id;      

--문제4: job_id 'ST_man'인 직원의 급여보다 작은 직원의 사번,이름, 급여/급여 내림차순 Any연산자 사용
SELECT
    employee_id    AS "사번",
    first_name
    || ' '
    || last_name   AS "이름",
    salary         AS "급여"
FROM
    employees
WHERE
    salary < ANY (
        SELECT
            salary
        FROM
            employees
        WHERE
            job_id = 'ST_MAN'
    )
ORDER BY
    salary DESC;

--문제5: 부서별 최고급여 사원의 직원번호, 이름, 급여, 부서번호 조회 // 급여 내림차순 정렬 &조건절비교, 테이블조인 2가지로
--1) Join
SELECT
    e.employee_id,
    e.first_name,
    e.salary,
    e.department_id
FROM
    employees  e,
    (
        SELECT
            department_id,
            MAX(salary) salary
        FROM
            employees
        GROUP BY
            department_id
    )          mx
WHERE
        e.department_id = mx.department_id
    AND e.salary = mx.salary
ORDER BY
    e.salary DESC;
--2) 조건절비교
SELECT
    employee_id,
    first_name,
    salary,
    department_id
FROM
    employees
WHERE
    ( department_id, salary ) IN (
        SELECT
            department_id, MAX(salary)
        FROM
            employees
        GROUP BY
            department_id
    )
ORDER BY
    salary DESC;                               


--문제6: 업무별 연봉의 총합/ 업무명(job_title)과 연봉총합 - 연봉총합 높은 업무부터 조회
SELECT
    job_title,
    (salary * cNum) AS " 연봉총합"
FROM
    jobs j, ( SELECT
                   AVG(salary) salary,
                   COUNT(job_id) cNum,
                   job_id
              FROM
                   employees
              GROUP BY
                   job_id) avc
where avc.job_id = j.job_id
order by (salary * cNum) desc;

--문제7: 자신부서 평균급여 보다 연봉 많은 직원의 직원번호, 이름, 급여 조회
select e.employee_id,
       e.first_name,
       e.salary
from employees e ,(select avg(salary) aSal ,
                          department_id
                   from employees
                   group by department_id) ae 
where salary > aSal 
and e.department_id = ae.department_id;

--문제8: 입사일 11번째 ~ 15번째 직원의 사번, 이름, 급여, 입사일 //입사일순서 출력
select  ort.employee_id, 
        ort.first_name,
        ort.salary,
        ort.hire_date      
from (
        select rownum rn,
               ot.employee_id,
               ot.first_name,
               ot.salary,
               ot.hire_date
        from 
                (select employee_id,
                        first_name,
                        salary,
                        hire_date
                from employees
                order by hire_date asc) ot
                where rownum <= 15
      ) ort
where rn >= 11;