--문제1: 담당매니저O, 커미션비율X, 월글 3000초과 직원의 이름,매니저아이디, 커미션 비율, 월급 출력
SELECT
    first_name      "이름",
    manager_id      "매니저아이디",
    commission_pct  "커미션비율",
    salary          "월급"
FROM
    employees
WHERE
    manager_id IS NOT NULL
    AND commission_pct IS NULL
    AND salary > 3000;
    
--문제2: 부서별 최고급여 사원의 직원번호, 이름, 급여, 입사일, 전화번호, 부서번호 조회    
--조건절비교방법/급여 내림차순/입사일 0000-00-00 토요일 형식/전화번호 000-000-000 형식

SELECT
    employee_id    "직원번호",
    first_name     "이름",
    salary         "급여",
    to_char(hire_date, 'yyyy-mm-dd day','nls_date_language=korean')   "입사일",
    replace(phone_number, '.','-')   "전화번호",
    department_id  "부서번호"
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
-- Query debug finished(phone_number using replace instead of to_char)

--문제3:매니저별 담당직원 평균급여, 최소급여, 최대급여확인 
--2005년 이후 입사자/평균급여 5000이상/평균급여 내림차순/소수점 첫째반올림/
--매니저 아이디/매니저이름/매니저별 평균급여//최소급여/최대급여
SELECT
    ma.manager_id      "매니저아이디",
    em.first_name           "매니저이름",
    avgSal           "매니저별평균급여",
    minSal            "매니저별최소급여",
    maxSal            "매니저별최대급여"
FROM
    employees  em,
        (select manager_id, round(avg(salary),0) avgSal, max(salary) maxSal, min(salary) minSal
        from employees
        group by manager_id) ma

WHERE
       ma.manager_id = em.manager_id
    AND to_char(hire_date,'yy/mm/dd') > '05/01/01'
        AND avgSal >= 5000
order by avgSal desc;
--Query debugging finished - 
select  ma.manager_id 매니저아이디,
        em.first_name 매니저이름,
        avgsal 매니저별편균급여,
        minsal 매니저별최소급여,
        maxsal 매니저별최대급여
from (select  manager_id, 
        round(avg(salary), 1) avgsal, 
        min(salary) minsal, 
        max(salary) maxsal
      from employees
      where to_char(hire_date,'yy/mm/dd') > '05/01/01'
      group by manager_id
      having round(avg(salary)) > 5000) ma, employees em
where ma.manager_id = em.employee_id;



--문제4: 각사원 사번/이름,부서명, 매니저 이름 조회
SELECT
    em.employee_id      "사번",
    em.first_name       "이름",
    em.department_id    "부서명",
    ma.first_name       "매니저명"
FROM
    employees  em,
    employees  ma
WHERE
    em.manager_id = ma.employee_id;
    
--문제5: 2005년 이후 입사 직원중 입사일 11~20번쨰 직원의 사번,이름,부서명,급여,입사일/ 입사일 순 출력
SELECT
    ort.employee_id        "사번",
    ort.first_name         "이름",
    ort.department_name    "부서명",
    ort.salary             "급여",
    ort.hire_date          "입사일"
FROM
    (
        SELECT
            ROWNUM rn,
            rt.employee_id,
            rt.first_name,
            rt.department_name,
            rt.salary,
            rt.hire_date
        FROM
            (
                SELECT
                    employee_id,
                    first_name,
                    department_name,
                    salary,
                    hire_date
                FROM
                    employees    e,
                    departments  d
                WHERE
                        e.department_id = d.department_id
                    AND hire_date > '05/01/01'
                ORDER BY
                    hire_date ASC
            ) rt
        WHERE
            ROWNUM <= 20
    ) ort
WHERE
    rn >= 11;
    
--문제 6: 가장 늦게 입사한 직원의 이름(first+last)와 연봉, 근무 부서명 출력    
SELECT
    first_name
    || ' '
    || last_name     "이름",
    salary           "연봉",
    department_name  "부서이름",
    to_char(hire_date, 'yy/mm/dd')        "입사일"
FROM
    employees    e,
    departments  d
WHERE
        e.department_id = d.department_id
    AND hire_date IN (
        SELECT
            MAX(hire_date)
        FROM
            employees
         );
--Query debugging finished - used where twice izzit.

--문제7: 평균연봉 가장 높은 부서직원의 직원번호, 이름, 성, 업무명, 연봉, 조회
select employee_id "사번", first_name "이름", last_name "성", salary "급여", avg(salary) "평균연봉", job_title "업무명" 
from employees e, jobs j;
--쿼리 완성필

--문제8: 평균급여가 가장 높은 부서
select department_name
from departments d, (select from group by )et
where d.departments_id = et.department_id;
--쿼리 완성필

--문제9: 평균 급여가 가장 높은 지역 (region_name - europe)
select region_name
from 
where ;
--쿼리 완성필

--문제10: 평균 급여가 가장 높은 업무(job_title - president)
select job_title
from
where;
--쿼리 완성필