# 03 -- Good Morning, Agent Hunt

## Agenda
### Instructor Commitments
* 2-2:30 PM - Phone Meeting

### Daily Rituals

* Standup Meeting ~15min
* Homework Review ~30min

### Topics
* My First iOS App (from scratch)
	* Storyboards
	* Intro to Autolayout
	* IBOutlets and IBActions
	* UITextFieldDelegate

## Homework - Mission Briefing

Good afternoon agent. This mission will be quite taxing, but you will make your country proud if you complete it. Your job is to create an app to brief future agents on mission details securely and privately. We know this is your first assignment, but be aware that this is a top priority for the agency. The Director herself will be watching the outcome of this assignment, so stay sharp.

Included with this brief is a zipped file containing the agency's efforts so far regarding this mission. It is a good start, but several key issues have not yet been solved. Your mission, should you choose to accept it, is to finish the tasks outlined in the attached source code and deliver the project for submission to all our field agents. Good luck.

This message will self-destruct in 5 seconds.

### Objectives

After completing this assignment, you should…

* Become familiar with manipulating view attributes in the storyboard.
* Understand the basics of applying autolayout constraints to subviews.
* Practice _wiring up_ outlets and actions to their associated properties and methods in the view controller.
* Begin to use standard organizational practices for arranging your code within a class.
* Understand how to organize code blocks into functions.

### Assignment Checklist
```markdown
### Normal Mode
#### Storyboard Tasks
* [ ] Add two UITextFields to the top of the view. Have them stretch to 80% of their superview's width.
* [ ] Add a button centered below the textfields. The title should read "Authenticate".
* [ ] Add a centered label below the button.
* [ ] Place a UITextView below the label. It should also stretch to 80% of its superview's width (hint: you can instead use a constraint to make it the same width as one of the textfields, which will have the same effect).
* [ ] Add a UIImageView and set it to the TIY logo image from your image assets. It should be centered with the rest of the elements.

#### Code Changes

* [ ] 1. Copy the MissionBriefingViewControler.swift file into your project, and delete the ViewConroller.swift file that Xcode created for you.
* [ ] 2. Change the class name of the view in the storyboard to match the class you just imported.
* [ ] 3. The UI elements should be set to an "empty string" in viewDidLoad of the ViewController class.
* [ ] 4. The code should check to ensure BOTH the agent name and password fields are nonempty before allowing authentication.
* [ ] 5. The greeting label should display "Good evening, Agent [last name]", where the agent's last name is pulled from the textfield.
* [ ] 6. The mission briefing should display the information from MissionBriefing.txt (copy-paste, you don't have to read from the file). It also contains a placeholder for the agent's last name.
* [ ] 7. The background color of the view should change to green on successful authentication of the agent.
* [ ] 8. The background color of the view should change to red to indicate a failed login of the agent.

### Hard Mode
* [ ] Modify the constraints on the imageview (and possibly other views) to cause the logo to shrink when switching to landscape orientation (the current constraints cause it to float off the bottom of the viewable screen). 
```
## The Right Mindset

Continue working on your essay, now progressing in the Revision phase. You should start to produce a Final Draft starting with the best parts of your Roughs. Edit and expand them with a series of revisions, which you save as edits in the wiki. Every time you save an edit of a wiki page on GitHub, the system is actually making a commit. You may notice at the bottom when in edit mode that there is a field to enter and _edit message_, which is just like a commit message. This means you can review all the states of the wiki page as it has changed over time, just like a repo!