-- create main logging table:

use [xxx];
go

create table [dbo].[logging_tbl](
	[Table_Name] [nvarchar](50) null,
	[SubmissionID] [nvarchar](50) null,
	[ModifiedBy] [varchar](25) null,
	[ModifiedOn] [datetime] null,
	[Change] [char](10) null
);
go
