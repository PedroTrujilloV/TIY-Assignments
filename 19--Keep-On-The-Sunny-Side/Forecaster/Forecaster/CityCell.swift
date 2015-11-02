//
//  GitHubFriendCell.swift
//  GitHub Friends
//
//  Created by Pedro Trujillo on 10/27/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell
{
    let WeatherLabelEmoji:UILabel = UILabel(frame: CGRect(x: 5, y: 10, width: 100, height: 60))
    let TemperatureLabel:UILabel = UILabel(frame: CGRect(x: UIScreen.mainScreen().bounds.width * 7/12, y: 0, width: 100, height: 80))
    let SummaryLabel:UILabel = UILabel(frame: CGRect(x: UIScreen.mainScreen().bounds.width * 3/10, y: 40, width: 100, height: 40))
    let NameLabel:UILabel = UILabel(frame: CGRect(x: UIScreen.mainScreen().bounds.width * 3/10, y: 5, width: 100, height: 40))
    
    
    var weekDays = ["1":"Sunday","2":"Monday","3":"Tuesday","4":"Wednesday","5":"Thursday","6":"Friday","7":"Saturday"]


    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    

    
    func setTemperaturLabel(temperature:String = "0")
    {
    
        TemperatureLabel.text = temperature+"°F"
        
        // WeatherLabelEmoji.center.y = (imageView?.center.y)!
        TemperatureLabel.font = UIFont(name: "AvenirNextCondensed-Bold", size: 45)//-Next-Condensed
        TemperatureLabel.textAlignment = .Center
        TemperatureLabel.textColor = UIColor.blackColor()
        
        
        
        self.addSubview(TemperatureLabel)
    }
    
    func setSummaryLabel(summary:String = "0")
    {
        if summary.characters.count < 7
        {
            self.SummaryLabel.font = UIFont(name: "AvenirNextCondensed-Bold", size: 30)//-Next-Condensed
        }
        else
        {
            if summary.characters.count < 9
            {
                self.SummaryLabel.font = UIFont(name: "AvenirNextCondensed-Bold", size: 24)//-Next-Condensed
            }
            else
            {
               
               self.SummaryLabel.font = UIFont(name: "AvenirNextCondensed-Bold", size: 18)//-Next-Condensed
                self.SummaryLabel.numberOfLines = 2
            }
        }
        SummaryLabel.text = summary
        SummaryLabel.textAlignment = .Center
        SummaryLabel.textColor = UIColor.grayColor()
        
        
        
        self.addSubview(SummaryLabel)
    }
    func setNameLabel(name:String = "0")
    {
        if name.characters.count < 8
        {
            NameLabel.font = UIFont(name: "AvenirNextCondensed", size: 30)//-Next-Condensed
        }
        else
        {
            
            NameLabel.font = UIFont(name: "AvenirNextCondensed", size: 15)//-Next-Condensed
        }
        NameLabel.text = name
        NameLabel.textAlignment = .Center
        NameLabel.textColor = UIColor.blackColor()
        
        
        
        self.addSubview(NameLabel)
    }
    
    
    
    func loadImage(wEmoji:String = "fog" , ImagePath:String = "gravatar.png")
    {
        //var cosa = "⚡️🌙☀️⛅️☁️💧💦☔️💨❄️🔥🌌⛄️⚠️❗️🌁🚀"
        let dictEmoji:Dictionary = [ "clear-day": "☀️","clear-night": "🌙", "rain":"☔️", "snow":"❄️", "sleet":"💦", "wind":"💨","fog":"🌁", "cloudy":"☁️", "partly-cloudy-day":"⛅️", "partly-cloudy-night":"🌌", "hail":"⛄️", "thunderstorm":"⚡️", "tornado":"⚠️","rocket":"🚀"]
        
        WeatherLabelEmoji.text = dictEmoji[wEmoji]
        
       // WeatherLabelEmoji.center.y = (imageView?.center.y)!
        WeatherLabelEmoji.font = UIFont(name: "HelveticaNeue-Bold", size: 80)
        WeatherLabelEmoji.textAlignment = .Center
        WeatherLabelEmoji.textColor = UIColor.cyanColor()
            

        self.imageView!.image = UIImage(named: ImagePath)
        
        self.addSubview(WeatherLabelEmoji)
//        WeatherLabelEmoji.center.x = (imageView?.frame.size.width)!/2
//        WeatherLabelEmoji.center.y = (imageView?.center.y)! - ((imageView?.frame.size.height)!/2)
    }
    
    func getDateDayString(wdate:String) -> String //http://stackoverflow.com/questions/28875356/how-to-get-next-10-days-from-current-date-in-swift
    {//http://stackoverflow.com/questions/25533147/get-day-of-week-using-nsdate-swift
        
        
        
        
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(wdate)!  ) //1415637900 )
        
        let formatter        = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Weekday, fromDate: date)
        let weekDay = myComponents.weekday
        
        
        //let newDate = formatter.stringFromDate(date)
        
        return self.weekDays[weekDay.description]!
    }

}
