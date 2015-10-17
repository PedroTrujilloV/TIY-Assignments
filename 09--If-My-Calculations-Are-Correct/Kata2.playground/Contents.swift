//: ## Question 1
//: ### Leap Year
//: You are given a year, determine if it’s a leap year. A leap year is a year containing an extra day. It has 366 days instead of the normal 365 days. The extra day is added in February, which has 29 days instead of the normal 28 days. Leap years occur every 4 years. 2012 is a leap year and so is 2016. Except that every 100 years special rules apply. Years that are divisible by 100 are not leap years if they are not divisible by 400. For example 1900 was not a leap year, but 2000 was. __Print Leap year! or Not a leap year! depending on the case.__
func isLeapYear(year:Int)-> Bool
{
    return (year % 4) == 0 && (year/100 % 4) == 0  //condition 1 : is leap because is % 4 and condition 2: is leap because each 100 year if not % 400
}

//test cases:
//var yeartest = 2041
//var yeartest = 2012
//var yeartest = 2016
//var yeartest = 2000
var yeartest = 1900
isLeapYear(yeartest)
//: ## Question 2
//: ### Food Spoilage
//: You are working on a smart-fridge. The smart-fridge knows how old the eggs and bacon in it are. You know that eggs spoils after 3 weeks (21 days) and bacon after one week (7 days). Given ```baconAge``` and ```eggsAge``` (in days) determine if you can cook bacon and eggs or what ingredients you need to throw out.
//:
//: If you can cook bacon and eggs print you can cook bacon and eggs. If you need to throw out any ingredients for each one print a line with the text throw out ingredient (throw out bacon or throw out eggs) in any order.
let expirationLimitDict = [ "bacon":7, "egg":21, "onion":45, "chicken":7, "beef":3]
var foodDaysInFridgeDict = [ "onion":20, "bacon":10, "chicken":5, "egg":15, "beef":7]

func canIcookThoseTogether(food1:String, food2:String) -> String
{
    var answer = ""
    
    if !throwAway(food1) && !throwAway(food2)
    {
        answer = "Yes, you can! that sounds good!"
    }
    else
    {
        answer = "Eww! No, that sounds disgusting.."
    }
    
    //also
    var throwIt = ""
    
    for (food,daysIn) in foodDaysInFridgeDict
    {
        food
        if throwAway("\(food)")
        {
            throwIt += "\(food), "
        }
    }
    
    if throwIt != ""
    {
        answer += " Also please throw away: \(throwIt).. very old food"
    }
    
    return answer
}
func throwAway(food:String) -> Bool
{
    return expirationLimitDict[food] <= foodDaysInFridgeDict[food]
}

//test cases:
//canIcookThoseTogether("egg", food2: "onion")
canIcookThoseTogether("egg", food2: "bacon")
//: ## Question 3
//: ### Difference of Square of Sums and Sum of Squares
//: The sum of the squares of the first ten natural numbers is,
//: 1^2 + 2^2 + ... + 10^2 = 385
//:
//: The square of the sum of the first ten natural numbers is,
//: (1 + 2 + ... + 10)^2 = 55^2 = 3025
//:
//: Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
//: __Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.__
func SquareOfSums(value:Int)->Int
{
    if value * value <= 0
    {
        return value
    }
    else
    {
      return (value * value) + SquareOfSums(value-1)
    }
}
func SumOf(value:Int)->Int
{
    if value <= 0
    {
        return value 
    }
    else
    {
        return value  + SumOf(value-1)
    }
}
func SumOfSquares(value:Int) ->Int
{
    return SumOf(value) * SumOf(value)
}

//test cases:
//let value = 10
//let value = 0
let value = 99

let diference = SumOfSquares(value) - SquareOfSums(value)






