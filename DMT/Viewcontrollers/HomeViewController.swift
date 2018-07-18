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
    var userDetails: UserDetails? // aceasta instanta este creata atunci cand se va face tranzitia din LoginVC in HomeVC
    var clickedOfferDetailFromServer: ClickedOfferDetail?
    var offerDetails: [OffersDetail] = []
    var offerNumber: Int?
    let reuseIdentifier = "cell"
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerDetails.count // il gaseste ca nil
    }
// DC NU MERGE ASA?
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = Bundle.main.loadNibNamed("OffersCollectionViewCell", owner: self, options: nil)?.first as! OffersCollectionViewCell
//
//        cell.headerLabel.text = self.offerDetails[indexPath.item].titluOferta
//        cell.locationLabel?.text = self.offerDetails[indexPath.item].numeLocatie
//        cell.priceLabel.text = self.offerDetails[indexPath.item].pretOferta
//        cell.jobLabel.text = self.offerDetails[indexPath.item].specializare
//
//
//        return cell
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OffersCollectionViewCell.ReuseIdentifier, for: indexPath) as! OffersCollectionViewCell
        
        cell.load()
        cell.headerLabel.text = self.offerDetails[indexPath.item].titluOferta
        cell.locationLabel?.text = self.offerDetails[indexPath.item].numeLocatie
        cell.priceLabel.text = self.offerDetails[indexPath.item].pretOferta
        cell.jobLabel.text = self.offerDetails[indexPath.item].specializare
        cell.locationLabel?.textColor = UIColor(red: 0.5, green: 0.44, blue: 0.87, alpha: 1)
        cell.priceLabel.textColor = UIColor.white
        cell.jobLabel.textColor = UIColor(red: 0.5, green: 0.44, blue: 0.87, alpha: 1)

        
        
        return cell
        
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("celula selectata -  \(indexPath.item)!")
        var params = Dictionary<String, String>()
        params["request"] = "1"
        params["id_user"] = userDetails?.idUser
        params["id_oferta"] = self.offerDetails[indexPath.item].idOferta
        Services.getOfferDetails(params: params) { [weak self] result in
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
                            self?.clickedOfferDetailFromServer = resultFromJSON
                            self?.performSegue(withIdentifier: "showDetail", sender: nil)
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

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 80)

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
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        let secondTab = self.tabBarController?.viewControllers![1] as! ProfileViewController
        secondTab.userDetails = userDetails
        prepareCollectionView()
        
        
        
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
        print("ViewController - \(OffersCollectionViewCell.ReuseIdentifier)")
        
        let nib = UINib(nibName: OffersCollectionViewCell.NibName, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: OffersCollectionViewCell.ReuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("HomeViewController - viewWillAppear")
        if let _ = userDetails {
            print("HomeViewController - userDetails NOT NIL ")
        }
        
    }
    func dateButtonClicked() {
        if offerNumber != nil {
            self.noOffersLabel.text = ""
        } else {
            self.noOffersLabel.text = "No Offers"
        }
        print("dateClicked")
        DispatchQueue.main.async {
            		self.collectionView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let segueIdentifier = segue.identifier {
            if segueIdentifier == "showDetail" {
               
                let vc = segue.destination as! ClickedOfferDetailViewController
                vc.clickedOfferDetailFromServer = clickedOfferDetailFromServer
                        
                        
                
                    
                
    
            }
            
        }
        segue.destination.navigationController?.setNavigationBarHidden(true, animated: true)
        
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
