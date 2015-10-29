//: ## Question 1
//: ### Prime Numbers
//: Implement the following functions. The divides function returns ```true``` if ```a``` is divisible by ```b``` and ```false``` otherwise. The ```countDivisors``` function should use the ```divides``` function to return the number of ```divisors``` of ```number```. The ```isPrimefunction``` should use the ```countDivisors``` function to determine if ```number``` is prime.

func divides(a: Int, b: Int) -> Bool
{
    return a % b == 0 ? true:false
}

func countDivisors(number: Int) -> Int
{
    var n = number
    var count = 0
    while n > 0
    {
       if divides(number,b: n)
       { count++}
        n--
    }
    return count
}

func isPrime(number: Int) -> Bool
{
    if countDivisors(number) <= 2
    {return true}
    return false
}

let thing = isPrime(5)
print(thing)
//: ## Question 2
//: ### First Primes
//: Using ```isPrime``` from the previous question, write a function named ```printFirstPrimes``` that takes a parameter named ```count``` of type ```Int``` that prints the first ```count``` prime numbers. For example, if ```count``` were set to 5, it would print "2, 3, 5, 7, 11"
func printFirstPrimes(count:Int)
{
    if count > 0
    {
       if isPrime(count)
       { print(count)}
        printFirstPrimes(count - 1)
    }
}

printFirstPrimes(20)

//: ## Question 3
//: ### Reverse
//: Write a function named ```reverse``` that takes an array of integers named ```numbers``` as a parameter. The function should return an array with the numbers from ```numbers``` in reverse order.
func reverse(numbers:Array<Int>) -> Array<Int>
{
    return numbers.reverse()
}

let cosa = reverse([1,2,3,4,5,7,6,8,9,0])


//: ## Question 4
//: ### Time Difference
//: Write a function named ```timeDifference```. It takes as input four numbers that represent two times in a day and returns the difference in minutes between them. The first two parameters ```firstHour``` and ```firstMinute``` represent the hour and minute of the first time. The last two ```secondHour``` and ```secondMinute``` represent the hour and minute of the second time. All parameters should have external parameter names with the same name as the local ones.
// if is military time

func timeDifference(firstHour: Int, firstMinute: Int, secondHour: Int, secondMinute: Int) -> Int
{
    return ((secondHour * 60) + secondMinute) - ((firstHour * 60) + firstMinute)
}
let firstHour = 5
let firstMinute = 20
let secondHour = 14
let secondMinute = 55
let diferenceInMinutes = timeDifference(firstHour, firstMinute: firstMinute, secondHour: secondHour, secondMinute: secondMinute)
let diferenceInHours = diferenceInMinutes/60

