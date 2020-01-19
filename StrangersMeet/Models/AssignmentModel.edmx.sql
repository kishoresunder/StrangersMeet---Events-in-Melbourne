
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 09/08/2019 18:18:30
-- Generated from EDMX file: C:\Users\Vigneshwaren Sunder\source\repos\FIT5032_Assignment\FIT5032_Assignment\Models\AssignmentModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [AssignmentDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_UserBooking]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Bookings] DROP CONSTRAINT [FK_UserBooking];
GO
IF OBJECT_ID(N'[dbo].[FK_OrganiserEvent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Events] DROP CONSTRAINT [FK_OrganiserEvent];
GO
IF OBJECT_ID(N'[dbo].[FK_EventTypeEvent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Events] DROP CONSTRAINT [FK_EventTypeEvent];
GO
IF OBJECT_ID(N'[dbo].[FK_BookingEvent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Bookings] DROP CONSTRAINT [FK_BookingEvent];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO
IF OBJECT_ID(N'[dbo].[Organisers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Organisers];
GO
IF OBJECT_ID(N'[dbo].[Bookings]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Bookings];
GO
IF OBJECT_ID(N'[dbo].[EventTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EventTypes];
GO
IF OBJECT_ID(N'[dbo].[Events]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Events];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [userEmail] nvarchar(50)  NOT NULL,
    [userName] nvarchar(50)  NOT NULL,
    [password] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'Organisers'
CREATE TABLE [dbo].[Organisers] (
    [organiserEmail] nvarchar(50)  NOT NULL,
    [organiserName] time  NOT NULL,
    [password] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'Bookings'
CREATE TABLE [dbo].[Bookings] (
    [userEmail] nvarchar(50)  NOT NULL,
    [eventTime] nvarchar(50)  NOT NULL,
    [eventDate] datetime  NOT NULL,
    [eventName] nvarchar(50)  NOT NULL,
    [bookingDate] datetime  NOT NULL,
    [seatCount] int  NOT NULL
);
GO

-- Creating table 'EventTypes'
CREATE TABLE [dbo].[EventTypes] (
    [eventTypeId] int IDENTITY(1,1) NOT NULL,
    [eventName] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'Events'
CREATE TABLE [dbo].[Events] (
    [eventName] nvarchar(50)  NOT NULL,
    [eventDate] datetime  NOT NULL,
    [eventTime] nvarchar(50)  NOT NULL,
    [description] nvarchar(300)  NOT NULL,
    [street] nvarchar(50)  NOT NULL,
    [suburb] nvarchar(50)  NOT NULL,
    [postCode] int  NOT NULL,
    [city] nvarchar(50)  NOT NULL,
    [latitude] decimal(12,9)  NOT NULL,
    [longitude] decimal(12,9)  NOT NULL,
    [seatCapacity] int  NULL,
    [organiserEmail] nvarchar(50)  NOT NULL,
    [eventTypeId] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [userEmail] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([userEmail] ASC);
GO

-- Creating primary key on [organiserEmail] in table 'Organisers'
ALTER TABLE [dbo].[Organisers]
ADD CONSTRAINT [PK_Organisers]
    PRIMARY KEY CLUSTERED ([organiserEmail] ASC);
GO

-- Creating primary key on [userEmail], [eventName], [eventDate], [eventTime] in table 'Bookings'
ALTER TABLE [dbo].[Bookings]
ADD CONSTRAINT [PK_Bookings]
    PRIMARY KEY CLUSTERED ([userEmail], [eventName], [eventDate], [eventTime] ASC);
GO

-- Creating primary key on [eventTypeId] in table 'EventTypes'
ALTER TABLE [dbo].[EventTypes]
ADD CONSTRAINT [PK_EventTypes]
    PRIMARY KEY CLUSTERED ([eventTypeId] ASC);
GO

-- Creating primary key on [eventName], [eventDate], [eventTime] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [PK_Events]
    PRIMARY KEY CLUSTERED ([eventName], [eventDate], [eventTime] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [userEmail] in table 'Bookings'
ALTER TABLE [dbo].[Bookings]
ADD CONSTRAINT [FK_UserBooking]
    FOREIGN KEY ([userEmail])
    REFERENCES [dbo].[Users]
        ([userEmail])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [organiserEmail] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [FK_OrganiserEvent]
    FOREIGN KEY ([organiserEmail])
    REFERENCES [dbo].[Organisers]
        ([organiserEmail])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_OrganiserEvent'
CREATE INDEX [IX_FK_OrganiserEvent]
ON [dbo].[Events]
    ([organiserEmail]);
GO

-- Creating foreign key on [eventTypeId] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [FK_EventTypeEvent]
    FOREIGN KEY ([eventTypeId])
    REFERENCES [dbo].[EventTypes]
        ([eventTypeId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_EventTypeEvent'
CREATE INDEX [IX_FK_EventTypeEvent]
ON [dbo].[Events]
    ([eventTypeId]);
GO

-- Creating foreign key on [eventName], [eventDate], [eventTime] in table 'Bookings'
ALTER TABLE [dbo].[Bookings]
ADD CONSTRAINT [FK_BookingEvent]
    FOREIGN KEY ([eventName], [eventDate], [eventTime])
    REFERENCES [dbo].[Events]
        ([eventName], [eventDate], [eventTime])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_BookingEvent'
CREATE INDEX [IX_FK_BookingEvent]
ON [dbo].[Bookings]
    ([eventName], [eventDate], [eventTime]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------