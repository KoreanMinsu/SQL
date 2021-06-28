--문제1: 사번,이름,성, 부서명 조회/ 부서이름 오름차순, 사번 내림차순 정렬
SELECT
    employee_id,
    first_name,
    last_name,
    department_name
FROM
    employees    e,
    departments  d
WHERE
    e.department_id = d.department_id
ORDER BY
    department_name ASC,
    employee_id DESC;

--문제2: 사번,이름,급여,부서명, 현재업무/사번 오름차순 정렬(부서없는 Kimberly 178) 표시안함
SELECT
    employee_id,
    first_name,
    salary,
    job_title,
    department_name
FROM
    employees    e,
    jobs         j,
    departments  d
WHERE
        e.job_id = j.job_id
    AND e.department_id = d.department_id
ORDER BY
    employee_id ASC;


--문제2-1: 2번 + Kimberly 출력
SELECT
    employee_id,
    first_name,
    salary,
    job_title,
    department_name
FROM
    employees    e,
    jobs         j,
    departments  d
WHERE
        e.job_id = j.job_id
    AND e.department_id = d.department_id (+)
ORDER BY
    employee_id ASC;

--문제3: 도시아이디, 도시명, 부서명, 부서아이디 / 도시아이디 오름차순 정렬 출력 / 부서 없을시 미출력
SELECT
    lo.location_id "도사아이디",
    city"도시",
    department_name"부서명",
    department_id"부서번호"
FROM
    departments  de,
    locations    lo
WHERE
    lo.location_id = de.location_id
ORDER BY
    lo.location_id ASC;

--문제3-1: 3번 + 부서없는 도시 출력
SELECT
    lo.location_id "도사아이디",
    city"도시",
    department_name"부서명",
    department_id"부서번호"
FROM
    departments  de,
    locations    lo
WHERE
    lo.location_id = de.location_id(+)
ORDER BY
    lo.location_id ASC;

--문제4: 지역이름, 나라이름 출력/ 지역이름(오름차순),나라이름(내림차순)정렬
SELECT
    region_name "지역이름",
    country_name "나라이름"
FROM
    countries  c,
    regions    r
WHERE
    c.region_id = r.region_id
ORDER BY
    region_name ASC,
    country_name DESC;

--문제5 자신의 매니저보다 채용일이 빠른 사원의 사번, 이름, 채용일, 매니저이름, 매니저입사일 조회
SELECT
    e.employee_id "사번",
    e.first_name "이름",
    e.hire_date "채용일",
    man.first_name "매니저이름",
    man.hire_date "매니저입사일"
FROM
    employees    e,
      employees man
WHERE
    e.manager_id = man.employee_id 
    and e.hire_date < man.hire_date;

--문제6: 나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디/나라명(오름차순)출력
SELECT
    country_name,
    c.country_id,
    city,
    d.location_id,
    department_name,
    d.department_id
FROM
    countries    c,
    locations    l,
    departments  d
WHERE
        c.country_id = l.country_id
    AND l.location_id = d.location_id
ORDER BY
    country_name ASC;

--문제7: 과거의 Job_id가 'ac_account'로 근무한 사원의 사번, 이름(풀네임), 업무아이디, 시작일, 종료일 출력// 성과 이름 합쳐 출력
SELECT
    h.employee_id,
    e.first_name
    || ' '
    || e.last_name,
    h.job_id,
    h.start_date,
    h.end_date
FROM
    employees    e,
    job_history  h
WHERE
        e.employee_id = h.employee_id
    AND h.job_id LIKE 'AC_ACCOUNT';

--문제8: 부서의 부서번호, 부서이름, 매니저의/이름, 위치한 도시, 나라의 이름, 지역 구분의 이름까지 전부 출력
SELECT
    e.department_id as "부서번호",
    department_name as "부서이름",
    first_name as "매니저이름",
    city as " 도시",
    country_name as"나라이름",
    region_name as "지역이름"
FROM
    employees    e,
    departments  d,
    locations    l,
    countries    c,
    regions      r
WHERE
        d.department_id = e.department_id
        and d.manager_id = e.employee_id
    AND d.location_id = l.location_id
    AND l.country_id = c.country_id
    AND r.region_id = c.region_id;

--문제9: 사원별 사번, 이름, 부서명, 매니저이름 조회// 부서없는 직원도 표시
SELECT
    e.employee_id "사번",
    e.first_name"사원이름",
    department_name"부서명",
    man.first_name"매니저이름"
FROM
    employees    e,
    employees man,
    departments d
WHERE
   e.department_id = d.department_id(+) 
   and e.manager_id = man.employee_id;