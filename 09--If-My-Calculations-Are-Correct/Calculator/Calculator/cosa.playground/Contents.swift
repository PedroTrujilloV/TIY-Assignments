//: Playground - noun: a place where people can play

import UIKit

var str = "1234"

case "0":
if isFloat == true
{
    writeInMantiza(digito)
}
else
{
    
    writeInMantiza(digito)
}


print("0")
case ".":
print(".")
isFloat = true

default:
//var digito:Double = (digit as NSString).doubleValue

print(digito)
writeInMantiza(digito)
printInDisplay(String(format: "%.1f", buffer))

break


var digit = Double(str)

func writeInMantiza(digito:Double)
{
    if buffer >= 0
    {
        if buffer < 0
        {
            buffer = (buffer / 10) + (digito)
        }
        else
        {
            buffer = (buffer * 10) + (digito)
        }
    }
    else
    {
        if abs(buffer) < 0
        {
            buffer = (buffer / 10) - (digito)
        }
        else
        {
            buffer = (buffer * 10) - (digito)
        }
    }
}

//        print(valueD)
//        switch operation
//        {
//        case "+/-":
//            //valueOperated = plusMin(yN:valueD)
//            function = plusMin
//            bufferCalculations.append(valueOperated)
//
//        case "%":
//             //valueOperated = remi(buffer,yN: valueD)
//            function = remi
//            bufferCalculations.append(function)
//
//        case "/":
//            //valueOperated = divi(buffer,yN: valueD)
//             function = remi
//             bufferCalculations.append(function)
//
//        case "x":
//            //valueOperated = mult(buffer,yN: valueD)
//
//            function = mult
//            bufferCalculations.append(function)
//
//        case "-":
//            ///valueOperated = subs(buffer,yN: valueD)
//            function = subs
//            bufferCalculations.append(function)
//
//        case "+":
//            //valueOperated = sum(buffer,yN: valueD)
//            function = sum
//            bufferCalculations.append(function)
//
//        default:
//            //valueOperated = def( valueD)
//            function = def
//            bufferCalculations.append(function)
//            break

//MARK: - Helper operations functions
//var digito:Double = (digit as NSString).doubleValue//conver string to Double


//    func sum(xN:Double, yN:Double) -> Double//(Double)
//    {
//        return Double(xN + yN)
//    }
//
//    func subs(xN:Double, yN:Double) ->Double//(Double)
//    {
//        return Double(yN - xN)
//    }
//
//    func mult(xN:Double, yN:Double) ->Double//(Double)
//    {
//        return Double(xN * yN)
//    }
//
//    func divi(xN:Double, yN:Double) ->Double//(Double)
//    {
//        return Double(yN / xN)
//    }
//
//    func remi(xN:Double, yN:Double) ->Double//(Double)
//    {
//        return Double(xN % yN)
//    }
//
//    func plusMin(xN:Double = -1, yN:Double) ->Double//(Double)
//    {
//        return Double(mult(xN , yN: yN))
//    }
//    func def(yN:Double) ->Double//(Double)
//    {
//        return Double(mult(1 , yN: yN))
//    }
//
