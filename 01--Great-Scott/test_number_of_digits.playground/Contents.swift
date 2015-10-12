


//: 1. *Define the vars and temp vars to store the values all of them empty*

//var nDigits = 3
var palindrome = 0
var palTemp = 0
var largestPal = 0
var Number1 = 0
var Number2 = 0
var end = false


//: 2. *This is the first  loop that calculate the last-1 number from 999 to 100  'numbers of 3 digits'*
for var n1 = 999; n1 > 99; n1--
{
    //: 3. *Second  loop to the second number from 999 to 100 to multipli by the last-1 number: *
    for var n2 = 999; n2 > 99; n2--
    {
        //: 4. *Multiply both numbers n1 x n2*
        palindrome = n1*n2
        //: 5. *Store too it in a temporal var and Inicialization the temporals vars*
        palTemp = palindrome
        var nDigitsToSplit = 1 // 1 x max number of digits to split the temporal palindrome ex: 1234/1000
        var sizeInt = 0 // number of digits of the int number
        //: 6. *Calculate the number of digits of the posible number*
        
        while nDigitsToSplit <= palindrome
        {
            nDigitsToSplit*=10
            sizeInt++
        }
        
        
        //: 7. *check if is the number of digits is odd to calculate the limit of last number of digits*
        var limit = 1
        if sizeInt % 2 == 0
        {
            limit = 0
        }
        //: 8. *look if this number is palindrome or not*
        while sizeInt > limit
        {
            nDigitsToSplit/=10
            sizeInt--
            
            var front:Int = palTemp/nDigitsToSplit
            var rear:Int = palTemp%10
            
            if front != rear
            {
                break
            }
            else
            {
                palTemp = palTemp - (front*nDigitsToSplit)
                palTemp = palTemp/10
            }
            //nDigitsToSplit/=10
        }
        //: 9 *Compare if the number is in limit of digits*
        if palTemp == limit
        {
            //: 10 *Compare if the last palindrome is smaller than the new palindrome*
            if palindrome > largestPal
            {
                //: 11 *If yes then replace the last palindrome by the new palindrome*
                largestPal = palindrome
                Number1 = n1
                Number2 = n2
            }
            else
            {
                end = true
                break
            }
        }
        
    }
    if end
    {break}
}
//: 13 *It shows the largest palindrome*
largestPal
Number1
Number2
