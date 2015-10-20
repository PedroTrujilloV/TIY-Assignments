# 12 -- The Temple of (Core) Data

## Agenda

### Instructor Commitments

* 12:30-2:00 PM - Team Lunch

### Daily Rituals

* Standup Meeting ~15min
* Quiz! ~10min
* Homework Review (optional) ~30min

### Topics

* Data Persistance, specifically Core Data

## Homework - In Due Time

### Normal Mode

Make a todo list application. Be sure to allow the user to enter a todo item description and also allow for items to be checked off. Todo item cells should also be deletable, but only if they are completed. Read this section of the UITableView Apple documentation to learn how to remove cells from a tableview.

### Hard Mode

Bonus points for allowing for the user to enter a due date for a given todo item. Decide for yourself how best to collect this info.

### Objectives

After completing this assignment, you should…

* have an introductory understanding of Core Data and how to persist information in a database between runs of the app.

### Assignment Checklist
```markdown

#### Normal Mode

* [ ] Create a project with the Core Data box checked
* [ ] Define your entity and attributes in the data model file
* [ ] Create an NSManagedObject subclass of your entity
* [ ] Create a custom cell design to show the todo item description and checkbox
* [ ] Create a custom cell class to use with your prototype cell and add IBOutlets for your cell's subviews
* [ ] Configure the TableViewController to show 1 cell to test your cell's design
* [ ] Add code to your TableViewController to allow the user to enter data in the UITextField and hide the keyboard when they press enter
* [ ] Add a + UIBarButtonItem to the upper right of the navbar
* [ ] Add an IBAction that will create a new managed todoitem object
* [ ] In cellForRowAtIndexPath, add logic that will show the keyboard if the todoitem's description is empty
* [ ] Intercept when the user presses "return" after entering a description and update the todoitem managed object
	* [ ] Also be sure to save the managedObjectContext so the change is written to disk
* [ ] Create todoitems, quit the app and on relaunch make sure the items return
* [ ] Create an IBAction to update the todoitem's status when the checkbox is tapped
	* [ ] Be sure to save the context after you update the managed object
* [ ] In the commitEditingStyle function, add logic that will only allow the cell to be deleted if the todoitem has been checked off. Consult the item's completed Boolean.

#### Hard Mode

* [ ] Make a few checklist items to describe how to implement the hard mode

#### Journal, Week 2

* [ ] Continue work on your journal entry

#### Kata 2

* [ ] Continue to work on the second set of kata problems. They are due on Wednesday.
```
