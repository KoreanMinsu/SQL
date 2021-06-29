/*SubQuery*/

--1)Den의 급여 11000
select salary
from employees
where first_name = 'Den';

--2)11000(Den) 보다 많은 사람
select first_name, salary
from employees
where salary > 11000;

--3) Den의 급여보다 많은 사람 - 1,2 조합 / 순차적 쿼리만들기
select first_name, salary
from employees
where salary > (select salary
                from employees 
                where first_name = 'Den');
--예제 급여 가장 적게 받는 사람의 이름,급여 사번구하기 
select first_name, salary, employee_id
from employees
where salary = (select min(salary) 
                from employees);
--예제2 평균 급여보다 적게 받는 사람의 이름 급여 출력
select first_name, salary
from employees
where salary < (select avg(salary)
                from employees);

/*다중행 SubQuery */
--부서번호 110인 직원의 급여와 같은 모든 직원의 사번 이름 급여 출력                \
select employee_id, first_name, salary
from employees
where salary in (select salary
                from employees
                where department_id = 110);

--예제: 부서별 최고급여 받는 사원 출력
--IN 사용
select department_id, employee_id, first_name, salary
from employees
where (department_id, salary) in   (select department_id, max(salary)
                                    from employees
                                    group by department_id);
--단순 문법확인
select first_name, salary, department_id
from employees
where (first_name, salary) in (('Neena' , 17000),
                                ('Den' , 11000),
                                ('David', 9500));

--ANY 사용 (OR)     110부서의 어떤 급여보다 큰값 (>12008 or >8300) 즉, >8300
select first_name, salary, department_id
from employees
where salary > any  (select salary
                     from employees
                     where department_id = 110);

--ALL 사용 (AND)  110부서의 모든 급여보다 큰 값(>12008 and >8300) 즉, >120008
select first_name, salary, department_id
from employees
where salary > all  (select salary
                     from employees
                     where department_id = 110);
    
--두개 결과 비교 - 부서별 최고급여 사원 출력 : where로 값만 비교하여 출력                   
select department_id, employee_id, first_name, salary
from employees 
where (department_id, salary) in ( select department_id, max(salary)
                                   from employees
                                   group by department_id);
--두개 결과 비교 - 부서별 최고급여 사원 출력 : join으로 컬럼 증가됨
select e.department_id, e.employee_id, e.first_name, e.salary
from employees e, ( select department_id, max(salary) salary 
                    from employees
                    group by department_id) s
where   e.department_id = s.department_id
and     e.salary = s.salary;

/*rownum*/
--급여 가장 많은 직원 5명 이름 출력 
--case 1)
select first_name, salary
from employees
where rownum >=1 and rownum<= 5
order by salary desc; --rownum 생성후 정렬로 원하는 값 출력이 아님

--case 2) 정렬된 table(FROM)에서 원하는 row골라 출력
select  ot.employee_id, 
        ot.first_name, 
        ot.salary,
        ot.hire_date
        
from (select first_name, salary, hire_date, employee_id
      from employees
      order by salary desc) ot
where rownum >=1 and rownum<= 5;

--rownum offset주기 : 정렬 -> rownum(limit주기) -> where절
--(1)
select *
from
        (select rownum rn,
            ot.first_name, 
            ot.salary,
            ot.hire_date
        from 
              (select first_name, salary, hire_date
              from employees
              order by salary desc) ot
              where rownum <=5
        ) rt     
where rn >=3;

--예제: 07년 입사 급여 많은 직원 3~7등의 이름, 급여입사일
select ort.first_name,
       ort.salary,
       ort.hire_date
from
    (select  rownum rn,
            ot.first_name,
            ot.salary, 
            ot.hire_date
    from        
            (select first_name, salary, hire_date
            from employees
            where hire_date>= '070101' and hire_date < '080101'
            order by salary desc) ot
            where rownum <=7 
    ) ort where rn >=3;
