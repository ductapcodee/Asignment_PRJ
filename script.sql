USE [master]
GO
/****** Object:  Database [FALL25_Assignment]    Script Date: 11/9/2025 7:05:00 PM ******/
CREATE DATABASE [FALL25_Assignment]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FALL25_Assignment', FILENAME = N'D:\Semeter_3\DBI202_DucHMHE191363\Set up\MSSQL16.MSSQLSERVER\MSSQL\DATA\FALL25_Assignment.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FALL25_Assignment_log', FILENAME = N'D:\Semeter_3\DBI202_DucHMHE191363\Set up\MSSQL16.MSSQLSERVER\MSSQL\DATA\FALL25_Assignment_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [FALL25_Assignment] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FALL25_Assignment].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FALL25_Assignment] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET ARITHABORT OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FALL25_Assignment] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FALL25_Assignment] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FALL25_Assignment] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FALL25_Assignment] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET RECOVERY FULL 
GO
ALTER DATABASE [FALL25_Assignment] SET  MULTI_USER 
GO
ALTER DATABASE [FALL25_Assignment] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FALL25_Assignment] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FALL25_Assignment] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FALL25_Assignment] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FALL25_Assignment] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FALL25_Assignment] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FALL25_Assignment', N'ON'
GO
ALTER DATABASE [FALL25_Assignment] SET QUERY_STORE = ON
GO
ALTER DATABASE [FALL25_Assignment] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [FALL25_Assignment]
GO
/****** Object:  Table [dbo].[Division]    Script Date: 11/9/2025 7:05:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Division](
	[did] [int] NOT NULL,
	[dname] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Division] PRIMARY KEY CLUSTERED 
(
	[did] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 11/9/2025 7:05:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[eid] [int] NOT NULL,
	[ename] [varchar](150) NOT NULL,
	[did] [int] NOT NULL,
	[supervisorid] [int] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RequestForLeave]    Script Date: 11/9/2025 7:05:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestForLeave](
	[rid] [int] IDENTITY(1,1) NOT NULL,
	[created_by] [int] NOT NULL,
	[created_time] [datetime] NOT NULL,
	[from] [date] NOT NULL,
	[to] [date] NOT NULL,
	[reason] [varchar](max) NOT NULL,
	[status] [int] NULL,
	[processed_by] [int] NULL,
	[process_reason] [varchar](max) NULL,
	[processed_time] [datetime] NULL,
 CONSTRAINT [PK_RequestForLeave] PRIMARY KEY CLUSTERED 
(
	[rid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_RequestDetails]    Script Date: 11/9/2025 7:05:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_RequestDetails] AS
SELECT 
    r.rid AS RequestID,
    r.created_time AS CreatedTime,
    r.[from] AS FromDate,
    r.[to] AS ToDate,
    r.reason AS Reason,
    CASE r.status
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Approved'
        WHEN 3 THEN 'Rejected'
        ELSE 'Unknown'
    END AS Status,
    
    -- Thông tin người tạo đơn
    e.eid AS CreatorID,
    e.ename AS CreatorName,
    d.dname AS CreatorDivision,
    
    -- Thông tin supervisor của người tạo
    s.eid AS SupervisorID,
    s.ename AS SupervisorName,
    
    -- Thông tin người xử lý
    p.eid AS ProcessorID,
    p.ename AS ProcessorName,
    r.process_reason AS ProcessReason,
    r.processed_time AS ProcessedTime
    
FROM RequestForLeave r
INNER JOIN Employee e ON r.created_by = e.eid
INNER JOIN Division d ON e.did = d.did
LEFT JOIN Employee s ON e.supervisorid = s.eid
LEFT JOIN Employee p ON r.processed_by = p.eid;
GO
/****** Object:  Table [dbo].[Enrollment]    Script Date: 11/9/2025 7:05:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollment](
	[uid] [int] NOT NULL,
	[eid] [int] NOT NULL,
	[active] [bit] NOT NULL,
 CONSTRAINT [PK_Enrollment] PRIMARY KEY CLUSTERED 
(
	[uid] ASC,
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feature]    Script Date: 11/9/2025 7:05:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feature](
	[fid] [int] NOT NULL,
	[url] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Feature] PRIMARY KEY CLUSTERED 
(
	[fid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 11/9/2025 7:05:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[rid] [int] NOT NULL,
	[rname] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[rid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleFeature]    Script Date: 11/9/2025 7:05:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleFeature](
	[rid] [int] NOT NULL,
	[fid] [int] NOT NULL,
 CONSTRAINT [PK_RoleFeature] PRIMARY KEY CLUSTERED 
(
	[rid] ASC,
	[fid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 11/9/2025 7:05:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[uid] [int] NOT NULL,
	[username] [varchar](150) NOT NULL,
	[password] [varchar](150) NOT NULL,
	[displayname] [varchar](150) NOT NULL,
	[login_fail_count] [int] NOT NULL,
	[lock_until] [datetime] NULL,
	[email] [nvarchar](255) NULL,
	[otp] [varchar](10) NULL,
	[otp_expire] [datetime] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 11/9/2025 7:05:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[uid] [int] NOT NULL,
	[rid] [int] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[uid] ASC,
	[rid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Division] ([did], [dname]) VALUES (1, N'IT')
GO
INSERT [dbo].[Division] ([did], [dname]) VALUES (2, N'QA')
GO
INSERT [dbo].[Division] ([did], [dname]) VALUES (3, N'Sale')
GO
INSERT [dbo].[Employee] ([eid], [ename], [did], [supervisorid]) VALUES (1, N'Nguyen Van A', 1, NULL)
GO
INSERT [dbo].[Employee] ([eid], [ename], [did], [supervisorid]) VALUES (2, N'Tran Van B', 1, 1)
GO
INSERT [dbo].[Employee] ([eid], [ename], [did], [supervisorid]) VALUES (3, N'CCCCCC', 1, 1)
GO
INSERT [dbo].[Employee] ([eid], [ename], [did], [supervisorid]) VALUES (4, N'Mr DDDD', 1, 2)
GO
INSERT [dbo].[Employee] ([eid], [ename], [did], [supervisorid]) VALUES (5, N'Mr EEEE', 1, 3)
GO
INSERT [dbo].[Employee] ([eid], [ename], [did], [supervisorid]) VALUES (6, N'Mr GGGGG', 2, NULL)
GO
INSERT [dbo].[Employee] ([eid], [ename], [did], [supervisorid]) VALUES (7, N'Mr Hoang Duc', 2, 9)
GO
INSERT [dbo].[Employee] ([eid], [ename], [did], [supervisorid]) VALUES (8, N'Mr Manh', 2, 9)
GO
INSERT [dbo].[Employee] ([eid], [ename], [did], [supervisorid]) VALUES (9, N'Mr Thang', 2, 6)
GO
INSERT [dbo].[Employee] ([eid], [ename], [did], [supervisorid]) VALUES (10, N'Mr Vinh', 3, NULL)
GO
INSERT [dbo].[Employee] ([eid], [ename], [did], [supervisorid]) VALUES (11, N'Mr Viet', 3, 10)
GO
INSERT [dbo].[Employee] ([eid], [ename], [did], [supervisorid]) VALUES (12, N'Mr Nguyen', 3, 11)
GO
INSERT [dbo].[Employee] ([eid], [ename], [did], [supervisorid]) VALUES (13, N'Mr Ha', 3, 11)
GO
INSERT [dbo].[Enrollment] ([uid], [eid], [active]) VALUES (1, 1, 1)
GO
INSERT [dbo].[Enrollment] ([uid], [eid], [active]) VALUES (2, 2, 1)
GO
INSERT [dbo].[Enrollment] ([uid], [eid], [active]) VALUES (3, 3, 1)
GO
INSERT [dbo].[Enrollment] ([uid], [eid], [active]) VALUES (4, 4, 1)
GO
INSERT [dbo].[Enrollment] ([uid], [eid], [active]) VALUES (5, 5, 1)
GO
INSERT [dbo].[Enrollment] ([uid], [eid], [active]) VALUES (6, 6, 1)
GO
INSERT [dbo].[Enrollment] ([uid], [eid], [active]) VALUES (7, 7, 1)
GO
INSERT [dbo].[Enrollment] ([uid], [eid], [active]) VALUES (8, 8, 1)
GO
INSERT [dbo].[Enrollment] ([uid], [eid], [active]) VALUES (9, 9, 1)
GO
INSERT [dbo].[Enrollment] ([uid], [eid], [active]) VALUES (10, 10, 1)
GO
INSERT [dbo].[Enrollment] ([uid], [eid], [active]) VALUES (11, 11, 1)
GO
INSERT [dbo].[Enrollment] ([uid], [eid], [active]) VALUES (12, 12, 1)
GO
INSERT [dbo].[Enrollment] ([uid], [eid], [active]) VALUES (13, 13, 1)
GO
INSERT [dbo].[Feature] ([fid], [url]) VALUES (1, N'/request/create')
GO
INSERT [dbo].[Feature] ([fid], [url]) VALUES (2, N'/request/review')
GO
INSERT [dbo].[Feature] ([fid], [url]) VALUES (3, N'/request/list')
GO
INSERT [dbo].[Feature] ([fid], [url]) VALUES (4, N'/division/agenda')
GO
INSERT [dbo].[Feature] ([fid], [url]) VALUES (5, N'/admin/dashboard')
GO
INSERT [dbo].[Feature] ([fid], [url]) VALUES (6, N'/admin/userlist')
GO
SET IDENTITY_INSERT [dbo].[RequestForLeave] ON 
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (2, 2, CAST(N'2025-10-25T21:02:31.833' AS DateTime), CAST(N'2025-10-15' AS Date), CAST(N'2025-10-30' AS Date), N've tham nguoi nha
', 1, NULL, NULL, NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (3, 2, CAST(N'2025-10-25T21:02:53.387' AS DateTime), CAST(N'2025-10-25' AS Date), CAST(N'2025-10-27' AS Date), N'sick', 3, 1, N'di vien nhe', CAST(N'2025-10-27T14:47:54.897' AS DateTime))
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (4, 2, CAST(N'2025-10-25T21:04:44.923' AS DateTime), CAST(N'2025-10-25' AS Date), CAST(N'2025-10-27' AS Date), N's', 2, 1, N'sos', CAST(N'2025-10-27T14:43:53.060' AS DateTime))
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (5, 2, CAST(N'2025-10-25T21:07:15.107' AS DateTime), CAST(N'2025-10-25' AS Date), CAST(N'2025-10-27' AS Date), N'toi met
', 2, 1, N'lam viec di', CAST(N'2025-10-27T14:43:33.353' AS DateTime))
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (6, 4, CAST(N'2025-10-25T21:15:30.717' AS DateTime), CAST(N'2025-10-24' AS Date), CAST(N'2025-10-30' AS Date), N's', 3, 2, N'test', CAST(N'2025-10-28T19:42:46.080' AS DateTime))
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (7, 3, CAST(N'2025-10-25T21:29:18.187' AS DateTime), CAST(N'2025-10-25' AS Date), CAST(N'2025-10-26' AS Date), N's', 3, 1, N'che', CAST(N'2025-10-29T22:51:31.087' AS DateTime))
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (8, 4, CAST(N'2025-10-25T21:31:24.667' AS DateTime), CAST(N'2025-10-25' AS Date), CAST(N'2025-10-26' AS Date), N'a', 2, 2, N'APPROVE', NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (9, 3, CAST(N'2025-10-25T21:49:48.217' AS DateTime), CAST(N'2025-10-25' AS Date), CAST(N'2025-10-27' AS Date), N'qu', 1, NULL, NULL, NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (10, 3, CAST(N'2025-10-25T21:50:48.307' AS DateTime), CAST(N'2025-10-25' AS Date), CAST(N'2025-10-26' AS Date), N'á', 1, NULL, NULL, NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (11, 2, CAST(N'2025-10-25T23:19:41.037' AS DateTime), CAST(N'2025-10-23' AS Date), CAST(N'2025-10-25' AS Date), N'p', 3, 2, N'REJECT', NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (12, 2, CAST(N'2025-10-26T23:25:44.100' AS DateTime), CAST(N'2025-10-26' AS Date), CAST(N'2025-10-28' AS Date), N'khong co ra', 3, 2, N'toi khong cho', CAST(N'2025-10-27T14:08:51.483' AS DateTime))
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (13, 7, CAST(N'2025-10-27T00:04:47.683' AS DateTime), CAST(N'2025-10-26' AS Date), CAST(N'2025-10-27' AS Date), N've choi voi gdinh', 1, NULL, NULL, NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (14, 7, CAST(N'2025-10-27T00:30:27.980' AS DateTime), CAST(N'2025-10-15' AS Date), CAST(N'2025-10-28' AS Date), N'kkk', 1, NULL, NULL, NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (15, 2, CAST(N'2025-10-27T23:10:09.187' AS DateTime), CAST(N'2025-11-07' AS Date), CAST(N'2025-11-13' AS Date), N'Deny', 1, NULL, NULL, NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (17, 3, CAST(N'2025-10-28T21:41:59.793' AS DateTime), CAST(N'2025-10-30' AS Date), CAST(N'2025-10-31' AS Date), N'on thi pe
', 3, 1, N'khong can on', CAST(N'2025-11-05T14:12:35.710' AS DateTime))
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (18, 8, CAST(N'2025-10-30T00:42:42.110' AS DateTime), CAST(N'2025-10-31' AS Date), CAST(N'2025-11-01' AS Date), N'thi pe', 1, NULL, NULL, NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (19, 8, CAST(N'2025-10-30T00:44:27.480' AS DateTime), CAST(N'2025-10-30' AS Date), CAST(N'2025-10-30' AS Date), N've nha', 1, NULL, NULL, NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (21, 4, CAST(N'2025-11-01T23:33:39.310' AS DateTime), CAST(N'2025-11-22' AS Date), CAST(N'2025-11-29' AS Date), N'nghi demo', 2, 1, N'domo on roi ', CAST(N'2025-11-02T21:08:17.570' AS DateTime))
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (23, 10, CAST(N'2025-11-02T00:52:48.843' AS DateTime), CAST(N'2025-11-02' AS Date), CAST(N'2025-11-05' AS Date), N'hello', 2, NULL, NULL, NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (24, 1, CAST(N'2025-11-02T00:55:09.967' AS DateTime), CAST(N'2025-11-02' AS Date), CAST(N'2025-11-05' AS Date), N'toi di cong tac ', 2, NULL, NULL, NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (25, 3, CAST(N'2025-11-05T13:54:58.017' AS DateTime), CAST(N'2025-11-06' AS Date), CAST(N'2025-11-08' AS Date), N'nghi on thi pe prj', 3, 1, N'khong dong y', CAST(N'2025-11-05T14:01:23.387' AS DateTime))
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (26, 4, CAST(N'2025-11-05T13:55:28.967' AS DateTime), CAST(N'2025-11-05' AS Date), CAST(N'2025-11-11' AS Date), N'tai nan giao thong', 2, 1, N'duong benh nhe', CAST(N'2025-11-05T13:56:20.870' AS DateTime))
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (27, 10, CAST(N'2025-11-06T14:19:25.203' AS DateTime), CAST(N'2025-11-06' AS Date), CAST(N'2025-11-07' AS Date), N'di pr san pham', 2, NULL, NULL, NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (28, 11, CAST(N'2025-11-06T14:21:02.150' AS DateTime), CAST(N'2025-11-06' AS Date), CAST(N'2025-11-07' AS Date), N'nay em di trong cua hang', 1, NULL, NULL, NULL)
GO
INSERT [dbo].[RequestForLeave] ([rid], [created_by], [created_time], [from], [to], [reason], [status], [processed_by], [process_reason], [processed_time]) VALUES (29, 7, CAST(N'2025-11-07T22:50:07.477' AS DateTime), CAST(N'2025-11-07' AS Date), CAST(N'2025-11-16' AS Date), N'on thi pe va lam project prj', 1, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[RequestForLeave] OFF
GO
INSERT [dbo].[Role] ([rid], [rname]) VALUES (1, N'IT Head')
GO
INSERT [dbo].[Role] ([rid], [rname]) VALUES (2, N'IT PM')
GO
INSERT [dbo].[Role] ([rid], [rname]) VALUES (3, N'IT Employee')
GO
INSERT [dbo].[Role] ([rid], [rname]) VALUES (4, N'QA Head')
GO
INSERT [dbo].[Role] ([rid], [rname]) VALUES (5, N'QA PM')
GO
INSERT [dbo].[Role] ([rid], [rname]) VALUES (6, N'QA Employee')
GO
INSERT [dbo].[Role] ([rid], [rname]) VALUES (7, N'Sale Head')
GO
INSERT [dbo].[Role] ([rid], [rname]) VALUES (8, N'Sale PM')
GO
INSERT [dbo].[Role] ([rid], [rname]) VALUES (9, N'Sale Employee')
GO
INSERT [dbo].[Role] ([rid], [rname]) VALUES (10, N'Admin')
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (1, 1)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (1, 2)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (1, 3)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (1, 4)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (2, 1)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (2, 2)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (2, 3)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (3, 1)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (3, 3)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (4, 1)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (4, 2)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (4, 3)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (4, 4)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (5, 1)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (5, 2)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (5, 3)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (6, 1)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (6, 3)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (7, 1)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (7, 2)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (7, 3)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (7, 4)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (8, 1)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (8, 2)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (8, 3)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (9, 1)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (9, 3)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (9, 4)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (10, 5)
GO
INSERT [dbo].[RoleFeature] ([rid], [fid]) VALUES (10, 6)
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (1, N'mra', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Mr A - IT Division Leader', 0, NULL, N'hhooaannggdduucc@gmail.com', N'420748', CAST(N'2025-11-09T19:05:54.993' AS DateTime))
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (2, N'mrb', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Mr B - IT Project Manager', 0, CAST(N'2025-11-06T14:16:38.200' AS DateTime), NULL, NULL, NULL)
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (3, N'mrc', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Mr C - IT Project Manager', 1, CAST(N'2025-11-06T14:40:51.750' AS DateTime), NULL, NULL, NULL)
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (4, N'mrd', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'IT Employee MrD', 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (5, N'mre', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'IT Employee MrE', 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (6, N'mrg', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Mr G -QA Division Leader', 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (7, N'mrduc', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'QA Employee Mr Hoang Duc', 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (8, N'mrmanh', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'QA Employee Mr Manh', 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (9, N'mrthang', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Mr Thang - QA Project Manager', 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (10, N'mrvinh', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Mr Vinh - Sale Division Leader', 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (11, N'mrviet', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Mr Viet - Sale Project Manager', 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (12, N'mrnguyen', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Sale Employee Mr Nguyen', 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (13, N'mrha', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Sale Employee Mr Ha', 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[User] ([uid], [username], [password], [displayname], [login_fail_count], [lock_until], [email], [otp], [otp_expire]) VALUES (14, N'admin', N'03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', N'System Administrator', 0, NULL, N'minhduchoang2410@gmail.com', NULL, NULL)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (1, 1)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (2, 2)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (3, 2)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (4, 3)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (5, 3)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (6, 4)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (7, 6)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (8, 6)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (9, 5)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (10, 7)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (11, 8)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (12, 9)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (13, 9)
GO
INSERT [dbo].[UserRole] ([uid], [rid]) VALUES (14, 10)
GO
/****** Object:  Index [IX_Request_CreatedBy]    Script Date: 11/9/2025 7:05:00 PM ******/
CREATE NONCLUSTERED INDEX [IX_Request_CreatedBy] ON [dbo].[RequestForLeave]
(
	[created_by] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Request_ProcessedBy]    Script Date: 11/9/2025 7:05:00 PM ******/
