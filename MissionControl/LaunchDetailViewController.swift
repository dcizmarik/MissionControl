//
//  LaunchDetailViewController.swift
//  MissionControl
//
//  Created by Daniel Cizmarik on 4/28/19.
//  Copyright © 2019 Daniel Cizmarik. All rights reserved.
//

import UIKit
import MapKit
import EventKit


class LaunchDetailViewController: UIViewController {
    
    
    @IBOutlet weak var launchNameLabel: UILabel!
    @IBOutlet weak var launchPadLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var launchDescriptionField: UITextView!
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var launchAgencyName: UILabel!
    @IBOutlet weak var launchMissionType: UILabel!
    @IBOutlet weak var launchRocketName: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var launch = Launch()
    
    var launchLatitude = 0.0
    var launchLongitude = 0.0
    
    let regionDistance: CLLocationDistance = 750
    
    let dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self as? MKMapViewDelegate
        mapView.mapType = MKMapType.hybridFlyover
        updateUserInterface()
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: launchLatitude, longitude: launchLongitude), latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapView.setRegion(region, animated: true)
    }
    
    func updateUserInterface() {
        
        launchNameLabel.text = launch.launchName
        launchPadLabel.text = launch.launchPadName
        launchDateLabel.text = launch.launchDate
        
        launchDescriptionField.text = launch.launchDescription
        launchAgencyName.text = launch.launchAgency
        launchMissionType.text = launch.missionType
        launchRocketName.text = launch.launchRocketName
        
        if (launch.imageLink != "https://s3.amazonaws.com/launchlibrary/RocketImages/placeholder_1920.png") || (launch.imageLink == "") {
            load_image(image_url_string: launch.imageLink, view: rocketImageView)
            launchAgencyName.frame = CGRect(x: 16, y: 187, width: 378, height: 17)
            launchMissionType.frame = CGRect(x: 16, y: 212, width: 378, height: 17)
            launchRocketName.frame = CGRect(x: 16, y: 237, width: 378, height: 17)
        }
        launchLatitude = Double(launch.launchLatitude) ?? 0.0
        launchLongitude = Double(launch.launchLongitude) ?? 0.0
        
        if launch.launchAgency == "" {
            launchMissionType.frame.origin.y -= 25
            launchRocketName.frame.origin.y -= 25
        }
        if launch.missionType == "" {
            launchRocketName.frame.origin.y -= 25
        }
        
        
        
        
        if launch.launchDescription == "" {
            mapView.frame = CGRect(x: 16, y: 329, width: 378, height: 387)
            launchDescriptionField.isHidden = true
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    func getDate() -> Date? {
        let dateString = launch.launchTimeIso
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmssZ"
        return dateFormatter.date(from: dateString)
    }
    
    @IBAction func addToCalendarButtonPressed(_ sender: UIButton) {
        
        let eventStore : EKEventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event) { (granted, error) in
            
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(error)")
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                
                event.title = "\(self.launch.launchName) launch"
                event.startDate = self.getDate()
                event.endDate = self.getDate()
                event.notes = "This is a note"
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                }
                print("Saved Event")
            }
            else{
                
                print("failed to save event with error : \(error) or access not granted")
            }
        }
        
        
    }
    
    func load_image(image_url_string:String, view:UIImageView)
    {
        
        var image_url: NSURL = NSURL(string: image_url_string)!
        let image_from_url_request: NSURLRequest = NSURLRequest(url: image_url as URL)
        
        NSURLConnection.sendAsynchronousRequest(
            image_from_url_request as URLRequest, queue: OperationQueue.main,
            completionHandler: {(response: URLResponse!,
                data: Data!,
                error: Error!) -> Void in
                
                if error == nil && data != nil {
                    view.image = UIImage(data: data)
                }
                
        })
        
    }
    
    
    
    
}
