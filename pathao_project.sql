1. Database Setup and table formation

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
	
2. Data Exploration & Cleaning

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

3. Data Analysis & Findings

1. Retrieve all successful bookings:
SELECT * FROM pathao WHERE Booking_Status = 'Success';

2. Find the average ride distance for each vehicle type:
SELECT Vehicle_Type, AVG(Ride_Distance) as avg_distance FROM pathao GROUP BY
Vehicle_Type;

3. Get the total number of cancelled rides by customers:
SELECT COUNT(*) FROM pathao WHERE Booking_Status = 'Cancelled by Customer';

4. List the top 5 customers who booked the highest number of rides:
SELECT Customer_ID, COUNT(Booking_ID) as total_rides FROM pathao GROUP BY
Customer_ID ORDER BY total_rides DESC LIMIT 5;

5. Get the number of rides cancelled by drivers due to personal and car-related issues:
SELECT COUNT(*) FROM pathao WHERE Reason_for_cancelling_by_Driver = 'Personal & Car related issues';

6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT MAX(Driver_Ratings) as max_rating, MIN(Driver_Ratings) as min_rating FROM
pathao WHERE Vehicle_Type = 'Prime Sedan';

7. Find the average customer rating per vehicle type:
SELECT Vehicle_Type, AVG(Customer_Rating) as avg_customer_rating FROM pathao
GROUP BY Vehicle_Type;

9. Calculate the total booking value of rides completed successfully:
SELECT SUM(Booking_Value) as total_successful_value FROM pathao WHERE
Booking_Status = 'Success';

10. List all incomplete rides (incomplete rides denoted as "1") along with the reason:
SELECT Booking_ID, Incomplete_Rides_Reason FROM pathao WHERE Incomplete_Rides =
'1';

11.Retrieve all rides where payment was made using Fone Pay:
SELECT * FROM pathao WHERE payment_method = 'Fone Pay';

