# 37 -- Resurgence

## Agenda

### Instructor Commitments

* 12:00 - 1:30 - Team lunch

### Daily Rituals

* Standup Meeting ~15min
* Quiz ~10min

### Topics

* SpriteKit Part 2 - We'll finish the classic arcade game _Space Invaders_.

## Homework - Venue Menu

Create an application that allows a user to search for venues with the Foursquare API and save the location as a favorite. Persist these locations using CoreData.

Here's a link to the [Foursquare API documentation](https://developer.foursquare.com). You'll need a free developer account. The API also requires use of an API key when you make requests.

### Requirements

*  Show a list of favorite venues as the main view.
*  Provide a screen to enter a search term and use the Foursquare API to find venues that match.
*  Display the results in a list and allow the user to choose one.
*  Once chosen, add that venue to the main view.
*  When the cell is tapped, push a new view on the stack that shows the name, address and rating (from Foursquare) of the venue.
	* Allow the user to rate the venue (perhaps use a star system or something similar).
	* Also show a map view and pin the venue's coordinates.

### Bonus Features

* On the main list, provide a button that will show all the saved locations on a map with a pin for each. When the pin is tapped, show a callout with the name of the venue and the rating.