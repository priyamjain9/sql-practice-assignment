--1
select avg(scost) from software where DEVELOPIN = 'pascal'

--2
select pname , datediff(year,dob,getdate()) as age from programmer

--3
select pname from studies where COURSE = 'dap'

--4
select pname , dob from programmer where month(dob) = 1

--5
select title ,max(sold) from software group by TITLE 

--6
select course , COURSE_FEE from studies where COURSE_FEE = (select min(COURSE_FEE) from studies) group by COURSE , COURSE_FEE

--7
select count(*) from studies where COURSE = 'pgdca'

--8
select sum(scost*sold) from software where DEVELOPIN = 'c'

--9
select * from software where pname = 'ramesh'

--10
select count(*) from studies where INSTITUTE= 'sabhari'

--11
select * from software where (SOLD*SCOST) > 2000

--12
select * from software where (SOLD*SCOST) >= DCOST

--13
select max(dcost) from software where DEVELOPIN = 'basic'

--14
select COUNT(*) from software where DEVELOPIN = 'dbase'

--15
select COUNT(*) from studies where INSTITUTE = 'pragathi'

--16
select COUNT(*) from studies where COURSE_FEE between 5000 and 10000

--17
select AVG(COURSE_FEE) from studies

--18
select * from programmer where PROF1= 'c' or PROF2='c'

--19
select COUNT(*) from programmer where PROF1 in ('cobol' , 'pascal') or PROF2 in ('cobol' , 'pascal')

--20
select COUNT(*) from programmer where PROF1 not in ('c' , 'pascal') and PROF2 not in ('c' , 'pascal')

--21
select max(DATEDIFF(YEAR,DOB,getdate())) from programmer

--22
select avg(DATEDIFF(YEAR,DOB,getdate())) from programmer where GENDER = 'f'

--23
select PNAME,DATEDIFF(YEAR,DOB,doj) from programmer order by PNAME desc

--24
select pname , dob from programmer where MONTH(dob) = MONTH(GETDATE())

--25
select COUNT(*) from programmer where GENDER = 'f'

--26
select PNAME, PROF1 , PROF2 from programmer where GENDER = 'm'

--27
select AVG(salary) from programmer

--28
select count(salary) from programmer where SALARY between 2000 and 4000

--29
select * from programmer where PROF1 not in ('clipper','cobol','pascal') and PROF2 not in ('clipper','cobol','pascal')

--30
select pname , TITLE, dcost from software

--31
select pname , TITLE, scost from software

--32
select pname , SUM(sold) from software group by pname

--33
select PNAME , TITLE , DEVELOPIN as lang, SCOST from software order by lang

--34
select DEVELOPIN as lang , AVG(dcost) as avg_dcost , AVG(SCOST) as avg_scost, iif( sum(sold) > 0 ,SUM(SCOST*SOLD)/SUM(SOLD),null) as [avg_price/copy] from software group by DEVELOPIN 

--35
select PNAME , MAX(scost) as max , MIN(scost) as min from software group by pname

--36
select INSTITUTE , COUNT(distinct(COURSE)) as num_course,SUM(distinct(course_fee))/COUNT(distinct(COURSE)) as avg_cost  from studies group by INSTITUTE

--37
select INSTITUTE , COUNT(PNAME) from studies group by INSTITUTE

--38
select PNAME , GENDER from programmer order by gender

--39
select pname , TITLE from software

--40
select DEVELOPIN,COUNT(*) from software where developin not in ('c','cpp') group by DEVELOPIN 

--41
select DEVELOPIN,COUNT(*) from software where DCOST < 1000 group by DEVELOPIN

--42
select AVG(DCOST-SCOST) from software

--43
select PNAME , (SCOST*sold) as total_scost , DCOST , IIF((SCOST*sold)<DCOST,dcost - (SCOST*sold),null)as rec_amount from software

--44
select max(SALARY) as max , MIN(SALARY) as min , AVG(SALARY) as avg  from programmer where SALARY > 2000

