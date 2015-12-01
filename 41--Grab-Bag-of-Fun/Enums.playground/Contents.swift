//enum CompassPoint
//{
//    case North
//    case South
//    case East
//    case West
//}

enum CompassPoint: String
{
    case North, South, East, West
}

// .North is not equal to 0, it is a defined value on its own
var directionToHead = CompassPoint.North

// directionToHead's data type is now implicitly defined as CompassPoint, meaning you can change the value with shorter dot syntax
directionToHead = .East

// Switch statements must be exhaustive for the data type being switched. Since all 4 possible states are covered, no default is needed.

switch directionToHead
{
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rises")
case .West:
    print("Where the skies are blue")
}

// All cases can be combined to 1 line if desired
//enum Planet
//{
//    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
//}

enum Planet: Int
{
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

// Since choices are not exhaustive, default is needed
let somePlanet = Planet.Earth
switch somePlanet
{
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

// Enum values can have associated values

enum Barcode
{
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)

productBarcode = .QRCode("ABCDEFGHIJKLMNOP")

switch productBarcode
{
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode):
    print("QR code: \(productCode).")
}

//switch productBarcode
//{
//case let .UPCA(numberSystem, manufacturer, product, check):
//    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
//case let .QRCode(productCode):
//    print("QR code: \(productCode).")
//}


// Alternatively to associated values, enums can instead have raw (default or initial) values.
enum ASCIIControlCharacter: Character
{
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

// “Raw values can be strings, characters, or any of the integer or floating-point number types. Each raw value must be unique within its enumeration declaration.”

let earthsOrder = Planet.Earth.rawValue

let sunsetDirection = CompassPoint.West.rawValue

// When an enum has a rawValue defined, an initializer is automatically created that takes a rawValue and will try to create an enum with that value. Warning: it is optional, meaning it could return nil. This is called a failable initializer.
let possiblePlanet = Planet(rawValue: 7)

// Example of using optional binding to determine whether there is a planet at position 9.
let positionToFind = 9
if let somePlanet = Planet(rawValue: positionToFind)
{
    switch somePlanet
    {
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else
{
    print("There isn't a planet at position \(positionToFind)")
}

// Enums can support recursion, as shown below to model simple arithmetic expressions.

enum ArithmeticExpression
{
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

func evaluate(expression: ArithmeticExpression) -> Int
{
    switch expression
    {
    case .Number(let value):
        return value
    case .Addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .Multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

// evaluate (5 + 4) * 2
let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
print(evaluate(product))
