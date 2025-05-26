use zomato_analysis;
select * from main_table;

# Average cost in Dollar
select concat('$', M.average_cost_for_two* C.USD_Rate) as USD_cost, RestaurantName 
from main_table M left join currency_table C on M.currency = C.currency group by USD_cost, RestaurantName order by USD_cost desc limit 5;

# City,country wise number of Restaurants
select M.city as city, c.countryname as countryname,count(M.RestaurantName) as No_restaurants 
from main_table M join country_table c on M.CountryCode = c.CountryID group by countryname, city;

# Number of restaurants opened as per year & month
select count(RestaurantName) as No_restuarents,Year_Opening,Montha_Name as month, Quarter 
from main_table group by Year_opening, Quarter, Montha_Name order by No_restuarents desc limit 10;

# Rating wise number of restauranr=ts
select case when rating<= 2 then"0-2" when rating <=3 then "2-3" when rating <=4 then "3-4" when rating <=5 then "4-5"end Rating_range, 
count(RestaurantName) as No_restaurant from main_table group by rating;

# Table Booking, Online Delivery
SELECT Has_online_delivery, concat(round(count(RestaurantName) * 100 / (select count(*) from main_table),2), '%') as percentage_rest 
from main_table group by Has_Online_delivery; 
SELECT Has_Table_booking, concat(round(count(RestaurantName) * 100 / (select count(*) from main_table),2), '%') as percentage_rest 
from main_table group by Has_Table_booking;

#cuisines wise cities
select cuisines, count(city) as city from main_table group by city, cuisines limit 10;

# cuisines wise average rating
select cuisines, round((Rating),1) as avg_rating from main_table group by avg_rating, cuisines order by avg_rating desc limit 10;

# Average rating as per the retuarants
select city, Restaurantname, round((Rating),1) as Avg_rating 
from main_table group by city, RestaurantName, Avg_rating order by Avg_rating desc limit 15;