--45
select pname,SALARY from programmer where SALARY = (select MAX(SALARY) from programmer where PROF1='c' or PROF2='c')

--46
select pname,SALARY from programmer where SALARY = (select MAX(SALARY) from programmer where (PROF1='cobol' or PROF2='cobol') ) and GENDER = 'f'

--47
with cte as (select prof1 , MAX(salary) as sal from (select prof1 , salary from programmer union all select prof2 , salary from programmer)t group by prof1) -- select * from cte 
select pname , cte.prof1 , p.salary from programmer as p inner join 
cte on cte.prof1 =p.prof1 or cte.prof1 = p.prof2 where p.SALARY = cte.SAL

--48
SELECT PNAME, DATEDIFF(YY,DOJ,GETDATE()) AS EXPRNCE FROM programmer WHERE DATEDIFF(YY,DOJ,GETDATE()) = (SELECT MIN(DATEDIFF(YY,DOJ,GETDATE()))FROM programmer)

--49
SELECT DISTINCT PNAME, DATEDIFF(YY,DOJ,GETDATE()) AS EXPRNCE FROM programmer WHERE
GENDER = 'M' AND DATEDIFF(DD,DOJ,GETDATE()) = (SELECT MAX(DATEDIFF(DD,DOJ,GETDATE())) FROM
programmer WHERE GENDER='m' AND PROF1= 'PASCAL' OR PROF2='PASCAL')

--50
select prof1 from (select PNAME, PROF1 from programmer union select pname , prof2 from programmer) t group by prof1 having COUNT(*) = 1

--51
select pname from programmer where prof1 in (select PROF1 from (select PNAME, PROF1 from programmer union select pname , prof2 from programmer)t group by prof1 having COUNT(*) = 1)

--52
select * from programmer where PROF1 = 'dbase' or PROF2 = 'dbase' and DATEDIFF(YEAR , DOB,GETDATE()) =  (select min(DATEDIFF(YEAR , DOB,GETDATE())) from programmer where PROF1 = 'dbase' or PROF2 = 'dbase') 

--53
select * from programmer where GENDER='f' and SALARY > 3000 and PROF1 not in ('C','cpp','dbase','oracle') and prof2 not in ('C','cpp','dbase','oracle')

--54
with cte as (select institute , count(*) as cnt from studies group by INSTITUTE) select institute from cte where cnt = (select MAX(cnt) from cte)

select top 1 institute  from studies group by INSTITUTE order by COUNT(*) desc 

--55
select course from studies where COURSE_FEE = (select max(COURSE_FEE) from studies)

--56
select top 1 course from studies group by COURSE order by COUNT(*) desc

--57
select INSTITUTE from studies where COURSE_FEE = (select max(COURSE_FEE) from studies)

--58
select INSTITUTE , COURSE , COURSE_FEE from studies where COURSE_FEE < (select AVG(COURSE_FEE) from studies) 

--59
select COURSE , COURSE_FEE from studies where COURSE_FEE between (select AVG(COURSE_FEE) from studies) - 1000 and (select AVG(COURSE_FEE) from studies) + 1000

--60
select top 1 title from software order by dcost desc

--61
select course, student_count from (select course, count(*) student_count, avg(count(*)) over() mean from studies group by course) sub where student_count <= mean

--62
select top 1 title from software order by SCOST

--63
select pname from software where SOLD = (select MIN(SOLD) from software)

--64
select top 1 DEVELOPIN from software order by SCOST desc

--65
SELECT SOLD,TITLE FROM SOFTWARE WHERE TITLE = (SELECT TITLE FROM SOFTWARE WHERE (DCOST-SCOST)=(SELECT MIN(DCOST-SCOST) FROM SOFTWARE))

--66
select title from software where SCOST = (select MAX(SCOST) from software where DEVELOPIN = 'pascal')

--67
select top 1 DEVELOPIN from software group by DEVELOPIN order by COUNT(*) desc

