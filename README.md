# RealTimeAnalystics
This repository showcases SQL queries for analyzing user activity data in a real-time analytics platform. The database tracks user sessions, page views, and clicks, helping to provide valuable insights into user engagement and behavior.


## Tables

- **Users**: Stores details about users (e.g., device type, location).
- **User_Sessions**: Records details of each user session (e.g., start time, end time).
- **Page_Views**: Tracks the pages visited by users during their sessions.
- **Clicks**: Tracks button and link clicks by users during their sessions.

## SQL Queries

The repository includes a variety of SQL queries to perform different analytics:

- **active_users.sql**: Query to find active users in the last 30 minutes.
- **session_duration.sql**: Query to calculate the average session duration.
- **most_clicked.sql**: Query to find the most clicked elements.
- **page_views.sql**: Query to find the most viewed pages.
