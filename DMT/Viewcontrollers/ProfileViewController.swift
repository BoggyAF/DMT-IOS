//
//  ProfileViewController.swift
//  DMT
//
//  Created by Boza Rares-Dorian on 18/06/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    var  userDetails: UserDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userDetails?.avatar)
        if userDetails?.avatar != "" {
        let avatar = userDetails?.avatar?.fromBase64()
        profileImageView.image = avatar
        }
    }

    
}

extension String{
    func fromBase64() -> UIImage{
        let dataDecoded  = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        let image = UIImage(data: dataDecoded as Data)
        return image!
    }
}
