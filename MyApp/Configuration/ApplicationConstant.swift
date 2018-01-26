//
//  ApplicationConstant.swift
//  MyApp
//
//  Created by ishwar lal janwa on 21/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//

import Foundation

import UIKit

let CColorTheme_760AFF = CRGB(r: 118, g: 10, b: 225)

let CColorBlack_515253 = CRGB(r: 81, g: 82, b: 83)
let CColorWhite_FFFFFF = CRGB(r: 255, g: 255, b: 255)


let CColorRed_D0021B = CRGB(r: 208, g: 3, b: 27)
let CColorRed_C91215 = CRGB(r: 201, g: 18, b: 21)
let CColorRed_E77B89 = CRGB(r: 231, g: 123, b: 137)


let CColorGray_F5F5F5 = CRGB(r: 245, g: 245, b: 245)
let CColorGray_E3E3E3 = CRGB(r: 227, g: 227, b: 227)
let CColorGray_9B9B9B = CRGB(r: 155, g: 155, b: 155)
let CColorGray_EEEEEE = CRGB(r: 238, g: 238, b: 238)
let CColorGray_B2B2B2 = CRGB(r: 178, g: 178, b: 178)



let CUserID             = "userID"


enum FontType : Int {
    case Regular
    case Bold
    case Medium
    case Light
    case Thin
}

func CFontRoboto(size: CGFloat, type: FontType) -> UIFont
{
    
    switch type
    {
    case .Regular:
        return UIFont.init(name: "Roboto-Regular", size: size)!
        
    case .Bold:
        return UIFont.init(name: "Roboto-Bold", size: size)!
        
    case .Medium:
        return UIFont.init(name: "Roboto-Medium", size: size)!
        
    case .Light:
        return UIFont.init(name: "Roboto-Light", size: size)!
        
    case .Thin:
        return UIFont.init(name: "Roboto-Thin", size: size)!
    }
}





func GetDigitsFromString(text: String) -> String {
    return text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
}


let CJsonResponse       = "response"
let CJsonMessage        = "message"
let CJsonStatus         = "status"
let CStatusCode         = "status_code"
let CJsonTitle          = "title"
let CJsonData           = "data"

let CStatusZero         = NSNumber(value: 0 as Int)
let CStatusOne          = NSNumber(value: 1 as Int)
let CStatusFive         = NSNumber(value: 5 as Int)
let CStatusNine         = NSNumber(value: 9 as Int)
let CStatusTen          = NSNumber(value: 10 as Int)

let CStatusTwoHundred   = NSNumber(value: 200 as Int)       //  Success
let CStatusFourHundredAndOne = NSNumber(value: 401 as Int)     //  Unauthorized user access
let CStatusFiveHundredAndFiftyFive = NSNumber(value: 555 as Int)   //  Invalid request
let CStatusFiveHundredAndFiftySix = NSNumber(value: 556 as Int)   //  Invalid request
let CStatusFiveHundredAndFifty = NSNumber(value: 550 as Int)        //  Inactive/Delete user


let CStatusFiveHunred   = NSNumber(value: 500 as Int)



