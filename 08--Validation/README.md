# 08 -- Validation

## Agenda
### Instructor Commitments
* 3:40-4:00 PM - Phone Meeting

### Daily Rituals

* Standup Meeting ~15min
* Homework Review
* In-class app: Form Validator

### Topics

* Review of:
	* Static UITableViews
	* Data validation
	* Practice with UITextFieldDelegate
	* Separation of view logic from business logic


## Homework - Jackpot Part Deux

Using your Jackpot app from yesterday, extend the functionality by adding a winning number view that allows the user to select the winning numbers for the lottery drawing. Also add a method or methods that search through your random tickets and determine which ones are winners.

A winning ticket is one that has at least three numbers that match the winning ticket.

* 3 numbers = $1
* 4 numbers = $5
* 5 numbers = $20
* 6 numbers = $100

### Objectives

After completing this assignment, you should…

* understand how to create custom methods for model objects to perform non-standard comparison with each other.
* have more practice using model classes, custom delegation, and custom cells.


### Assignment Checklist
```markdown
### Normal Mode

#### Storyboard Tasks

* [ ] If you haven't already, switch your cell type to right detail so you can also display the winning amount for each ticket.
* [ ] Add a view to the storyboard that shows an interface to pick our winning numbers.
* [ ] Add a UIBarButtonItem to the left side of the navigation bar in the root view to allow the user to show the winning number view from the step above.
* [ ] Add a button to the winning number view that determines which tickets are winners.

#### Code Tasks

* [ ] Create a custom View Controller class to back up the view that was added to the storyboard.
* [ ] Update the Ticket model to include additional state items for tracking the winning status and the dollar amount of winnings.
* [ ] Create a _compareTicket_ type method that takes a ticket object as an argument and compares it with the another ticket to determine how many digits are the same.
* Add logic to the main tableviewcontroller that uses these ticket comparisons to determine which tickets are winners. Follow the rules above about how much each winning type earns.
* [ ] Update the cell handling methods in the LottoNumbersTableViewController to ensure that winning tickets are prominently displayed to the user and the winning amount for that ticket is visible.

#### Journal, Week 1
   * [ ] Continue working on journal draft in your markdown file. Be sure to occasionally commit and push to GH.
```