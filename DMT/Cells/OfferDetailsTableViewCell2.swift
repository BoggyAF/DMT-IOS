//
//  OfferDetailsTableViewCell2.swift
//  DMT
//
//  Created by Boggy on 23/07/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class OfferDetailsTableViewCell2: UITableViewCell, OffersTableViewCellProtocol {

    static let ReuseIdentifier = String(describing: OfferDetailsTableViewCell2.self)
    static let NibName = String(describing: OfferDetailsTableViewCell2.self)
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
}
