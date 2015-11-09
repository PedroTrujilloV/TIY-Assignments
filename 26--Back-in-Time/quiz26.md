## How do you add a string to another string?
1. ```NSString *aString = @“Hello, “ + @“World!”;```1. ```NSString *aString = @“Hello @“World””;```1. ```NSString *aString = [NSString stringWithFormat: @“Hello, %d!“, @“World”];```1. ```NSString *aString = [NSString stringWithFormat: @“Hello, %@!“, @“World”];```

---

## How do you add a string to another string?

```NSString *aString = [NSString stringWithFormat: @“Hello, %@!“, @“World”];```

---

## Using the model object and label below, how would you set the label using the model object's name attribute?

```GroceryItem *anItem;
```(contains 3 attributes: name, category and aisle)

```UILabel *aLabel = [[UILabel alloc] init];```

---

## Using the model object and label below, how would you set the label using the model object's name attribute?

```
aLabel.text = anItem.name;
```

---

## How do you send a message to your delegate?
1. ```delegate messageToSend:argumentVariable;```1. ```self.delegate.messageToSend(argumentVariable);```
1. ```[self.delegate messageToSend:argumentVariable];```

---

## How do you send a message to your delegate?```[self.delegate messageToSend:argumentVariable];
```