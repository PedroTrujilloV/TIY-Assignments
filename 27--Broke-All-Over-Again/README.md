# 27 -- Broke All Over Again

## Agenda

### Instructor Commitments

* 12:00-1:30 PM - Team lunch

### Daily Rituals

* Standup Meeting ~15min
* Quiz

### Topics

* Code-based layout
* NSURLSession and NSURLSessionDataDelegate

## Homework - Jackpot

### Pairings for tonight:

* Chris and Isaiah
* David and Michael
* Elizabeth and Keron
* Jen and Sam
* Pedro and Phil

Create a single view application using Objective-C that shows a table view as its main interface to the user. Provide a Navigation Controller to handle eventual view transitions. Add an "add" button to the navigation bar that when tapped, will generate a quick pick lottery number and place it in a cell in the table view.

Quick pick is defined as a lottery number that is randomly generated. A lottery number is 6 integers that are within the range 1 through 53. Picking a number does not preclude it from being picked again for another of the 6 in the sequence.

Then extend the functionality by adding a winning number view that allows the user to select the winning numbers for the lottery drawing. Also add a method or methods that search through your random tickets and determine which ones are winners.

A winning ticket is one that has at least three numbers that match the winning ticket.

3 numbers = $1
4 numbers = $5
5 numbers = $20
6 numbers = $100

Objectives

After completing this assignment, you should…

* know how to use a UITableViewController to display a list of related data
* understand how to enable on-demand cell creation by the user and add them to the view
* be able to create a model class to store information and easily transport this info around the app.
* understand how to create custom methods for model objects to perform non-standard comparison with each other.
* have more practice using model classes, custom delegation, and custom cells.