CREATE NONCLUSTERED INDEX [IX_Request_ProcessedBy] ON [dbo].[RequestForLeave]
(
	[processed_by] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Request_Status]    Script Date: 11/9/2025 7:05:00 PM ******/
CREATE NONCLUSTERED INDEX [IX_Request_Status] ON [dbo].[RequestForLeave]
(
	[status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ((0)) FOR [login_fail_count]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Division] FOREIGN KEY([did])
REFERENCES [dbo].[Division] ([did])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Division]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Employee] FOREIGN KEY([supervisorid])
REFERENCES [dbo].[Employee] ([eid])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Employee]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Employee] FOREIGN KEY([eid])
REFERENCES [dbo].[Employee] ([eid])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_Employee]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_User] FOREIGN KEY([uid])
REFERENCES [dbo].[User] ([uid])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_User]
GO
ALTER TABLE [dbo].[RequestForLeave]  WITH CHECK ADD  CONSTRAINT [FK_RequestForLeave_Employee] FOREIGN KEY([created_by])
REFERENCES [dbo].[Employee] ([eid])
GO
ALTER TABLE [dbo].[RequestForLeave] CHECK CONSTRAINT [FK_RequestForLeave_Employee]
GO
ALTER TABLE [dbo].[RequestForLeave]  WITH CHECK ADD  CONSTRAINT [FK_RequestForLeave_ProcessedBy] FOREIGN KEY([processed_by])
REFERENCES [dbo].[Employee] ([eid])
GO
ALTER TABLE [dbo].[RequestForLeave] CHECK CONSTRAINT [FK_RequestForLeave_ProcessedBy]
GO
ALTER TABLE [dbo].[RoleFeature]  WITH CHECK ADD  CONSTRAINT [FK_RoleFeature_Feature] FOREIGN KEY([fid])
REFERENCES [dbo].[Feature] ([fid])
GO
ALTER TABLE [dbo].[RoleFeature] CHECK CONSTRAINT [FK_RoleFeature_Feature]
GO
ALTER TABLE [dbo].[RoleFeature]  WITH CHECK ADD  CONSTRAINT [FK_RoleFeature_Role] FOREIGN KEY([rid])
REFERENCES [dbo].[Role] ([rid])
GO
ALTER TABLE [dbo].[RoleFeature] CHECK CONSTRAINT [FK_RoleFeature_Role]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Role] FOREIGN KEY([rid])
REFERENCES [dbo].[Role] ([rid])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Role]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_User] FOREIGN KEY([uid])
REFERENCES [dbo].[User] ([uid])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_User]
GO
USE [master]
GO
ALTER DATABASE [FALL25_Assignment] SET  READ_WRITE 
GO
