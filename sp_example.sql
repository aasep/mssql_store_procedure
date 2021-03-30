/****** Script for SelectTopNRows command from SSMS  ******/
---- dengan parameter input saja
CREATE  PROCEDURE stp_GetEmployee
@gender nvarchar(10),
@deptid int
as
begin
	select * from Employee where Gender=@gender and DeptId=@deptid order by name asc
end
--- execute sp --------------------
exec stp_GetEmployee @gender='Male' ,@deptid=1
---------------------------------------------------------------
---- dengan parameter input dan output
---------------------------------------------------------------
CREATE  PROCEDURE stp_GetCountEmployee
@gender nvarchar(10),
@deptid int,
@count_employee int output
as
begin
	select @count_employee=count(id) from Employee where Gender=@gender and DeptId=@deptid 
end
---example1 execute sp -----
declare @jml_employee int
exec stp_GetCountEmployee @gender='Male' ,@deptid=2, @count_employee=@jml_employee out
select @jml_employee as jml

---------------------------------------------------------------
---- dengan parameter input dan return value
---------------------------------------------------------------
CREATE  PROCEDURE stp_GetCountEmployee2
@gender nvarchar(10),
@deptid int
as
begin
	return (select count(id) from Employee where Gender=@gender and DeptId=@deptid) 
end
---example1 execute sp -----
declare @jml_employee int
exec @jml_employee = stp_GetCountEmployee2 @gender='Male' ,@deptid=2
select @jml_employee as jml

---- catatan
-- execute berhasil akan menghasilkan return value 0 , selain 0 failed
-- return value hanya bisa mengembalikan number , bukan char

----- CURSOR -----
declare @idemp int
declare @name nvarchar(60)
declare @deptid int

declare EmployeeCursor cursor for
select Name,DeptId,Id from Employee where DeptId > 4

open EmployeeCursor

fetch next from  EmployeeCursor  into @name,@deptid,@idemp
while (@@FETCH_STATUS = 0)
begin
	if (@deptid=5)
        -- print 'nama='+@name+ 'Id Dept='+cast(@deptid as nvarchar(10))
		update Employee set DeptId=7 where Id=@idemp
    else
		update Employee set DeptId=8 where Id=@idemp


	fetch next from EmployeeCursor into @name,@deptid,@idemp
end

close EmployeeCursor
deallocate EmployeeCursor

------ update menggunakan query

update Employee 
set DeptId =   case
					when DeptId=5 then 7
					when DeptId=6 then 8
			   end
from Employee where DeptId > 4


