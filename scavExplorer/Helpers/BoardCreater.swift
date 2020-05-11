//
//  BoardCreater.swift
//  scavExplorer
//
//  Created by Jacob Huffman on 5/11/20.
//  Copyright © 2020 Jacob Huffman. All rights reserved.
//

import Foundation
import RealityKit
import UIKit

class CustomBox: Entity, HasModel, HasAnchoring, HasCollision {
    
    required init(color: UIColor) {
        super.init()
        self.components[ModelComponent] = ModelComponent(
            mesh: .generateBox(size: 0.1), materials:[SimpleMaterial(color: color, isMetallic: false)
        ]
        )
    }
    convenience init(color: UIColor, position: SIMD3<Float>) {
        self.init(color: color)
        self.position = position
    }
    required init() {
        fatalError("init() has not been implemented")
    }
}
