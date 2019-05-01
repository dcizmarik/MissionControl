//
//  Launches.swift
//  MissionControl
//
//  Created by Daniel Cizmarik on 4/28/19.
//  Copyright © 2019 Daniel Cizmarik. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Launches {
    
    var launchList: [Launch] = []
    var apiURL = "https://launchlibrary.net/1.4/launch/next/20" //needs number for amount of launches to be added onto end
    
    func getLaunches(completed: @escaping ()->() ) {
        Alamofire.request(apiURL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let events = json["count"].intValue
                print(json)
                print(events)
                for index in 0..<events {
                    let launchName = json["launches"][index]["name"].stringValue
                    let launchDate = json["launches"][index]["net"].stringValue
                    let launchPadName = json["launches"][index]["location"]["pads"][0]["name"].stringValue
                    let launchDescription = json["launches"][index]["missions"][0]["description"].stringValue
                    let launchAgency = json["launches"][index]["location"]["pads"][0]["agencies"][0][
                        "name"].stringValue
                    let imageLink = json["launches"][index]["rocket"]["imageURL"].stringValue
                    let missionType = json["launches"][index]["missions"][0]["typeName"].stringValue
                    let launchRocketName = json["launches"][index]["rocket"]["name"].stringValue
                    let launchLatitude = json["launches"][index]["location"]["pads"][0]["latitude"].stringValue
                    let launchLongitude = json["launches"][index]["location"]["pads"][0]["longitude"].stringValue
                    let launchTimeIso = json["launches"][index]["isonet"].stringValue
                    let launchShortLocation = json["launches"][index]["location"]["name"].stringValue
                    
                    self.launchList.append(Launch(launchName: launchName, launchPadName: launchPadName, launchDate: launchDate, launchDescription: launchDescription, launchAgency: launchAgency, imageLink: imageLink, missionType: missionType, launchRocketName: launchRocketName, launchLatitude: launchLatitude, launchLongitude: launchLongitude, launchTimeIso: launchTimeIso, launchShortLocation: launchShortLocation))
                }
        
            case .failure(let error):
                print("Error: getLaunches() failure.")
                print("\(error.localizedDescription) failed to get data from URL: \(self.apiURL)")
            }
            completed()
        }
    }
}
