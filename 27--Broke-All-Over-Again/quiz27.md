# Which of these is “modal”?
* 1a. Navigation Controller	* 1b. Main Table View (Action: tap cell)
		* 1c. Detail View* 2a. Table View with tweets	* 2b. (not logged in, app launches login)
		* 2c. Login View, animated up to cover Table View with view showing Username and Password prompts

---

# Which of these is "modal"?
2c. The login view

---

# What prints to the console?

```objectivecNSNumber *aNumber = [NSNumber numberWithInt:12];NSNumber *anotherNumber = [NSNumber numberWithInt:12];if (aNumber == anotherNumber){  NSLog(@"Numbers are equal");}else {  NSLog(@"Numbers are not equal");}```

---

# What prints to the console?

Numbers are not equal.

```==``` is doing a comparison of the memory locations (pointers), not the values of the objects.

---

# What prints to the console?```objectivecBOOL success = YES;NSLog(@“Operation was %@“, (success) ? @“successful” : @“not successful”);
```

---

# What prints to the console?

Operation was successful