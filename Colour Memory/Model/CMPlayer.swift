//
//  CMPlayer.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 4/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import Foundation


class Player : Codable {
    var name : String?
    var points : Int = 0
    
    init(_ number: Int) {
        self.name =  "Player \(number)"
        self.points = 0
    }
    
    init(name: String, points : Int) {
        self.name = name
        self.points = points
    }
}

extension Player : Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}
