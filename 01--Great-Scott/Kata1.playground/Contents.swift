//: # Coding Kata Week 1

//: ## Question 1
//: ### Multiples of 3 and 5
//: If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000:
//: 1. *Inicialization of all constants n1, n2, and range and an Int var to store the sum*
let num1 = 3
let num2 = 5
let rangeBelow = 1000
var sumJointList = 0
//: 2. *Filtering of multiples for n1 and n2 in the range*
let listNum1 = Array(1..<rangeBelow).filter{$0 % num1 == 0}
let listNum2 = Array(1..<rangeBelow).filter{$0 % num2 == 0}
//: 3. *Just show values of each array list*
listNum1
listNum2
//: 4. *join the lists in an unique variable list*
var joinList_1_2 = listNum1 + listNum2
//: 5. *Just show value for new joinList*
joinList_1_2
//: 6. *while the size of joinList is > 0*
while joinList_1_2.count > 0
{
//: 7. *sum each popped element in sumJointList*
    sumJointList += joinList_1_2.removeLast()
}
//: 8. *Just show value for new sumJointList*
sumJointList

//: ## Question 2
//: ### Largest Palindrome Product
//: A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99. Find the largest palindrome made from the product of two 3-digit numbers:

//: 1. *Define the vars and temp vars to store the values all of them empty*

//var nDigits = 3
var palindrome = 0
var palTemp = 0
var largestPal = 0
var Number1 = 0
var Number2 = 0


//: 2. *This is the first  loop that calculate the first number from 100 to 999  'numbers of 3 digits'*
for var n1 = 100; n1 < 1000; n1++
{
//: 3. *Second  loop to the second number from 100 to 999 to multipli by the first number: *
    var n2 = 100
    while n2 < 1000
    {
//: 4. *Multiply both numbers n1 x n2*
        palindrome = n1*n2
//: 5. *Store too it in a temporal var and Inicialization the temporals vars*
        palTemp = palindrome
        var nDigitsToSplit = 10 // 1 x max number of digits to split the temporal palindrome ex: 1234/1000
        var sizeInt = 2 // number of digits of the int number
//: 6. *Calculate the number of digits of the posible number*
        while palTemp >= 10
        {
            palTemp  = Int(palTemp/nDigitsToSplit)
            nDigitsToSplit*=10
            sizeInt++
        }
        palTemp = palindrome
        
        
//: 7. *check if is the number of digits is odd to calculate the limit of last number of digits*
        var limit = 1
        if sizeInt % 2 == 0
        {
            limit = 0
        }
//: 8. *look if this number is palindrome or not*
            while palTemp > limit
            {
                var front = palTemp/nDigitsToSplit
                var rear = palTemp%10
                
                if front != rear
                {
                    break
                }
                else
                {
                    palTemp = palTemp - (front*nDigitsToSplit)
                    palTemp = palTemp/10
                }
                nDigitsToSplit/=10
           }
//: 9 *Compare if the number is in limit of digits*
        if palTemp == limit
        {
//: 10 *Compare if the last palindrome is smaller than the new palindrome*
            if palindrome >= largestPal
            {
//: 11 *If yes then replace the last palindrome by the new palindrome*
                largestPal = palindrome
                Number1 = n1
                Number2 = n2
            }
        }
        n2++
    }
}
//: 13 *It shows the largest palindrome*
largestPal
Number1
Number2

