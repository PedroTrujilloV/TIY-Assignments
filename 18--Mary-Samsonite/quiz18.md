# Toggle the BOOL value below

```swift
var aBool = true
aBool = ...
```

---

# Toggle the BOOL value below

```swift
var aBool = true
aBool = !aBool
```

---

# Convert the string into an NSURL object

```swift
let username = "aStudent"
let urlString = “https://api.github.com/users/" + username
let url = ?
```

---

# Convert the string into an NSURL object

```swift
let username = "aStudent"
let urlString = “https://api.github.com/users/" + username
let url = NSURL(string: urlString)
```

---

# Based on the JSON, what kind of object would be returned?

```json
[
    {
        "name": "Nyota Uhura",
        "title": "Chief Communications Officer",
        "rank": "Lieutenant"
    },
    {
        "name": "Montgomery Scott",
        "title": "Chief Engineer",
        "rank": "Lieutenant Commander"
    }
]
```

---

```swift
? = NSJSONSerialization.JSONObjectWithData(data, options:[]) as! ?
```

---

# Based on the JSON, what kind of object would be returned?

```swift
let crew = NSJSONSerialization.JSONObjectWithData(data, options:[]) as! NSArray
```
