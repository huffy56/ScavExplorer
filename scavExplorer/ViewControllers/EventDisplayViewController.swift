//
//  EventDisplayViewController.swift
//  scavExplorer
//
//  Created by Jacob Huffman on 4/17/20.
//  Copyright © 2020 Jacob Huffman. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import AVFoundation
// MARK: - User Location and Date
let currentDate = Date()
let tomorrow = Date.init(timeIntervalSinceNow: 86400)

let TestLocations = [LCSC_Library, Clearwater, Art]
//MARK: -Start of EventDisplayViewController
class EventDisplayViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UNUserNotificationCenterDelegate{
    
    @objc let locationManager:CLLocationManager =  CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var objectLabel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let systemSoundID: SystemSoundID = 1016
        AudioServicesPlaySystemSound(systemSoundID)
        requestPermissionNotifications()
        locationManager.requestAlwaysAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        findLocation()

        //MARK: -Set up monitoring
        /*LCSC_Library_Region.notifyOnEntry = true
        LCSC_Library_Region.notifyOnExit = false
        
        Sacajawea_Hall_Region.notifyOnEntry = true
        Sacajawea_Hall_Region.notifyOnExit = false
        
        Talkington_Hall_Region.notifyOnEntry = true
        Talkington_Hall_Region.notifyOnExit = false
        
        MLH_Region.notifyOnEntry = true
        MLH_Region.notifyOnExit = false
        
        SUB_Region.notifyOnEntry = true
        SUB_Region.notifyOnExit = false
        
        Activity_Center_West_Region.notifyOnEntry = true
        Activity_Center_West_Region.notifyOnExit = false
        
        Activity_Center_Region.notifyOnEntry = true
        Activity_Center_Region.notifyOnExit = false
        
        Silverthorne_Theatre_Region.notifyOnEntry = true
        Silverthorne_Theatre_Region.notifyOnExit = false
        
        Sam_Glenn_Region.notifyOnEntry = true
        Sam_Glenn_Region.notifyOnExit = false
        
        Harris_Field_Region.notifyOnEntry = true
        Harris_Field_Region.notifyOnExit = false
        
        Tennis_Center_Region.notifyOnEntry = true
        Tennis_Center_Region.notifyOnExit = false
        
        Clearwater_Hall_Region.notifyOnEntry = true
        Clearwater_Hall_Region.notifyOnExit = false*/
        
        
        
        //MARK: - Start monitoring regions
        /*func startMonitoring(region: CLCircularRegion)
        {
            if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
                print("Geofencing is not supported on this device")
            }
            locationManager.startMonitoring(for: LCSC_Library_Region)
            locationManager.startMonitoring(for: Sacajawea_Hall_Region)
            locationManager.startMonitoring(for: Talkington_Hall_Region)
            locationManager.startMonitoring(for: MLH_Region)
            locationManager.startMonitoring(for: SUB_Region)
            locationManager.startMonitoring(for: Activity_Center_West_Region)
            locationManager.startMonitoring(for: Activity_Center_Region)
            locationManager.startMonitoring(for: Silverthorne_Theatre_Region)
            locationManager.startMonitoring(for: Sam_Glenn_Region)
            locationManager.startMonitoring(for: Harris_Field_Region)
            locationManager.startMonitoring(for: Tennis_Center_Region)
            locationManager.startMonitoring(for: Clearwater_Hall_Region)
            
        }*/
    }
    
    /*func locationManager(_manager: CLLocationManager, didEnterRegion: CLRegion) {
        let systemSoundID: SystemSoundID = 1016
        AudioServicesPlaySystemSound(systemSoundID)
        print("Entered a geofence")
    }*/
    
    func findLocation() {
        let timer = Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
    }
    @objc func updateLocation() {
        let systemSoundID: SystemSoundID = 1016
        AudioServicesPlaySystemSound(systemSoundID)
        var currentLocation = locationManager.location
        var userLat = currentLocation?.coordinate.latitude
        var userlng = currentLocation?.coordinate.longitude
        var minDistance = 100.0
        var locationName = ""
        
        for locate in TestLocations {
            
            let radiusEarth = 6731
            
            let partOne = locate.latitude * (Double.pi / 180.0)
            let partTwo = userLat! * (Double.pi / 180.0)
            let lat1 = locate.latitude
            let lat2 = userLat!
            
            let partThree = (lat1 - lat2) * (Double.pi / 180.0)
            
            let lng1 = locate.longitude
            let lng2 = userlng!
            
            let partFour = (lng1 - lng2) * (Double.pi / 180.0)
            
            let a = (sin(partThree / 2) * sin(partThree / 2)) + cos(partOne) * cos(partTwo) * ( sin(partFour / 2) * sin(partFour / 2) )
            
            let c = 2 * atan2(sqrt(a), sqrt(1 - a))
            let d = (Double(radiusEarth) * c) * 1000.0
            
            
            if(d < minDistance)
            {
                minDistance = d
                locationName = locate.Name
            }
        }
        if (minDistance <= 25.0)
        {
            objectLabel.text = locationName
            descriptionLabel.text = String(minDistance)
        }
        else {
            objectLabel.text = "Closest location is too far away"
        }
        
    }    //MARK: -Request notification permission
    func requestPermissionNotifications() {
        let application = UIApplication.shared
        
        if #available(iOS 13.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (isAuthorized, error) in
                
                if(error != nil){
                    print(error!)
                }
                else{
                    if(isAuthorized){
                        print("authorized")
                        NotificationCenter.default.post(Notification(name: Notification.Name("Authorized")))
                    }
                    else{
                        let pushPreference = UserDefaults.standard.bool(forKey: "PREF_PUSH_NOTIFICATIONS")
                        if(pushPreference == false)
                        {
                            let alert = UIAlertController(title: "Turn on notifications", message: "Push notifications are turned off", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Turn on notifications", style: .default, handler: {(alertAction) in
                                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                    return
                                }
                                if UIApplication.shared.canOpenURL(settingsUrl) {
                                    UIApplication.shared.open(settingsUrl, completionHandler: { (success)  in
                                        print("Setting is opened: \(success)")
                                    })
                                }
                                UserDefaults.standard.set(true, forKey: "PREF_PUSH_NOTIFICATIONS")
                            }))
                            alert.addAction(UIAlertAction(title: "No thanks.", style: .default, handler: { ( actionAlert) in
                                print("user denied")
                                UserDefaults.standard.set(true, forKey: "PREF_PUSH_NOTIFICATIONS")
                            }))
                            let viewController = UIApplication.shared.keyWindow!.rootViewController
                            DispatchQueue.main.async {
                                viewController?.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
        else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
    }
    
    //MARK: -Send user notification function
    func postLocalNotifications(eventTitle:String) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = eventTitle
        content.body = "You have entered a new region"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let notificationRequest: UNNotificationRequest = UNNotificationRequest(identifier: "Region", content: content, trigger: trigger)
        
        center.add(notificationRequest, withCompletionHandler: { (error) in
            if let error = error {
                print(error)
            }
            else {
                print("added")
            }
        })
    }

}

