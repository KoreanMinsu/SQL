--NULL--
SELECT
    first_name,
    salary,
    commission_pct,
    salary * commission_pct
FROM
    employees
WHERE
    salary BETWEEN 13000 AND 15000;

SELECT
    *
FROM
    employees
WHERE
    commission_pct IS NULL;
----예제) 커미션 비율이 있는 사원의 이름과 연봉 커미션비율 출력
SELECT
    first_name || last_name   "풀네임",
    salary                    "연봉",
    commission_pct            "연봉 커미션비율"
FROM
    employees
WHERE
    commission_pct IS NOT NULL;
    
----예제2) 담당매니저 없고, 커미션 비율 없는 직원 이름 출력
SELECT
    first_name,
    last_name
FROM
    employees
WHERE
    manager_id IS NULL
    AND commission_pct IS NULL;
    
--order by(정렬)---
SELECT
    first_name,
    salary
FROM
    employees
ORDER BY
    salary DESC; --내림차순 descending  || 오름차순 asc(ascending)

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary >= 9000
ORDER BY
    salary DESC,
    first_name ASC;  --정렬조건 복수일시 , 로 구분하여 나열

--예제)부서번호 오름차순, 부서번호/급여/이름 출력
SELECT
    department_id  "부서번호",
    salary         "급여",
    first_name
    || ' '
    || last_name   "이름"
FROM
    employees
ORDER BY
    department_id ASC;
--예제2) 급여 10000이상 직원의 이름/급여를 급여 큰 직원부터 출력
SELECT
    first_name
    || ' '
    || last_name   "이름",
    salary         "급여"
FROM
    employees
WHERE
    salary >= 10000
ORDER BY
    salary DESC;
--예제3)부서번호 오름차순, 부서번호 같을시 급여 높은 사람부터 / 부서번호 급여 이름 출력
SELECT
    department_id  "부서번호",
    salary         "급여",
    first_name
    || ' '
    || last_name   "이름"
FROM
    employees
ORDER BY
    department_id ASC,
    salary DESC;

/*단일행 함수*/
SELECT
    email,
    initcap(email),
    department_id --email 첫글자 대문자로 출력하는 함수이용
FROM
    employees
WHERE
    department_id = 100;

--가상의 테이블로 함수 확인 (from dual)

--lower(), upper() 소문자 대문자 출력하는 함수
SELECT
    first_name,
    lower(first_name),
    upper(first_name)
FROM
    employees
WHERE
    department_id = 100;

--substr()컬럼에서 특정 문자열 선택출력 함수
SELECT
    first_name,
    substr(first_name, 1, 3),
    substr(first_name, - 3, 2)
FROM
    employees
WHERE
    department_id = 100;

--LPAD()/RPAD() 공백에 특별문자 채우기
SELECT
    first_name,
    lpad(first_name, 10, '*'),
    rpad(first_name, 10, '%')
FROM
    employees;
    
-- REPLACE() 컬럼에서 문자 1을 문자2로 변경하는 함수
SELECT
    first_name,
    replace(first_name, 'a', '*')
FROM
    employees;

SELECT
    first_name,
    replace(first_name, 'a', '*'),
    replace(first_name, substr(first_name, 2, 3), '***')
FROM
    employees;

/*숫자함수*/
--round() 반올림
SELECT
    round(123.346, 2)          "r2",
    round(123.346, 0)          "r0",
    round(123.346, - 1)        "r-1"
FROM
    dual;

-- trunc() 소수점 버리기   
SELECT
    trunc(123.346, 2)          "r2",
    trunc(123.346, 0)          "r0",
    trunc(123.346, - 1)        "r-1"
FROM
    dual;

/*날짜함수*/
SELECT
    sysdate --시스템 설정 날짜 
FROM
    dual;

SELECT
    sysdate,
    hire_date,
    round(months_between(sysdate, hire_date), 0) "일수"
FROM
    employees;

/*변환함수*/
--to char() 숫자 -> 문자로 변환 함수
SELECT
    first_name,
    to_char(9876, '999,999.99')
,     to_char(9876, '0999999')
,    to_char(9876, '$999,999.99')
,    to_char(9876, '999,999.99')
,    to_char(9876, '$999,999.99')
FROM
    employees
WHERE
    department_id = 100;
    
-- to char() 날짜->문자로 변환 함수   
select sysdate,
    to_char(sysdate, 'YYYY"년" MM"월" DD"일"')
,    to_char(sysdate, 'YYYY')
,    to_char(sysdate, 'YY')
,    to_char(sysdate, 'month')
,    to_char(sysdate, 'mon')
, substr(to_char(sysdate, 'day'),1,4)
,    to_char(sysdate, 'DD')
,    to_char(sysdate, 'HH')
,    to_char(sysdate, 'HH24')
,    to_char(sysdate, 'MI')
,    to_char(sysdate, 'SS')
,    to_char(sysdate, 'day-month-yyyy')
from dual;

--nvl()  nvl2()
--컬럼 조사 후 null경우 치환/ nvl() 
--컬럼 조사 후 null일때 아닐때 치환값 지정 / nvl2()
select commission_pct, nvl(commission_pct,0)
from employees;

select commission_pct, nvl2(commission_pct,'열일했네','불쌍하네')
from employees;