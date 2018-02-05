//
//  TodayViewController.swift
//  DFP
//
//  Created by Chandrachudh on 05/02/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var lblCity: UILabel!
    private let maxHeight:CGFloat = 130
    
    @IBOutlet weak var lblpetrolPrice: UILabel!
    @IBOutlet weak var lblDieselPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        lblCity.text = DFPTodayWidgetManager.sharedInstance.getDefaultCity()
        lblpetrolPrice.text = "-"
        lblDieselPrice.text = "-"
        
        fetchPetrolData()
        fetchDieselData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func fetchPetrolData() {
        
        DFPDataCenter.makeGETRequest(connectingURL: getURLFor(city: DFPTodayWidgetManager.sharedInstance.getDefaultCity(), fuelType: "petrol")) { (reponseDict, errorMessage) in
            DispatchQueue.main.async {
                self.lblpetrolPrice.animateFade(duration: 1.5)
                if let errorMessage = errorMessage {
                    print(errorMessage)
                    self.lblpetrolPrice.text = "-NA-"
                }
                else {
                    self.lblpetrolPrice.setPriceToLabel(price: reponseDict?["petrol"] as! Double)
                }
            }
            
        }
    }
    
    func fetchDieselData() {
        DFPDataCenter.makeGETRequest(connectingURL: getURLFor(city: DFPTodayWidgetManager.sharedInstance.getDefaultCity(), fuelType: "diesel")) { (reponseDict, errorMessage) in
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
