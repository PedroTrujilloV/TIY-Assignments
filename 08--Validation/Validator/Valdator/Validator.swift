//
//  Validator.swift
//  Valdator
//
//  Created by Pedro Trujillo on 10/14/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation



class Validator
{
    func ValidateName(name:String) ->Bool
    {
        if name.componentsSeparatedByString(" ").count == 2
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    func ValidateAddress(address:String) ->Bool
    {
        return true
    }
    
    func ValidateCity(city:String) ->Bool
    {
        if city.characters.count > 0
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    func ValidateState(state:String) ->Bool
    {
        if state.characters.count == 2
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func ValidateZipCode(zipCode:String) ->Bool
    {
      ///  let characterSet =  NSCharacterSet.letterCharacterSet() //
        let characterSet = "abcdefghijklmnopqrstuwxyzABCDEFGHIJKLMNOPQRSTUWXYZ"
       //for char in String(characterSet).characters
        for char in characterSet.characters
        {
            if zipCode.characters.contains(char)
            {
                return false
            }
            else
            {
                return true
            }
        }
        //thing
        
        return true
    }
    func ValidatePhoneNumber(phoneNumber:String) ->Bool
    {
        return true
    }
    
}