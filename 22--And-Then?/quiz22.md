## What sequence of objects from this JSON document are needed to fetch the value of the key _temperature_ inside _daily_?

```
{  “date”: 192840963,  “currently”: {
    “temperature”: 72.12,    “dewPoint”: 64.93,    “humidity”: 0.82  },
  “daily”: [    {      “temperature”: 86.71,      “dewPoint”: 78.1,      “humidity”: 0.76    },
    {      “temperature”: 90.01,      “dewPoint”: 79.3,      “humidity”: 0.86    }
  ]}
```

---

## What sequence of objects from this JSON document are needed to fetch the value of the key _temperature_ inside _daily_?

```
DictionaryArray (daily)Dictionary (daily[0])double (temperature)
```

---

# How do you set what part of the map is shown in a UIMapView?

```
let mapView = UIMapView()let viewRegion = MKCoordinateRegion()mapView.?
```

---

# How do you set what part of the map is shown in a UIMapView?

```
let mapView = UIMapView()let viewRegion = MKCoordinateRegion()mapView.setRegion(viewRegion)
```

---

# To use ```MKAnnotation``` in a class, what must be done first?

---

# To use ```MKAnnotation``` in a class, what must be done first?

```
import MapKit
```