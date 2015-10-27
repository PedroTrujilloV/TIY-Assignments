# 17 -- Anybody Out There?

## Agenda

### Instructor Commitments

* 12:15 PM - 1:45 PM - Team Lunch

### Daily Rituals

* Standup Meeting ~15min

### Topics

* Intro to networking
* More practice with JSON and moving data to models

## Homework - GitHub Friends


### Assignment Checklist
```markdown

#### Normal Mode

* [ ] Create an app that works very similarly to the AlbumSearch app we build today in class.
* [ ] Swap out the ```Album``` model class with a class named ```Friend```.
* [ ] In your call to the APIController, search for a friend with a particular GH username.
Use the following line to create a URL object for the GitHub API:
let url = NSURL(string: "https://api.github.com/users/" + username) // replace username with the user you want to search for.
* [ ] Display the name of the GitHub user(s) in a tableview.

* [ ] Create a UIViewController subclass called ```NewFriendViewController```:
* [ ] Add to the view a textfield, a button to initiate a search, and a button to cancel.
* [ ] Create two methods, one for the cancel button and one for the search button. Connect them to their respective buttons with the ```addTarget``` function.
* [ ] Place the textfield and two buttons on the screen with ```setFrame```.
* [ ] In the cancel method you create, have the view dismiss itself.
* [ ] In the search method you create, have the view dismiss itself and initiate a search using the an APIController object for the username against the GitHub API. Use a delegate to send the data back to the main view controller when the data task completes.

* [ ] Create a UIViewController subclass called ```FriendDetailViewController```:
* [ ] Create 4 UILabel properties: the user's name and three other properties of your choosing
* [ ] Configure them with data from the Friend object and add them to the view

#### Hard Mode

In ```FriendDetailViewController```:
* [ ] Remove the "name" label and move the friend's name into the title of the view.
* [ ] Add a ```UIImageView``` property to the view controller and configure it to show the user's avatar. Place it on the screen somewhere. The upper right corner might be a good place, or perhaps below the other labels?


#### Journal, Week 2

* [ ] Work on converting your notes/research/bullet points into the beginnings of a tutorial. Use raywenderlich.com's tutorials as inspiration. Yours don't need to be as involved or complicated, but be sure the style is approachable by even inexperienced programmers. Try not to take too much for granted regarding the reader's skill level.

#### Kata 3

* [ ] Finish up working on kata 3. Due tomorrow.
```