--68
select top 1 PNAME , COUNT(*) from software group by PNAME order by COUNT(*) desc

--69
select PNAME from software where SCOST  = (select MAX(SCOST) from software)

--70
select title from software where SOLD < (select AVG(sold) from software)

--71
select PNAME , SCOST*SOLD as sale, 2*DCOST from software where SCOST*SOLD > 2*DCOST

--72
select * from software where scost in (select MIN(scost) from software group by DEVELOPIN)

--73 
select PNAME , DEVELOPIN,sold from software where SOLD in (select MAX(sold) from software group by PNAME) or sold in (select Min(sold) from software group by PNAME) 

--74
SELECT PNAME, DOB FROM programmer WHERE DATEDIFF(DD,DOB,GETDATE())= (SELECT MIN(DATEDIFF(DD,DOB,GETDATE())) FROM Programmer WHERE year(DOB)=1965 AND GENDER='M')

--75
SELECT PNAME, DOB FROM programmer WHERE DATEDIFF(DD,DOB,GETDATE())= (SELECT Max(DATEDIFF(DD,DOB,GETDATE())) FROM Programmer WHERE year(DOJ)=1992 AND GENDER='f')

--76
select top 1 year(dob) from programmer group by YEAR(dob) order by COUNT(*) desc

--77
select top 1 month(doj) from programmer group by month(doj) order by COUNT(*) desc

--78
select prof1 ,count(*) from (select prof1 from programmer union all select prof2 from programmer)t group by prof1 having COUNT(*) = (select max(cnt) from (select COUNT(*) as cnt from (select prof1 from programmer union all select prof2 from programmer)t group by prof1)p)

--79
select pname,SALARY,GENDER from programmer where SALARY < (select AVG(SALARY) from programmer where GENDER='f') and GENDER = 'm' 

--80
select pname , salary from programmer where SALARY >= (select MAX(SALARY) from programmer) and GENDER = 'f'

--81
select prof1 ,count(*) from (select prof1 from programmer union all select prof2 from programmer)t group by prof1 having COUNT(*) = (select max(cnt) from (select COUNT(*) as cnt from (select prof1 from programmer union all select prof2 from programmer)t group by prof1)p)

--82
select * from programmer where SALARY in (select SALARY from programmer group by SALARY having COUNT(*)>1) order by SALARY

--83
select * from software where PNAME in (select PNAME from programmer where SALARY >= 3000 and GENDER = 'm')

--84
select * from software where DEVELOPIN = 'pascal' and PNAME in (select PNAME from programmer where GENDER = 'f')

--85
select * from programmer where YEAR(DOJ) <= 1990

--86
select * from software where DEVELOPIN = 'c' and PNAME in (select PNAME from programmer where GENDER = 'f') and PNAME in (select PNAME from studies where INSTITUTE = 'pragathi')

--87
SELECT INSTITUTE, COUNT(SW.TITLE) AS PKGCNT, sum(SW.SOLD) AS SALESCNT, SUM(SCOST*SOLD) AS SALVAL FROM software AS SW, studies AS ST WHERE SW.PNAME=ST.PNAME GROUP BY INSTITUTE

--88
SELECT SW.* FROM software AS SW, programmer AS PG, studies AS ST WHERE DEVELOPIN='DBASE' AND GENDER='M' AND SW.PNAME = PG.PNAME AND SW.PNAME = ST.PNAME and(sw.PNAME IN (SELECT PNAME FROM studies WHERE INSTITUTE = (SELECT TOP 1 INSTITUTE FROM studies GROUP BY INSTITUTE order BY COUNT(*) DESC)))

SELECT SW.* FROM software AS SW  WHERE DEVELOPIN='DBASE' AND PNAME IN (SELECT PNAME FROM programmer WHERE GENDER = 'M') AND PNAME IN (SELECT PNAME FROM studies WHERE INSTITUTE = (SELECT TOP 1 INSTITUTE FROM studies GROUP BY INSTITUTE order BY COUNT(*) DESC))

