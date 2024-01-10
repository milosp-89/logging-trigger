-- script for main logging trigger
-- [Logging_SQL_Spreads] tbl as a storing point

declare @db_name varchar(50) = '[xxx]' -- db name
declare @tbl_name varchar(50) = 'xxx' -- tbl name

declare @full_tbl_name varchar(50) = '[dbo].[' + @tbl_name + ']'
declare @trr_name varchar (100) = '[dbo].[' + @tbl_name + '_' + 'name_of_trigger]'
declare @q nvarchar(5) = ''''

select 'use ' + @db_name + ';
go

create trigger ' + @trr_name + '

on ' + @full_tbl_name + '
after delete, insert, update
as
begin
   declare @crud char(10),
   @tbl varchar(50) = ' +@q + @tbl_name + @q + '
        set @crud =
                case when exists(select * from inserted) and exists(select * from deleted)
                    then ''Modified''
                when exists(select * from inserted)
                    then ''Inserted''
                when exists(select * from deleted)
                    then ''Deleted''
                else NULL
        end
   -- for DELETE:
    if @crud = ''Deleted''
            insert into [xxx].[dbo].[Logging_SQL_Spreads] (
            Table_name,
            SubmissionID,
            ModifiedBy,
            ModifiedOn,
            Change
            )
            select
                    @tbl,
                    d.submission_id,
                    SUSER_NAME(),
                    GETDATE(),
                    @crud
            from deleted d
   -- for insert:
    if @crud = ''Inserted''
            insert into [xxx].[dbo].[Logging_SQL_Spreads] (
            Table_name,
            SubmissionID,
            ModifiedBy,
            ModifiedOn,
            Change
            )
            select
                    @tbl,
                    i.submission_id,
                    SUSER_NAME(),
                    GETDATE(),
                    @crud
            from inserted i
            where not SUSER_NAME()=''xxx''
   -- for update:
    if @crud = ''Modified''
            insert into [xxx].[dbo].[Logging_SQL_Spreads] (
            Table_name,
            SubmissionID,
            ModifiedBy,
            ModifiedOn,
            Change
            )
            select
                    @tbl,
                    i.submission_id,
                    SUSER_NAME(),
                    GETDATE(),
                    @crud
            from deleted d, inserted i
end;
go'
