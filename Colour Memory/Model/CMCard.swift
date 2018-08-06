//
//  CMCard.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 4/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import Foundation
import UIKit

class Card {
    var image : UIImage
    var coverImg : UIImage
    var currentIdxPath : IndexPath?
    var isFlippedUp : Bool = false
    var isRemoved : Bool = false
    var colourNumber : Int
    
    init(image: UIImage, colourNumber: Int) {
        self.image = image
        self.colourNumber = colourNumber
        self.coverImg = UIImage(named: "card_bg")!
    }
}

extension Card : Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.colourNumber == rhs.colourNumber
    }
}

extension Card : Hashable {
    var hashValue: Int {
        return colourNumber
    }
}
