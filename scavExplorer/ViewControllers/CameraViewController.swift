//
//  CameraViewController.swift
//  scavExplorer
//
//  Created by Jacob Huffman on 5/8/20.
//  Copyright © 2020 Jacob Huffman. All rights reserved.
//

import UIKit
import RealityKit
import CoreLocation
import AVFoundation

let formatter = DateFormatter()
let CurrentDate = formatter.string(from: Date())
let Tomorrow = formatter.string(from:Date.init(timeIntervalSinceNow: 86400))

let AllEvents = Utilities.getEvents(CurrentDate, dateTomorrow: Tomorrow)

let LCSC_Library = Locations(Name: "LCSC Library", latitude: 46.412756, longitude: -117.025822)
let Sacajawea = Locations(Name: "Sacajawea Hall", latitude: 46.412956, longitude: -117.027038)
let Talkington = Locations(Name: "Talkington Hall", latitude: 46.412956, longitude: -117.027209)
let MLH = Locations(Name: "MLH", latitude: 46.412347, longitude: -117.026389)
let SUB = Locations(Name: "SUB", latitude: 46.411649, longitude: -117.026845)
let ACW = Locations(Name: "Activity Center West", latitude: 46.411302, longitude: -117.026080)
let AC = Locations(Name: "Activity Center", latitude: 46.411319, longitude: -117.025289)
let Silverthorne = Locations(Name: "Silverthorne Theatre", latitude: 46.412050, longitude: -117.0246796)
let Sam_Glenn = Locations(Name: "Sam Glenn Complex", latitude: 46.410842, longitude: -117.027554)
let Harris_Field = Locations(Name: "Harris Field", latitude: 46.410874, longitude: -117.024778)
let Tennis_Center = Locations(Name: "Tennis Center", latitude: 46.410441, longitude: -117.026977)
let Clearwater = Locations(Name: "Clearwater Hall", latitude: 46.421389, longitude: -117.027902)
let Art = Locations(Name: "Art Under the Elms", latitude: 46.421676, longitude: -117.027443)


let AllLocations = [LCSC_Library, Sacajawea, Talkington, MLH, SUB, ACW, AC, Silverthorne, Sam_Glenn, Harris_Field, Tennis_Center, Clearwater, Art]
class CameraViewController: UIViewController {
    
    @objc let locationManager:CLLocationManager = CLLocationManager()

    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestAlwaysAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        findEvent()
        
        //let boxAcnchor = try! Experience.loadBox()
        
        //arView.scene.anchors.append(boxAcnchor)
        
        //let arView = ARView(frame: .zero)

    }
    
    func findEvent() {
        let timer = Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
        }
        @objc func updateLocation() {
            var currentLocation = locationManager.location
            var userLat = currentLocation?.coordinate.latitude
            var userlng = currentLocation?.coordinate.longitude
            var minDistance = 100.0
            var locationName = ""
            
            for locate in AllLocations {
                
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
            if (minDistance <= 40.0)
            {
                let box = CustomBox(color: .black, position: [0.0, 0.0, 0.0])
                arView.scene.anchors.append(box)
                
                let mesh = MeshResource.generateText(locationName, extrusionDepth: 0.1, font: .systemFont(ofSize: 2), containerFrame: .zero, alignment: .center, lineBreakMode: .byTruncatingTail)
                
                let material = SimpleMaterial(color: .blue, isMetallic: false)
                
                let entity = ModelEntity(mesh: mesh, materials: [material])
                entity.scale = SIMD3<Float>(0.03, 0.03, 0.01)
                
                box.addChild(entity)
                
                entity.setPosition(SIMD3<Float>(0.0, 0.05, 0.0), relativeTo: box)
            }
            else {
                let box = CustomBox(color: .black, position: [0.0, 0.0, 0.0])
                arView.scene.anchors.append(box)
                
                let mesh = MeshResource.generateText("Closest location too far away", extrusionDepth: 0.1, font: .systemFont(ofSize: 2), containerFrame: .zero, alignment: .center, lineBreakMode: .byTruncatingTail)
                
                let material = SimpleMaterial(color: .blue, isMetallic: false)
                
                let entity = ModelEntity(mesh: mesh, materials: [material])
                entity.scale = SIMD3<Float>(0.03, 0.03, 0.01)
                
                box.addChild(entity)
                
                entity.setPosition(SIMD3<Float>(0.0, 0.05, 0.0), relativeTo: box)
            }
            
        }

}
