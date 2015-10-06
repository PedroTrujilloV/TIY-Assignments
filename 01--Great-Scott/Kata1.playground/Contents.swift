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
var arrayTemp = [Int]()
var largestPal = 0

//: 2. *This is the first for loop that calculate the first number from 100 to 999  'numbers of 3 digits'*
for var n1 = 100; n1 < 1000; n1++
{
//: 3. *Second for loop to the second number from 100 to 999 to multipli by the first number: *
    for var n2 = 100; n2 < 1000; n2++
    {
//: 4. *Multiply both numbers n1 x n2*
        palindrome = n1*n2
//: 5. *Store too it in a temporal var*
          palTemp = palindrome
//: 6
        for var div=0 ;div<3; div++
        {
//: 7 *While there is a number to split by 10*
              while palTemp > 0
              {
//: 8 *Append the last number in the temporal array*
                  arrayTemp.append(palTemp%10)
//: 9 *Split the number by 10 so we just have a number of less digits*
                  palTemp = palTemp/10
              }
//: 10 *Compare the Number in the array with its reverse version if is same*
                if arrayTemp.reverse() == arrayTemp
                {
//: 11 *Compare if the last palindrome is smaller than the new palindrome*
                    if largestPal < palindrome
                    {
//: 12 *If yes then replace the last palindrome by the new palindrome*
                        largestPal = palindrome
                    }
                }
        }
    }
}
//: 13 *It shows the largest palindrome*
largestPal

