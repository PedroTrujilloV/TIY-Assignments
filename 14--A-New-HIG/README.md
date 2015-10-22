# 14 -- A New HIG

## Agenda

### Instructor Commitments

* 2:30 PM - 3:15 PM - Phone Calls

### Daily Rituals

* Standup Meeting ~15min

### Topics

* UIPopoverController
* UICollectionView
* Universal Apps
* In-class app: Collect 'Em All
* [The HIG](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/MobileHIG/)

## Homework - High Voltage

![1.21 Gigawatts](http://i.giphy.com/SwT2Pk15RH5m.gif)

Great job on the time circuits! We were able to get you here to 1955 so you can ensure your parents end up together. Now we need to get you back to the future, but I'm afraid I've fallen and hit my head on the toilet again (another late night clock adjustment). Unfortunately I can't remember the equations to ensure we get 1.21 gigawatts from the lightning bolt that will hit the clocktower. I'm sure you've got a reference for them in your pocket computer. We'll need to do these calculations quickly on the night of the storm, so could you build an app that will allow us to enter the values we have and then calculate the values we need? It must work quickly, as we won't get another chance to get this right. Your future depends on this!

\- Doc Brown

Let's build a universal app for Doc so he can perform those crucial calculations on the fly. The main view will be a tableview with dynamically added cells, one for each value type. The + button will create a popover when tapped to allow the user to select the value type they want to add. Once two values are entered, the app should disable the + button and perform the necessary calculations to add the two remaining value types to the screen. The clear button will empty the table and prepare the app for a new transaction.

See [this site](http://www.rapidtables.com/calc/electric/watt-volt-amp-calculator.htm) for the list of equations as well as a web implementation of this app you can use for testing.

### Assignment Checklist
```markdown

#### Normal Mode

* [ ] Design your cells in the storyboard and see if you can get one of each on the screen
* [ ] Create the view controller in the storyboard that will show each of the types (the one you'll use as a popover.
* [ ] Make the app show the types view as a modal when you tap the + button
* [ ] Switch the presentation style to a popover
* [ ] Implement the popoverpresentationcontroller delegate methods to ensure the view appears as a popover
* [ ] Create a class to perform all the calculations
* [ ] ... [add additional steps here]

#### Journal, Week 2

* [ ] Continue work on your journal entry. Due on Monday. Have 1 other classmate read it over before you turn it in. Create a pull request against your branch and have the proofreader add a comment to the PR to indicate they've read it.

#### Kata 3

* [ ] Continue working on kata 3. Due next Wednesday.
```
