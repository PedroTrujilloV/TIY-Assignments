//
//  WeatherDay.swift
//  Forecaster
//
//  Created by Pedro Trujillo on 11/1/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation


class WeatherDay
{

    let summary : String
    let icon : String
    let temperature : String
    let time: String
    
    init(summary: String, icon: String, temperature: String, time:String)
    {
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
        self.time = time
    }
 
}