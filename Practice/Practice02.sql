--문제1 매니저 있는 직원
select count(manager_id) "haveMngCnt"
from employees;

--문제2 직원중에 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요. 두 임금의 차이는 얼마인가요?  “최고임금 – 최저임금”이란 타이틀로 함께 출력해 보세요.
select max(salary) "최고임금",
       min(salary) "최저임금",
       max(salary)-min(salary) "최고임금 - 최저임금"
from employees;

--문제3 마지막으로 신입사원이 들어온 날 0000년 00월 00일 형식 출력
select to_char(max(hire_date),'yyyy"년" mm"월" dd"일"') 
from employees;

--문제4 부서별 평균임금/최고임금/최저임금 - 부서아이디와 함께 출력. 정렬 부서번호 내림차순
select  avg(salary) "평균임금", 
        max(salary) "최고임금",
        min(salary)"최저임금",
        department_id "부서아이디"
from employees
group by department_id 
order by department_id desc;

--문제5 업무별 평균임금, 최고임금, 최저임금을 업무아이디와 함께 출력/정렬순서 최저임금(내림차순)-평균임금(소수점 반올림후 오름차순)
select job_id "업무",
       round(avg(salary),0) "평균임금",
       max(salary) "최고임금",
       min(salary) "최저임금"
from employees
group by job_id
order by min(salary) desc, avg(salary) asc;

--문제6 최장근속직원의 입사일 출력 // 0000-00-00 요일 형식
select to_char(min(hire_date), 'yyyy"-"mm"-"dd" "day"','nls_date_language=korean')
from employees;

--문제7 평균임금 최저임금 차이 2000 미만 부서, 평균임금, 최저임금, 평균-최저를 평균-최저 내림차순 출력
select  department_id "부서", 
        avg(salary) "평균임금", 
        min(salary) "최저임금",
        avg(salary)-min(salary) "평균임금-최저임금"
from employees
group by department_id
having (avg(salary)-min(salary)) < 2000
order by (avg(salary)-min(salary)) desc;
        
--문제8 업무별 최고임금과 최저임금의 차이 출력 / 차이 내림차순 정렬
select  job_id, 
        max(salary),
        min(salary),
        max(salary)-min(salary)
from employees
group by job_id
order by max(salary)-min(salary) desc;

--문제9 2005년 이후 입사자 중 관리자별 평균급여, 최소급여, 최대급여 출력
--관리자별 평균급여 5000 이상 // 평균급여 내림차순, 소수점 첫째자리 반올림
select  round(avg(salary)),
        min(salary),
        max(salary)
from employees
group by manager_id, hire_date
having hire_date> '04/12/31' and
       avg(salary) >= 5000
order by avg(salary) desc;       

--문제10 입사일 02/12/31 이전 - 창립멤버/ 03년 - 03년입사, / 04년 - 04년 입사/ 이후 - 상장이후입사 optdate 로 출력
select first_name||' '||last_name "Full name", hire_date,
case when   hire_date < '02/12/31' then '창립멤버'
     when   hire_date > '02/12/31' and hire_date <= '03/12/31' then'03년입사'
     when   hire_date > '03/12/31' and hire_date <= '04/12/31' then'04년입사'
     else '상장이후입사'
     end 입사일기준
from employees
order by hire_date asc;