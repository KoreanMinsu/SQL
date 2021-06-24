--문제 1: 입사일 오름차순/ 이름(firstname, lastname) 월급 전화번호 입사일 순서 컬럼이름 변경후 출력
SELECT
    first_name
    || ' '
    || last_name   "이름",
    salary         "월급",
    phone_number   "전화번호",
    hire_date      "입사일"
FROM
    employees
ORDER BY
    hire_date ASC;

--문제2: 업무(jobs)별 업무이름(job_title)과 최고월급 월급 내림차순 정렬
SELECT
    job_title,
    max_salary
FROM
    jobs
ORDER BY
    max_salary DESC;


--문제3: 담당매니저 있으나 커미션 비율 없고, 월급 3000초과 직원의 이름, 매니저아이디, 커미션 비율, 월급 출력
SELECT
    first_name,
    manager_id,
    commission_pct,
    salary
FROM
    employees
WHERE
    manager_id IS NOT NULL
    AND commission_pct IS NULL
    AND salary > 3000;

--문제4:  최고월급이 10000 이상인 업무 이름과 최고월급, 최고 월급 내림차순 정렬
SELECT
    job_title,
    max_salary
FROM
    jobs
WHERE
    max_salary >= 10000
ORDER BY
    max_salary DESC;
 
-- 문제5: 월급 14000 미만, 10000이상 직원의 이름, 월급, 커미션 퍼센트를 월급 내림차순 출력, 커미션 퍼센트가 null 일시 0 
SELECT
    first_name,
    salary,
    nvl(commission_pct, 0)
FROM
    employees
WHERE
        salary >= 10000
    AND salary < 14000
ORDER BY
    salary DESC;
    
--문제 6: 부서번호가 10,90,100인 직원의 이름, 월급일, 입사일, 부서번호 (입사일은 1977-12) 와 같이 표시    
SELECT
    first_name,
    salary,
    to_char(hire_date, 'yyyy-mm'),
    department_id
FROM
    employees
WHERE
    department_id IN ( 10, 90, 100 );
 
-- 문제7: 이름에 S 또는 s가 들어가는 직원의 이름.월급 출력
SELECT
    first_name  "이름",
    salary      "월급"
FROM
    employees
WHERE
    first_name LIKE '%s%'; 

--문제8: 전체부서 출력시 순서는 부서이름이 긴 순서대로 출력
SELECT
    *
FROM
    departments
ORDER BY
    length(department_name) DESC; 

--문제9: 나라이름 대문자 출력. 오름차순(ASC) 정렬
SELECT
    upper(country_name)
FROM
    countries
ORDER BY
    country_name ASC;

--문제10: 입사일 03/12/31 이전 입사 직원의 이름, 월급, 전화번호, 입사일 출력/ 전화번호는 000-000-0000 형태로 
SELECT
    first_name,
    salary,
    replace(phone_number, '.','-'),
    hire_date
FROM
    employees
WHERE
    hire_date < '31-dec-03';