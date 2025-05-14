CREATE DATABASE RealTimeAnalytics;
GO
USE RealTimeAnalytics;

-- Users Table: Stores visitor details
CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    device_type NVARCHAR(50),
    location NVARCHAR(100),
    created_at DATETIME DEFAULT GETDATE()
);



-- User Sessions Table: Records user sessions
CREATE TABLE User_Sessions (
    session_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    start_time DATETIME DEFAULT GETDATE(),
    end_time DATETIME,
    pages_viewed INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Page Views Table: Tracks pages visited
CREATE TABLE Page_Views (
    view_id INT IDENTITY(1,1) PRIMARY KEY,
    session_id INT,
    page_url NVARCHAR(255),
    timestamp DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (session_id) REFERENCES User_Sessions(session_id)
);

-- Clicks Table: Tracks button and link clicks
CREATE TABLE Clicks (
    click_id INT IDENTITY(1,1) PRIMARY KEY,
    session_id INT,
    element_clicked NVARCHAR(255),
    timestamp DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (session_id) REFERENCES User_Sessions(session_id)
);

-- Insert users with South African locations
INSERT INTO Users (device_type, location) VALUES
('Mobile', 'Johannesburg'),
('Desktop', 'Cape Town'),
('Tablet', 'Durban'),
('Laptop', 'Pretoria'),
('Mobile', 'Soweto'),
('Tablet', 'Port Elizabeth'),
('Desktop', 'Bloemfontein');


-- SELECT: Fetch all users
SELECT * FROM Users;

-- SELECT: Fetch user details by ID
SELECT * FROM Users WHERE user_id = 1;


-- UPDATE: Update user location
UPDATE Users SET location = 'East London' WHERE user_id = 3;


-- DELETE: Delete a user by ID
DELETE FROM Users WHERE user_id = 7;


-- Insert user sessions
INSERT INTO User_Sessions (user_id, start_time, end_time, pages_viewed) VALUES
(1, GETDATE(), DATEADD(MINUTE, 10, GETDATE()), 5),
(2, GETDATE(), DATEADD(MINUTE, 15, GETDATE()), 7);

--  COUNT: Count total number of sessions
SELECT COUNT(*) AS total_sessions FROM User_Sessions;

-- DISTINCT: Find unique device types
SELECT DISTINCT device_type FROM Users;

-- Insert page views
INSERT INTO Page_Views (session_id, page_url) VALUES
(1, '/home'),
(1, '/about'),
(2, '/products');

-- Insert clicks
INSERT INTO Clicks (session_id, element_clicked) VALUES
(1, 'SignUp Button'),
(2, 'Add to Cart');



-- JOIN: Find user sessions with user info
SELECT u.user_id, u.device_type, s.start_time, s.end_time
FROM Users u
JOIN User_Sessions s ON u.user_id = s.user_id;

-- GROUP BY: Count page views by session
SELECT session_id, COUNT(*) AS page_views_count
FROM Page_Views
GROUP BY session_id;

--  ORDER BY: List clicks ordered by timestamp
SELECT * FROM Clicks
ORDER BY timestamp DESC;

--find the most viewed
SELECT page_url, COUNT(*) AS views
FROM Page_Views
GROUP BY page_url
ORDER BY views DESC;

--active users 
SELECT COUNT(DISTINCT user_id) AS active_users
FROM User_Sessions
WHERE start_time >= DATEADD(MINUTE, -30, GETDATE());

--session duration

SELECT AVG(DATEDIFF(SECOND, start_time, end_time)) AS avg_session_duration
FROM User_Sessions;

--most clicked
SELECT element_clicked, COUNT(*) AS click_count
FROM Clicks
GROUP BY element_clicked
ORDER BY click_count DESC;


