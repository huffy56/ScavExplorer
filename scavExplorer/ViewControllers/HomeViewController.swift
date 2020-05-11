//
//  HomeViewController.swift
//  scavExplorer
//
//  Created by Jacob Huffman on 4/17/20.
//  Copyright © 2020 Jacob Huffman. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class HomeViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var viewEventsButton: UIButton!
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
    }
    

    @IBAction func logOutTapped(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            transitionToMain()
        } catch let signOutError as NSError {
            print ("Error signingout: %@", signOutError)
        }
    }
    
    @IBAction func viewEventsTapped(_ sender: Any) {
        
        
    }
    
    func transitionToMain()
    {
        let mainViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainViewController)
        
        view.window?.rootViewController = mainViewController
        view.window?.makeKeyAndVisible()
    }

}
