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
//: A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99. Find the largest palindrome made from the product of two 3-digit numbers.

var nDigits = 3
var palindrome = 0
var palTemp = 0
var arrayTemp = [Int]()
var largestPal = 0


for var n1 = 100; n1 < 1000; n1++
{
    for var n2 = 100; n2 < 1000; n2++
    {
        palindrome = n1*n2
          palTemp = palindrome
        
        for var div=0 ;div<3; div++
        {
              while palTemp > 0
              {
                  arrayTemp.append(palTemp%10)
                  palTemp = palTemp/10
              }
                if arrayTemp.reverse() == arrayTemp
                {
                    if largestPal < palindrome
                    {
                        largestPal = palindrome
                    }
                }
            //

        }
        
    }
}
largestPal

