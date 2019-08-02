//
//  Anchor.swift
//  CapstoneProject
//
//  Created by GWC2 on 7/30/19.
//  Copyright © 2019 GWC2. All rights reserved.
//

import ARKit

enum NodeType: String {
    case alien = "alien"
    case fuel = "fuel"
}

class Anchor: ARAnchor {
    var type: NodeType?
}