--89
select * from software s , programmer p where s.PNAME = p.PNAME and s.PNAME in (select PNAME from programmer where (GENDER = 'm' and YEAR(dob) <=1965) or (GENDER = 'f' and YEAR(dob) >=1975))  

--90
SELECT SW.*,PG.PROF1,PG.PROF2 from Software AS SW, programmer AS PG WHERE PG.PROF1<> SW.DEVELOPIN AND PG.PROF2 <> SW.DEVELOPIN AND PG.PNAME = SW.PNAME

--91
select s.* from software s , programmer p , studies st where s.PNAME = p.PNAME and s.PNAME = st.PNAME and GENDER = 'm' and INSTITUTE = 'sabhari'

--92
select * from programmer where PNAME not in (select PNAME from software)

--93
select SUM(scost) from software where PNAME in (select PNAME from studies where INSTITUTE = 'apple')

--94
SELECT A.PNAME, A.DOJ FROM programmer AS A INNER JOIN programmer AS B ON A.DOJ=B.DOJ WHERE A.PNAME<>B.PNAME ORDER BY A.DOJ

SELECT A.PNAME, A.DOJ FROM programmer AS A where DOJ in (select DOJ from programmer group by DOJ having COUNT(*) > 1)

--95
SELECT distinct A.PNAME, A.PROF2 FROM programmer AS A INNER JOIN programmer AS B ON A.PROF2=B.PROF2 WHERE A.PNAME<>B.PNAME ORDER BY A.PROF2

--96
SELECT Studies.INSTITUTE,sum(Software.SOLD*Software.SCOST) from Software,Studies WHERE Studies.PNAME=Software.PNAME group by Studies.INSTITUTE

--97
select PNAME , institute from studies where PNAME = (select PNAME from software where SCOST = (select MAX(SCOST) from software))

--98
select prof1 from (select prof1 from programmer union select prof2 from programmer)p where PROF1 not in (select developin from software)

--99
select distinct p.PNAME,salary , st.COURSE from programmer p , software s , studies st where p.PNAME=s.PNAME and p.PNAME = st.PNAME and SOLD = (select MAX(sold) from software)  

--100
select avg(Salary) from Programmer p,Software s where p .PNAME=s.PNAME and SOLD*SCOST > 50000

--101
SELECT PNAME, COUNT(TITLE) FROM software WHERE PNAME IN (SELECT PNAME FROM studies WHERE INSTITUTE = (SELECT DISTINCT INSTITUTE FROM studies WHERE COURSE_FEE = (SELECT MIN(COURSE_FEE) FROM Studies))) GROUP BY PNAME

--102
select distinct s.PNAME , count(*) , st.INSTITUTE from software s , studies st where st.PNAME = s.PNAME and s.PNAME in (select PNAME from software where SCOST = (select MIN(SCOST) from software)) group by s.PNAME,INSTITUTE

--103
select COUNT(*) from software s , programmer p where p.PNAME = s.PNAME and  GENDER = 'f' and SALARY > (select Max(SALARY) from programmer where GENDER = 'm')

--104
select COUNT(*) from software s , programmer p , studies st where p.PNAME = s.PNAME and st.PNAME = s.PNAME and DOJ = (select MIN(DOJ) from programmer where PNAME in (select PNAME from studies where INSTITUTE = 'bdps'))     

--105
SELECT PNAME,INSTITUTE from studies WHERE PNAME IN (SELECT PNAME from software)

--106
select u.PROF1 , u.cnt_prog , a.cnt_pack from (select prof1 , count(*) as cnt_prog from (select PNAME , prof1 from programmer union select PNAME , prof2 from programmer)t group by prof1) u left join (select developin,COUNT(*) as cnt_pack from software group by DEVELOPIN) a on u.PROF1 = a.DEVELOPIN

--107
select p.PNAME, COUNT(s.TITLE) as count from programmer p inner join software s on p.PNAME = s.PNAME group by p.PNAME



