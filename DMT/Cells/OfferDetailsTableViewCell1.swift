//
//  OfferDetailsViewCell1.swift
//  DMT
//
//  Created by Boggy on 23/07/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit
protocol OffersTableViewCellProtocol {
    
}

class OfferDetailsTableViewCell1: UITableViewCell, OffersTableViewCellProtocol {

    static let ReuseIdentifier = String(describing: OfferDetailsTableViewCell1.self)
    static let NibName = String(describing: OfferDetailsTableViewCell1.self)
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}
