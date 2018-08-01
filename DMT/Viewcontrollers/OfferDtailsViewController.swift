//
//  OfferDtailsViewController.swift
//  DMT
//
//  Created by Boggy on 22/07/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

import UIKit

struct cellData {
    let cell: String!
    let text: String!
}

class OfferDtailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageSlider: UIPageControl!
    @IBOutlet weak var imageScrollView: UIScrollView!
  
    var imageArray = [UIImage]()
    var cellDataArray = [cellData]()
    var  clickedOfferDetailFromServer: ClickedOfferDetail?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        createImageArray()
        
        
        guard let clickedOfferDetails = clickedOfferDetailFromServer else {
            print("Alerta - date neconcludente!")
            return
        }
        print("clickedOfferDetails - \(clickedOfferDetails)")
        
        cellDataArray = [cellData(cell: OfferDetailsTableViewCell1.ReuseIdentifier, text: "da"),
                         cellData(cell: OfferDetailsTableViewCell2.ReuseIdentifier, text: "nu")]
        

        // xib register
        
        let nib1 = UINib(nibName: OfferDetailsTableViewCell1.NibName, bundle: .main)
        tableView.register(nib1, forCellReuseIdentifier: OfferDetailsTableViewCell1.ReuseIdentifier)
        
        let nib2 = UINib(nibName: OfferDetailsTableViewCell2.NibName, bundle: .main)
        tableView.register(nib2, forCellReuseIdentifier: OfferDetailsTableViewCell2.ReuseIdentifier)
    }

    func createImageArray() {
        
        imageArray = [UIImage(imageLiteralResourceName: "Bufnita"),
                      UIImage(imageLiteralResourceName: "Caine"),
                      UIImage(imageLiteralResourceName: "Vulpe")]
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
}


extension OfferDtailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("cellDataArray.count = \(cellDataArray.count)")
        return cellDataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:OffersTableViewCellProtocol? = nil
        
        switch cellDataArray[indexPath.row].cell {
        case OfferDetailsTableViewCell1.ReuseIdentifier:
                cell = tableView.dequeueReusableCell(withIdentifier: OfferDetailsTableViewCell1.ReuseIdentifier) as? OffersTableViewCellProtocol
                cell?.config(withData: cellDataArray[indexPath.row])
            
        case OfferDetailsTableViewCell2.ReuseIdentifier:
                cell = tableView.dequeueReusableCell(withIdentifier: OfferDetailsTableViewCell2.ReuseIdentifier) as? OffersTableViewCellProtocol
                cell?.config(withData: cellDataArray[indexPath.row])

        default:
            cell = tableView.dequeueReusableCell(withIdentifier: OfferDetailsTableViewCell1.ReuseIdentifier) as? OffersTableViewCellProtocol
                cell?.config(withData: cellDataArray[indexPath.row])
        }
        
        return cell as! UITableViewCell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cellDataArray[indexPath.row].cell == OfferDetailsTableViewCell1.ReuseIdentifier {
            return 128
        }
        else if cellDataArray[indexPath.row].cell == OfferDetailsTableViewCell2.ReuseIdentifier {
            return 180
        }
        else {
            return 128
        }
    }
}

extension OfferDtailsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(imageScrollView.contentOffset.x/view.frame.width)
        imageSlider.currentPage = Int(pageIndex)
    }
    
}

