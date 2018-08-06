//
//  CardCollectionViewCell.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 4/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell , Reusable {

    @IBOutlet weak var cardView: UIImageView!
   
    static var nib: UINib? {
        return UINib(nibName: String(describing: CardCollectionViewCell.self), bundle: nil)
    }
    
    public func flipUp(card: Card) {
        cardView.image = card.image
        card.isFlippedUp = true
    }
    
    public func flipDown(card: Card) {
        cardView.image = card.coverImg
        card.isFlippedUp = false
    }

    public func setCardImgViewWith(card: Card) {
        
        self.cardView.image = card.isRemoved ? card.image : (card.isFlippedUp ? card.image : card.coverImg)
        self.cardView.isUserInteractionEnabled = !card.isRemoved
    }
}
