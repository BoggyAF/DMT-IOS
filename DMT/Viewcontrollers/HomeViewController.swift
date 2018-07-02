//
//  HomeViewController.swift
//  DMT
//
//  Created by Boza Rares-Dorian on 20/05/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UltraWeekCalendarDelegate, UICollectionViewDelegate, UICollectionViewDataSource

{
    
    @IBOutlet weak var noOffersLabel: UILabel!
    @IBOutlet var noOffersView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var  userDetails: UserDetails? // aceasta instanta este creata atunci cand se va face tranzitia din LoginVC in HomeVC
    var  offerDetails: [OffersDetail] = []
    var  offerNumber: Int?
    let reuseIdentifier = "cell"
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerDetails.count // il gaseste ca nil
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as!CollectionViewCell

        cell.offerTitleLabel.text = self.offerDetails[indexPath.item].titluOferta
        cell.offerLocationLabel.text = self.offerDetails[indexPath.item].numeLocatie
        cell.offerPriceLabel.text = self.offerDetails[indexPath.item].pretOferta
        cell.backgroundColor = UIColor.white

        return cell

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("celula selectata -  \(indexPath.item)!")

    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-15, height: 80)

    }
    
    
    
    var calendar : UltraWeekCalendar? = nil
        
    override func viewDidLoad() {
        print("HomeViewController - viewDidLoad")
        super.viewDidLoad()
        calendar = UltraWeekCalendar.init(frame: CGRect(x: 0, y: Constraints.topBarHeight, width: UIScreen.main.bounds.width, height: 60))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let someDateTime = formatter.date(from: "2018/10/08")
        calendar?.delegate = self
        calendar?.startDate = Date()
        calendar?.endDate = someDateTime
        calendar?.selectedDate = Date()
        self.view.addSubview(calendar!)
        collectionView.backgroundView = noOffersView
        
        prepareCollectionView()
        
        if offerNumber != nil {
            self.noOffersLabel.text = ""
        } else {
            self.noOffersLabel.text = "No Offers"
        }
        
        // oferte aduse
        
        var params = Parameters()
        params["request"] = "0"
        params["id_user"] = userDetails?.idUser
        let loadingScreen = UIViewController.displaySpinner(onView: self.view)
        Services.getAllOffers(params: params) { [weak self] result in
            UIViewController.removeSpinner(spinner: loadingScreen)
            switch result {
            case .success(let json):
                guard let responseFromJSON = json.response else {
                    return
                }
                guard let messageFromJSON = json.msg else {
                    return
                }
                guard let resultFromJSON = json.result else {
                    return
                }
                
                    switch messageFromJSON {
                    case ServerRequestConstants.JSON.RESPONSE_ERROR :
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                            DispatchQueue.main.async {
                                AlertManager.showGenericDialog(responseFromJSON, viewController: self!)
                                
                            }
                        }
                    case ServerRequestConstants.JSON.RESPONSE_SUCCESS:
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                            DispatchQueue.main.async {
                                self?.offerNumber = resultFromJSON.count
                                self?.offerDetails = resultFromJSON
                                print(self?.offerDetails[1].numeLocatie as Any)
                                AlertManager.showGenericDialog("Avem \(String(describing: self?.offerNumber)) oferte!", viewController: self!)
                                
                            }
                        }
                    default:
                        break
                    }
                
    
            case .error(let errorString):
                print("errorString = \(errorString)")
                
                break
                
            }
        }
      
    }
    
    func prepareCollectionView() {
        collectionView.dataSource = self
        print("ViewController - \(OfferCollectionViewCell.ReuseIdentifier)")
        
        let nib = UINib(nibName: OfferCollectionViewCell.NibName, bundle: .main)
        collectionView.register(UINib(nibName: OfferCollectionViewCell.NibName, bundle: nil), forCellWithReuseIdentifier: OfferCollectionViewCell.ReuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("HomeViewController - viewWillAppear")
        if let _ = userDetails {
            print("HomeViewController - userDetails NOT NIL ")
        }
        
    }
    func dateButtonClicked() {
        DispatchQueue.main.async {
            		self.collectionView.reloadData()
        }
    }
    
    
    

   

}
extension UIViewController{
    class func displaySpinner(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    class func removeSpinner(spinner: UIView){
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    //    let loadingScreen = UIViewController.displaySpinner(onView: self.view)
    //    UIViewController.removeSpinner(spinner: loadingScreen)
}
