//
//  event.swift
//  scavExplorer
//
//  Created by Jacob Huffman on 4/20/20.
//  Copyright © 2020 Jacob Huffman. All rights reserved.
//

import Foundation

struct Event: Codable {
    
    var summary:String?
    var description:String?
    var location:String?
    var htmlLink:String?
}
