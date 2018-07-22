//
//  OfferDtailsViewController.swift
//  DMT
//
//  Created by Boggy on 22/07/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class OfferDtailsViewController: UIViewController {

    @IBOutlet weak var imageScrollView: UIScrollView!
    
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageArray = [UIImage(imageLiteralResourceName: "Bufnita"), UIImage(imageLiteralResourceName: "Caine"), UIImage(imageLiteralResourceName: "Vulpe")]
        
        for i in 0..<imageArray.count{
            
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            let xPos = Int(self.view.frame.width) * i
            imageView.frame = CGRect(x: xPos, y: 0, width: Int(self.imageScrollView.frame.width), height: Int(self.imageScrollView.frame.height))
            
            imageScrollView.contentSize.width = imageScrollView.frame.width * CGFloat(i + 1)
            imageScrollView.addSubview(imageView)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
