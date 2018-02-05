//
//  DFPCityFuelPrices.swift
//  DailyFuelPrice
//
//  Created by Chandrachudh on 05/02/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class DFPCityFuelPrices: UIViewController {

    var city = ""
    
    @IBOutlet weak var selectionBaseView: UIView!
   
    @IBOutlet weak var petrolBaseView: UIView!
    @IBOutlet weak var dieselBaseView: UIView!
    
    @IBOutlet weak var lblPetrolPrice: UILabel!
    @IBOutlet weak var lblDieselPrice: UILabel!
    
    @IBOutlet weak var petrolOtherInfoView: UIView!
    @IBOutlet weak var dieselOtherInfoView: UIView!
    
    @IBOutlet weak var lblSetup: UILabel!
    @IBOutlet weak var btnDefaultSelection: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = city
        
        prepareView()
        fetchPetrolData()
        fetchDieselData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didChangeSwitchState(_ sender: Any) {
        DFPTodayWidgetManager.sharedInstance.setDefaultTofayWidgetCutyTO(city: city)
        lblSetup.text = "Today widget will show fuel prices from " + city
        btnDefaultSelection.isUserInteractionEnabled = false
    }
}

extension DFPCityFuelPrices {
    func prepareView() {
        selectionBaseView.layer.cornerRadius = 4.0
        selectionBaseView.addShadowWith(shadowPath: UIBezierPath.init(roundedRect: CGRect(x:0, y:0, width:SCREEN_WIDTH-40, height:40), cornerRadius: 4.0).cgPath, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.5, shadowRadius: 2.0, shadowOffset: CGSize.zero)
        
        view.backgroundColor = UI_APP_THEME_GREEN_COLOR
        
        self.lblPetrolPrice.text = "-"
        self.lblDieselPrice.text = "-"
        
        lblSetup.text = "Show fuel prices of " + city + " in Today Widget."
        if DFPTodayWidgetManager.sharedInstance.getDefaultCity() == city {
            lblSetup.text = "Today widget will show fuel prices from " + city
            btnDefaultSelection.isUserInteractionEnabled = false
        }
    }
    
    func fetchPetrolData() {
        
        DFPDataCenter.makeGETRequest(connectingURL: getURLFor(city: city, fuelType: "petrol")) { (reponseDict, errorMessage) in
            DispatchQueue.main.async {
                self.lblPetrolPrice.animateFade(duration: 1.5)
                if let errorMessage = errorMessage {
                    print(errorMessage)
                    self.lblPetrolPrice.text = "-NA-"
                }
                else {
                    self.lblPetrolPrice.setPriceToLabel(price: reponseDict?["petrol"] as! Double)
                }
            }
            
        }
    }
    
    func fetchDieselData() {
        DFPDataCenter.makeGETRequest(connectingURL: getURLFor(city: city, fuelType: "diesel")) { (reponseDict, errorMessage) in
            DispatchQueue.main.async {
                self.lblDieselPrice.animateFade(duration: 1.5)
                if let errorMessage = errorMessage {
                    print(errorMessage)
                    self.lblDieselPrice.text = "-NA-"
                }
                else {
                    self.lblDieselPrice.setPriceToLabel(price: reponseDict?["diesel"] as! Double)
                }
            }
        }
    }
    
    
}
