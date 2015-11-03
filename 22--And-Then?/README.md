# 22 -- And Then?

## Agenda

### Instructor Commitments

* 12:30 PM - 2:00 PM - Team Lunch

### Daily Rituals

* Standup Meeting ~15min
* Quiz

### Topics

* NSCoding to persist small amounts of data/state
* CoreLocation to find the user's current location
* ToT: Instruments

## Homework - Dude, Where's My Car?

![Dude!](http://i.giphy.com/3fpNOUeYLwKdO.gif)

Build an iPhone app that allows the user to drop a pin on demand to mark where their car has been parked. Also allow the user to enter a short description or name for this location. Save this information using NSCoding to NSUserDefaults. When the app is relaunched, if a pin has been saved, the app will pull the pin in from NSUserDefaults and show it on the map. Include a separate marker denoting the user's current location.

### Assignment Checklist
```markdown

#### Normal Mode

* [ ] Create a view controller that shows a navigation bar.
* [ ] Add a UIMapView to the view controller's view. Make it span the entire view.
* [ ] Add a button (possibly in the navbar?) to allow the user to drop a pin at their current location.
* [ ] Set up your view controller to track the user's current location.
* [ ] Create an object to model a particular location and the title or description the user entered for that location.
	* [ ] Configure the above object to be encoded/decoded using NSCoding.
* [ ] Add code to the AppDelegate to allow for encoding/decoding on shutdown/launch.
* [ ] Configure the view controller to pull the data in from NSUserDefaults if it exists, and then display the pin on the map.

#### Hard Mode

* [ ] Find the user's current location and drop a pin
* [ ] Determine walking directions between the user's current location and the location of their car.
	* [ ] Display this route as an overlay path between the two pins.
	* [ ] Add label(s) on top of the map that shows the estimated time of arrival, the distance from the user to their car, and the travel time.

#### Kata 4

* [ ] Continue work on Kata 4.
```
