//
//  OfferDtailsViewController.swift
//  DMT
//
//  Created by Boggy on 22/07/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

import UIKit

class OfferDtailsViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellDataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellDataArray[indexPath.row].cell == 1 {
            let cell = Bundle.main.loadNibNamed("OfferDetailsTableViewCell1", owner: self, options: nil)?.first as! OfferDetailsTableViewCell1
            cell.headerLabel.text = cellDataArray[indexPath.row].text
            
            return cell
        }
        else if cellDataArray[indexPath.row].cell == 2 {
            let cell = Bundle.main.loadNibNamed("OfferDetailsTableViewCell2", owner: self, options: nil)?.first as! OfferDetailsTableViewCell2
            cell.descriptionLabel.text = cellDataArray[indexPath.row].text
            
            return cell
        }
        else {
            let cell = Bundle.main.loadNibNamed("OfferDetailsTableViewCell1", owner: self, options: nil)?.first as! OfferDetailsTableViewCell1
            cell.headerLabel.text = cellDataArray[indexPath.row].text
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cellDataArray[indexPath.row].cell == 1 {
            return 128
        }
        else if cellDataArray[indexPath.row].cell == 2 {
            return 180
        }
        else {
            return 128
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageSlider: UIPageControl!
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    struct cellData {
        let cell: Int!
        let text: String!
    }
    
    var imageArray = [UIImage]()
    var cellDataArray = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellDataArray = [cellData(cell: 1, text: "da"),
                         cellData(cell: 2, text: "nu")]
        
        imageArray = [UIImage(imageLiteralResourceName: "Bufnita"), UIImage(imageLiteralResourceName: "Caine"), UIImage(imageLiteralResourceName: "Vulpe")]
        imageScrollView.delegate = self
        imageSlider.numberOfPages = imageArray.count
        imageSlider.currentPage = 0
        imageScrollView.contentSize.width = imageScrollView.frame.width * CGFloat(imageArray.count)
        imageScrollView.isPagingEnabled = true
        
        for i in 0..<imageArray.count{
            
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            let xPos = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: self.imageScrollView.frame.width, height: self.imageScrollView.frame.height)
            imageScrollView.addSubview(imageView)
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(imageScrollView.contentOffset.x/view.frame.width)
        imageSlider.currentPage = Int(pageIndex)
    }
}
