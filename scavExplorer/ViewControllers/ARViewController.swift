//
//  ViewController.swift
//  scavExplorer
//
//  Created by Jacob Huffman on 5/6/20.
//  Copyright © 2020 Jacob Huffman. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation
import RealityKit

class ARViewController: UIViewController {
    
    @IBOutlet var BulitinView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boxAnchor = try! Experience.loadBox()
        
        BulitinView.scene.anchors.append(boxAnchor)

        // Do any additional setup after loading the view.
    }
    // MARK: - Navigation


}
