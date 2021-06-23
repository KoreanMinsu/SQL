--SELECT/FROM--
--모든 컬럼 조회
SELECT
    *
FROM
    employees;
    
--특정 컬럼 조회
SELECT
    employee_id,
    first_name,
    last_name
FROM
    employees;
    
    -- 예제
SELECT
    first_name,
    phone_number,
    hire_date,
    salary
FROM
    employees;

SELECT
    first_name,
    last_name,
    salary,
    phone_number,
    email,
    hire_date,
    salary
FROM
    employees;

--컬럼에 별명지정
SELECT
    employee_id  AS empno,
    first_name   "f-name",
    salary       "연  봉"
FROM
    employees;    
    --예제
SELECT
    first_name    "이름",
    phone_number  "전화번호",
    hire_date     "입사일",
    salary        "급여"
FROM
    employees;

SELECT
    first_name    "이름",
    last_name     "성",
    salary        "급여",
    phone_number  "전화번호",
    email         "이메일",
    hire_date     "입사일"
FROM
    employees;
    
--연결 연산자 ||로 컬럼 붙이기  
SELECT
    first_name || last_name
FROM
    employees;

SELECT
    first_name
    || ' '
    || last_name
FROM
    employees;

SELECT
    first_name
    || 'hire date is'
    || hire_date
FROM
    employees;
-- '' 따옴표로 문자 추가출력 가능

--산술 연산자+-*/ 사용
SELECT
    first_name,
    salary,
    salary * 12,
    ( salary + 300 ) * 12
FROM
    employees;
    --예제
SELECT
    job_id * 12 --연산이 불가
FROM
    employees;
    --예제2
SELECT
    first_name
    || '-'
    || last_name        "성명",
    salary              "급여",
    salary * 12           "연봉",
    salary * 12 + 5000      "연봉2",
    phone_number        "전화번호"
FROM
    employees;    

--WHERE--
select first_name
from employees
where department_id = 10;
-- =, !=, >, <, <=, >= 사용
    --예제
    select first_name, salary
    from employees
    where salary >= 15000;
    --예제2
    select first_name, hire_date
    from employees
    where hire_date >= '01-Jan-07';
    --예제3
    select salary
    from employees
    where first_name = 'Lex';
    --'' 문자 날자에 사용, 대소문자 구분됨

--조건 2개 이상 한번에 조회
SELECT
    first_name,
    salary
FROM
    employees    
WHERE
    salary >= 14000
    and salary <<= 17000;

        
--예제 : % 와 _ 를 활용한 DB검색
SELECT
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    first_name LIKE '%am%';

SELECT
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    first_name LIKE '_a%';

SELECT
    first_name,
    last_name
FROM
    employees
WHERE
    first_name LIKE '___a%';

SELECT
    first_name,
    last_name
FROM
    employees
WHERE
    first_name LIKE '_a__';