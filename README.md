# pathao_data_analysis_SQL_POWERBI

Problem Statement/ Hypothetical Scenario:

Pathao, a ride sharing business aims to perform a comprehensive analysis of its booking, ride, and customer experience data to optimize performance, identify trends, and support strategic decisions. To achieve this, the platform seeks to:

Operational Performance:
-Retrieve all successful and incomplete bookings, along with reasons for cancellations (both customer and driver-related).
-Evaluate ride volumes over time and analyze booking status distribution to identify operational trends and bottlenecks.

Customer & Driver Behavior:
-Identify top customers by booking frequency and total booking value.
-Measure and compare customer and driver ratings by vehicle type, including the distribution and extremes (max/min).
-Understand reasons for ride cancellations and the impact of driver-related issues.

Vehicle & Ride Insights:
-Calculate average ride distance and analyze performance across different vehicle types (e.g., Prime Sedan, Auto).
-Identify top-performing vehicle types based on distance traveled and customer satisfaction.

Payment & Revenue Analysis:
-Track revenue generation by payment methods, with a focus on UPI usage and total booking value from successful rides.
-Analyze payment method preferences to support financial planning and offer targeted incentives.

Visualization and Trend Analysis (Power BI):
-Visualize ride volume trends over time and ride distance distribution per day.
-Present the breakdown of booking statuses and cancellation reasons.
-Highlight the top 5 customers and vehicle types through interactive dashboards.
-Compare customer vs. driver ratings for quality assurance.

Objective:
Through a combination of SQL-based data extraction and Power BI visualizations, the goal is to generate actionable insights to enhance service quality, customer satisfaction, and operational efficiency for the ride-hailing platform.

Project Structure
1. Data base setup and table formation
   ```sql
   CREATE DATABASE pathao_project;

   CREATE TABLE pathao
	(
		Transaction_date DATE,
		Transaction_Time TIME, 	
		Booking_ID VARCHAR(20), 
		Booking_Status VARCHAR(25), 
		Customer_ID	VARCHAR(20), 
		Vehicle_Type VARCHAR(15),	
		Pickup_Location	VARCHAR(15), 
		Drop_Location VARCHAR(15), 
		Avg_VTAT FLOAT, 
		Avg_CTAT FLOAT, 
		Cancelled_Rides_by_Customer	INT, 
		Reason_for_cancelling_by_Customer VARCHAR(45),  	
		Cancelled_Rides_by_Driver INT, 	
		Reason_for_cancelling_by_Driver VARCHAR(50), 
		Incomplete_Rides INT, 
		Incomplete_Rides_Reason VARCHAR(50), 	
		Booking_Value FLOAT, 
		Ride_Distance FLOAT, 
		Driver_Ratings	FLOAT, 
		Customer_Rating FLOAT,
		payment_method VARCHAR(15)
	);
   ```
   
2. Data Exploration & Cleaning
Record Count: Determine the total number of records in the dataset.
Customer Count: Find out how many unique customers are in the dataset.
Category Count: Identify all unique product categories in the dataset.
Null Value Check: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM pathao;
SELECT COUNT(DISTINCT Customer_ID) FROM pathao;
SELECT DISTINCT Vehicle_Type FROM pathao;

SELECT * FROM pathao
WHERE 
    Transaction_date IS NULL OR Transaction_Time IS NULL OR Booking_ID IS NULL OR 
    Booking_Status IS NULL OR Customer_ID IS NULL OR Vehicle_Type IS NULL OR 
    Pickup_Location IS NULL OR Drop_Location IS NULL;

DELETE FROM pathao
WHERE 
    Transaction_date IS NULL OR Transaction_Time IS NULL OR Booking_ID IS NULL OR 
    Booking_Status IS NULL OR Customer_ID IS NULL OR Vehicle_Type IS NULL OR 
    Pickup_Location IS NULL OR Drop_Location IS NULL;
```

3. Data Analysis & Findings

1. Retrieve all successful bookings:
```sql
SELECT * FROM pathao WHERE Booking_Status = 'Success';
```

2. Find the average ride distance for each vehicle type:
```sql
SELECT Vehicle_Type, AVG(Ride_Distance) as avg_distance FROM pathao GROUP BY
Vehicle_Type;
```

3. Get the total number of cancelled rides by customers:
```sql
SELECT COUNT(*) FROM pathao WHERE Booking_Status = 'Cancelled by Customer';
```

4. List the top 5 customers who booked the highest number of rides:
```sql
SELECT Customer_ID, COUNT(Booking_ID) as total_rides FROM pathao GROUP BY
Customer_ID ORDER BY total_rides DESC LIMIT 5;
```

5. Get the number of rides cancelled by drivers due to personal and car-related issues:
```sql
SELECT COUNT(*) FROM pathao WHERE Reason_for_cancelling_by_Driver = 'Personal & Car related issues';
```

6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
```sql
SELECT MAX(Driver_Ratings) as max_rating, MIN(Driver_Ratings) as min_rating FROM
pathao WHERE Vehicle_Type = 'Prime Sedan';
```

7. Find the average customer rating per vehicle type:
```sql
SELECT Vehicle_Type, AVG(Customer_Rating) as avg_customer_rating FROM pathao
GROUP BY Vehicle_Type;
```

9. Calculate the total booking value of rides completed successfully:
```sql
SELECT SUM(Booking_Value) as total_successful_value FROM pathao WHERE
Booking_Status = 'Success';
```

10. List all incomplete rides (incomplete rides denoted as "1") along with the reason:
```sql
SELECT Booking_ID, Incomplete_Rides_Reason FROM pathao WHERE Incomplete_Rides =
'1';
```

11.Retrieve all rides where payment was made using Fone Pay:
```sql
SELECT * FROM pathao WHERE payment_method = 'Fone Pay';
```
Power BI Answers:
Segregation of the views:

1. Overall
- Ride Volume Over Time
- Booking Status Breakdown
<img width="601" alt="Image" src="https://github.com/user-attachments/assets/20a55622-83a0-4db4-aac7-383d3f7f446b" />

2. Vehicle Type
- Top 5 Vehicle Types by Ride Distance

  
3. Revenue
- Revenue by Payment Method
- Top 5 Customers by Total Booking Value
- Ride Distance Distribution Per Day
4. Cancellation
- Cancelled Rides Reasons (Customer)
- cancelled Rides Reasons(Drivers)
5. Ratings
- Driver Ratings
- Customer Ratings


