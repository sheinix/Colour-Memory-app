//
//  TopScoreTableViewCell.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 6/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import UIKit

class TopScoreTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    static var nib: UINib? {
        return UINib(nibName: String(describing: TopScoreTableViewCell.self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
