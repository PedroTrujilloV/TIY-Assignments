//: # Question 1
//: ## Seconds
//: Determine the number of seconds in a year and store the number in a variable named ```secondsInAYear```.

func isLeapYear(year:Int)-> Bool
{
    return (year % 4) == 0 && (year/100 % 4) == 0  //condition 1 : is leap because is % 4 and condition 2: is leap because each 100 year if not % 400
}

func getDaysByKindOfYear(year: Int) -> Int
{
    if !isLeapYear(year)
    {
        return 365
    }
    else
    {
        return 366
    }
}


var year = 2015 // remember set the year

var secondsInMinute = 60
var minutesInHour = 60
var hourInDay = 24
var daysInYear = getDaysByKindOfYear(year)

//var secondsInAYear = secondsInMinute * minutesInHour * hourInDay * daysInYear

//secondsInAYear


//: # Question 2
//: ## Coin Toss
//: If you use ```arc4random()``` it will give you a random number. Generate a random number and use it to simulate a coin toss. Print "heads" or "tails".
import Foundation

func coinToss() -> String
{
    if arc4random() % 2 == 0
    {return "heads"}
    else
    { return "tails"}
}

//var turn = coinToss()

//turn


//: # Question 3
//: ## Testing
//: Test if ```number``` is divisible by 3, 5 and 7. For example 105 is divisible by 3,5 and 7, but 120 is divisible only by 3 and 5 and not by 7. If ```number``` is divisible by 3, 5, 7 print "number is divisible by 3, 5 and 7" otherwise print "number is not divisible by 3, 5 and 7".
var number = arc4random() % 1000


func isDivisibleBy_3_5or7_this(number:Int) -> Bool
{
    return number % 3 == 0 && number % 5 == 0 && number % 7 == 0
}

var ans:Bool = isDivisibleBy_3_5or7_this(Int(number)) //?

