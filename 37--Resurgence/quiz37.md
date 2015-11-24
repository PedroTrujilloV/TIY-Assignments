## What kind of object is a Sprite?

---

## What kind of object is a Sprite?

```SKSpriteNode```, which can display a textured image, a colored square, or a textured image blended with a color.

---

## In UIKit, a screen of content is usually some kind of UIView. What is the analogous object in SpriteKit?

---

## In UIKit, a screen of content is usually some kind of UIView. What is the analogous object in SpriteKit?

An instance of the ```SKScene``` class

---

## What method should be run when sprites move off the screen?

---

## What method should be run when sprites move off the screen?

```swift
SKAction.removeFromParent()
```