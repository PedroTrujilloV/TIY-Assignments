# 19 -- Keep on the Sunny Side

## Agenda

### Instructor Commitments

* 1:00 PM - 1:30 PM - Team Meeting
* 1:30 PM - 2:00 PM - Phone Call
* 2:30 PM - 3:00 PM - Phone Call

### Daily Rituals

* Standup Meeting ~15min

### Topics

* Review: Mapping and models and delegation oh my!
* Review: NSURLSession
* Yak Shaving:
	* Understanding the Google Maps and Forecast.io APIs.
	* Finding information in the Forecast.io API docs.
	* Working on the design of both the UI and the code.

## Homework - Forecaster

Build a weather app that utilizes both the Google Maps API to convert a zip code provided by the user into a set of latitute and longitude coordinates, as well as the Dark Sky API to use those coordinates to find the local weather conditions for that location.

This is the API call to use to get coordinates from a zip code:
```
http://maps.googleapis.com/maps/api/geocode/json?address=santa+cruz&components=postal_code:12345&sensor=false
```
(Where 12345 is the zipcode. The URL also has an address field with a city name in it which is ignored by the API server for this request.)

Here are some design layout ideas for the views:

![City Table View](https://github.com/TheIronYard--Orlando/2015--FALL--iOS/blob/master/19--Forecaster/CityTableView.png)
![Add City View](https://github.com/TheIronYard--Orlando/2015--FALL--iOS/blob/master/19--Forecaster/AddCityView.png)
![Forecast Detail View](https://github.com/TheIronYard--Orlando/2015--FALL--iOS/blob/master/19--Forecaster/DetailedForecast.png)

### Assignment Checklist
```markdown

#### Normal Mode

* [ ] Build a table view controller that will display location and basic weather information for the city provided with a zipcode. One cell per location.
* [ ] Provide a plus button in the navbar that will open the modal view to prompt for zipcode. 
* [ ] Build a modal view controller that will prompt the user for a zip code.
* [ ] Build a view that will be pushed onto the main navigation stack when a city cell it tapped. This view will display detailed weather conditions for the selected city.
* * [ ] Create a model class to store information about a particular city.
* [ ] Create a model class to store information about a set of weather conditions.
* [ ] Create a class called "APIController" that will perform all network API calls.
  * [ ] Perform an asynchronous network call to ask the Google Maps API for a lat/long pair based on a given zipcode.
  * [ ] Perform an asynchronous network call to ask the Forecast.io weather API for weather info on each location in the list.

#### Hard Mode

* [ ] Build a table view that shows the next seven days of weather for the selected location. It will be pushed onto the navigation stack from the weather detail view, so add a button somewhere on the detail view to show this screen.

#### Journal, Week 2

* [ ] Tutorial due on Monday. Once you have a decent draft of the tutorial, have a fellow classmate use your tutorial to complete the task you're trying to teach. Have them provide any suggestions in a comment on the PR.

#### Kata 4

* [ ] Continue work on Kata 4.
```
