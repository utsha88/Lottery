//
//  ViewController.swift
//  Lottery
//
//  Created by Utsha Guha on 26-9-17.
//  Copyright © 2017 Utsha Guha. All rights reserved.
//

/*
 
 Winning Ticket!
 
 Your favorite uncle, Morty, is crazy about the lottery and even crazier about how he picks his “lucky” numbers. And even though his “never fail” strategy has yet to succeed, Uncle Morty doesn't let that get him down.
 
 Every week he searches through the Sunday newspaper to find a string of digits that might be potential lottery picks. But this week the newspaper has moved to a new electronic format, and instead of a comfortable pile of papers, Uncle Morty receives a text file with the stories.
 
 Help your Uncle find his lotto picks. Given a large series of number strings, return each that might be suitable for a lottery ticket pick. Note that a valid lottery ticket must have 7 unique numbers between 1 and 59, digits must be used in order, and every digit must be used exactly once.
 
 For example, given the following strings:
 
 [ "569815571556", “4938532894754”, “1234567”, “472844278465445”]
 
 Your function should return:
 
 4938532894754 -> 49 38 53 28 9 47 54
 1234567 -> 1 2 3 4 5 6 7
 
*/

import UIKit

class ViewController: UIViewController {
    
    let maxDigit:Int = 5
    let expectedCount = 7
    var storageCharacter:Int?
    var resultArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let finalOutput = getLotteryNumbersFor(["569815571556","4938532894754","1234567","472844278465445"])
        print("Final Output = \n\(finalOutput)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLotteryNumbersFor(_ lotteries:[String]) -> String {
        var output = ""
        for lottery in lotteries{
            // Finding lucky lottery number from each of the number string.
            output += pickNumberLogic(lottery)
        }
        return output
    }
    
    func pickNumberLogic(_ inputValue:String) -> String {
        for i in 0...inputValue.characters.count-1 {
            // Finding Current Character
            let index = inputValue.index(inputValue.startIndex, offsetBy: i)
            let endIndex = inputValue.index(inputValue.startIndex, offsetBy: i+1)
            let currentChar = inputValue[(index..<endIndex)]
            
            if (storageCharacter != nil) {  // Grouping the current character with previous character.
                addLotteryNumbers(currentChar)
            }
            // Getting first character of Group
            else if(Int(currentChar) == 0){ // If current character is 0 then move to next character
                continue
            }
            else if((Int(currentChar)! > maxDigit)
                || (inputValue.characters.count - i == expectedCount - resultArray.count)){
                // 1. if first character is >5 then it can not grou with next character, this character need to be added in the result seprately
                // 2. if remaining character count in input string matches with remaining result count then current character need to be added in result.
                addLotteryNumbers(currentChar)
            }
            else{
                storageCharacter = Int(currentChar)
            }
        }
        
        var outputString = ""
        if resultArray.count == expectedCount{
            outputString = inputValue + " -> " + resultArray.joined(separator: " ") + "\n"
        }
        
        resultArray.removeAll()
        return outputString
    }
    
    func addLotteryNumbers(_ currentCharacter:String) -> Void {
        if (storageCharacter != nil) {
            addTwoDigitsInResult(currentCharacter)
        }else{
            addOneDigitInResult(currentCharacter)
        }
    }
    
    func addTwoDigitsInResult(_ currentCharacter:String) -> Void {
        let combinedNumber = String(storageCharacter!) + currentCharacter   // Grouping current and previous characters.
        if !(resultArray.contains(combinedNumber)) {    // Validating if the result already contains the current number(double digit)
            resultArray.append(combinedNumber)
            storageCharacter = nil  // Setting 'storageCharacter' to nil so that the current number does not group with next character
        }
        else{
            // As the 'combinedNumber' already exists in result, hence adding the previous character of current character to result. If the currentCharacter>7 then adding 'currentCharacter' to result else grouping it with the next character.
            addOneDigitInResult(String(storageCharacter!))
            if Int(currentCharacter)!>maxDigit {
                addOneDigitInResult(currentCharacter)
            }
            else{
                storageCharacter = Int(currentCharacter)
            }
        }
    }
    
    /** Adding One digit lottery in the result. **/
    func addOneDigitInResult(_ currentCharacter:String) -> Void {
        if !(resultArray.contains(currentCharacter)) {  // Validating if the result already contains the current number(single digit)
            resultArray.append(currentCharacter)
        }
        storageCharacter = nil  // Setting 'storageCharacter' to nil so that the current number does not group with next character
    }
}

