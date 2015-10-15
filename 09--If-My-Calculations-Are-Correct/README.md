# 08 -- If My Calculations are Correct...

## Agenda
### Instructor Commitments
* 1:30-2:00 PM - Phone Meeting
* 2:30-3:00 PM - Phone Meeting

### Daily Rituals

* Standup Meeting ~15min
* In-depth homework review
* Weekend assignment yak shaving

### Topics

* Discussion of business/view logic separation
* Autolayout tips for a responsive layout


## Homework - Calculator

Create a single view application that shows a calculator interface. It should have buttons for numbers 0 - 9 (plus a . button so you can add floating point numbers) as well as 7 operator buttons (addition, subtraction, multiplication, division, and equals, plus/minus, percent). It should also have a button to clear out the current transaction (clear). It will need a label to display the current value of the calculator. It should operate as you would expect from a normal calculator. You can open the Apple-provided calculator app on your iOS device to get an idea of the appropriate layout.

### Objectives

After completing this assignment, you should…

* have a deeper understanding of autolayout rules and how different subviews on-screen can interact.
* understand how to create classes devoted purely to business logic.


### Assignment Checklist
```markdown
### Normal Mode

#### Storyboard Tasks

* [ ] Build UI with buttons for each operand and operator and include a label to display the input from the user.
* [ ] Apply autolayout rules to all UI elements to make sure they are responsive and will fit within the bounds of the device's screen.
* [ ] Connect all UI elements to either IBOutlets or IBActions as necessary.

#### Code Tasks

* [ ] Create IBActions for each operand and operator button so you can respond whenever the user taps a button.
* [ ] Create a class called CalculatorBrain to hold state information about the current calculation. An object of this type will be created and destroyed as each "calculation transaction" is performed by the user.
* [ ] As the user enters information, redirect the operands and operators to the CalculatorBrain class so when they tap the _=_ button, the brain will be ready to perform the calculation.
* [ ] Perform the calculation and return an answer to the view controller for display on-screen.

#### Journal, Week 1

* [ ] The journal is due on Monday, so please finish up your edits and only add a link to the PR to today's issue once you have completed it. Also, have 1 other person in-class read through the entry and provide feedback to you in your PR. When they comment, it will attach their GH username so we'll be able to see who you picked.

#### Kata 2
Due next Wednesday, Oct 21st.
```