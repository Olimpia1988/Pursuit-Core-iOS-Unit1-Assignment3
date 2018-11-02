//
//  main.swift
//  Calculator
//
//  Created by Alex Paul on 10/25/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

func mathStuffFactory(opString: String) -> (Double, Double) -> Double {
    switch opString {
    case "+":
        return {x, y in x + y }
    case "-":
        return {x, y in x - y }
    case "*":
        return {x, y in x * y }
    case "/":
        return {x, y in x / y }
    default:
        return {x, y in x + y }
    }
}

var oneBool = false
while oneBool == false {
    print("Enter an operation. e.g 5 + 5")
    //var arrayInt = [Double]()
    //var operatorCast = String()
    
    let userResponse = readLine()
    if let response = userResponse {
        let components = response.components(separatedBy: " ")      //[num, symbol, num]
        
        
        if components.count == 3 {
            //print(components)
            let operation = mathStuffFactory(opString: components[1])
            oneBool = true
            //unwrap
            let safeFirstNum = Double(components[0]) ?? 0.0
            let safeSecondNum = Double(components[2]) ?? 0.0
            
            print(operation((safeFirstNum), (safeSecondNum)))
        } else {
            print("not a valid: please use the format num symbol num e.g 1 + 1")
            oneBool = false
        }
        
    }
}

print("Do you want to calculate again")
var myBool = false
while myBool == false  {
    let userResponse2 = readLine()
    if let response2 = userResponse2 {
        switch response2 {
        case "yes":
            
            myBool = true
        case "no":
            print("ok then ✌🏻")
            myBool = true
        default:
            print("not a valid answer, please enter 'yes' or 'no'")
            myBool = false
        }
    }
}

print("calculate again")

var userInputNum = readLine()
if let userNum = userInputNum {
    let components2 = userNum.components(separatedBy: " ")
    
    let secondOperation = mathStuffFactory(opString: components2[1])
    let safeNums = Double(components2[0]) ?? 0.0
    let safeNums2 = Double(components2[2]) ?? 0.0
    
    print(Int(secondOperation((safeNums), (safeNums2))))
    print("Your operation is: \(Int(safeNums)) \(components2[1]) \(Int(safeNums2)) = \(Int(secondOperation((safeNums), (safeNums2))))")
    
    var myBool1 = false
    let symbols = ["+", "-", "*", "/"]
    for sym in symbols {
        if sym == components2[1] {
            let symbol = symbols.randomElement()!
            let secondOperation2 = mathStuffFactory(opString: symbol)
            
            let test = secondOperation2(Double(safeNums),Double(safeNums2))
            print("""
                guess the operation: Enter +, -, * or /
                \(Int(safeNums))  ? \(Int(safeNums2)) = \(test)
                """)
            
            while myBool1 == false {
                let lastUserInput = readLine()
                if let lastInput = lastUserInput {
                    if lastInput == symbol {
                        print("Correct!")
                        myBool1 = true
                    } else {
                        if symbols.contains(lastInput) {
                            print("incorrect")
                            myBool1 = false
                            
                        } else {
                            print("invalid")
                            myBool1 = false
                        }
                    }
                }
            }
        }
    }
}
func reduceFuntion(arrOfNum: [Int], start: Int, reduceClosure: (Int) -> Int) -> Int{
    var result = start
    for num in arrOfNum{
        result += reduceClosure(num)
    }
    
    return result
}


func mapfuntion(arrayOfNums: [Int], mapClosure: (Int) -> Int) -> [Int]{
    var anEmptyArray = [Int]()
    for num in arrayOfNums{
        anEmptyArray.append(mapClosure(num))
    }
    return anEmptyArray
}

func filterFunction(inputArray: [Int], filter: (Int) -> Bool) -> [Int] {
    var resultArray = [Int]()
    
    for num in inputArray{
        if filter(num){
            resultArray.append(num)
        }
    }
    return resultArray
}
print("Enter your function e.g. filter 1,2,3,4 by < 4")
var booltToProtectIncorrectUserInputFromCrashing = true
while booltToProtectIncorrectUserInputFromCrashing == true {
    let unserInput3 = readLine()
    if let input3 = unserInput3 {
        
        let components3 = input3.components(separatedBy: " ")
        
        if components3.count == 5 {
            let strToNum = Int(components3[4])!
            
            let numArrayString = components3[1].components(separatedBy: ",")
            var emptyArray = [Int]()
            for str in numArrayString {
                let safeStr = Int(str) ?? 0
                emptyArray.append(safeStr)
            }
            switch components3[0] {
            case "filter" :
                switch components3[3] {
                case "<" :
                    print(filterFunction(inputArray:emptyArray , filter: { ( strToNum < $0) ? true : false }))
                case ">" :
                    print(filterFunction(inputArray:emptyArray , filter: { ( strToNum > $0) ? true : false }))
                default:
                    print("Not valid input")
                }
            case "map":
                switch components3[3]{
                case "*":
                    print(mapfuntion(arrayOfNums: emptyArray, mapClosure: { (strToNum * $0) }))
                case "/":
                    print(mapfuntion(arrayOfNums: emptyArray, mapClosure: { (strToNum / $0) }))
                default:
                    print("not a valid answer")
                }
            case "reduce":
                switch components3[3]{
                case "+":
                    print(reduceFuntion(arrOfNum: emptyArray, start: 0, reduceClosure: { (strToNum + $0)}))
                case "*":
                    print(reduceFuntion(arrOfNum: emptyArray, start: 0, reduceClosure: { (strToNum * $0)}))
                default:
                    print("not valid")
                }
            default:
                print("default")
            }
            booltToProtectIncorrectUserInputFromCrashing = false
            
        } else {
            print("Not a valid intpu, please enter a valid format e.g filter 1,2,3,4 by > 4")
            booltToProtectIncorrectUserInputFromCrashing = true
        }
    }
}









