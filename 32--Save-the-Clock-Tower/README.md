# 32 -- Save the Clock Tower

## Agenda

### Instructor Commitments

* 12:00-1:30 PM - Team lunch

### Daily Rituals

* Standup Meeting ~15min

### Topics

* UIView subclass
	* drawRect method
	* Math!
* IBDesignable

## Homework - Global Time

### Normal Mode

Using the custom clockView class we created in class today, build a tableview-based app that allows the user to select a timezone from a list of all timezones and then display an appropriate clock in a tableviewcell. Show the clock on the left and the timezone in the center of the cell.

Hint on timezones: look at the ```NSTimeZone``` class for the function, ```knownTimeZoneNames```. Once the user picks a zone by its name, create an ```NSTimeZone``` object with the ```name:``` initializer.

### Hard Mode

* Change the face of the clock based on the time. If it is after dark, make the face black or some other dark color. Change it back to white or a light color after sunrise (don't worry about actual sunrise/set times, just pick sensible times).

* Add the ability to remove clock cells from the table. You will need to deactivate the animationTimer in the clockView class. Look at the documentation for ```CADisplayLink``` to see how to do that.

### Nightmare Mode

* Redo the app using Objective-C. 🙃


### Journal

Continue work on your journal. Ideally, it should be a few paragraphs in length.