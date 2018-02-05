//
//  DFPMainMenu.swift
//  DailyFuelPrice
//
//  Created by Chandrachudh on 05/02/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class DFPMainMenu: UIViewController {

    @IBOutlet weak var citiesTableView: UITableView!
    
    
    var allCities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationbar()
        setupTableView()
        fetchCities()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        citiesTableView.animateFade(duration: 0.5)
        citiesTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DFPMainMenu {
    func setupNavigationbar() {
        title = "All Cities"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
        }
        
        let refreshButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        refreshButton.setTitle("Refresh", for: .normal)
        refreshButton.addTarget(self, action: #selector(fetchCities), for: .touchUpInside)
        
        let barButton = UIBarButtonItem.init(customView: refreshButton)
        navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    func setupTableView() {
        let nib = UINib.init(nibName: DFPCitiesCell.reuseIdentifier(), bundle: nil)
        citiesTableView.register(nib, forCellReuseIdentifier: DFPCitiesCell.reuseIdentifier())
        
        citiesTableView.tableFooterView = UIView()
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        citiesTableView.rowHeight = 50.0
        citiesTableView.reloadData()
    }
    
    @objc func fetchCities() {
        
        
        DFPDataCenter.makeGETRequest(connectingURL: GET_CITIES_URL) { (responseDict, errorMessage) in
            if let errorMessage = errorMessage {
                self.showAlert(message: errorMessage, cancelTitle: "OK")
            }
            else {
                DispatchQueue.main.async {
                    self.allCities = responseDict!["cities"] as! [String]
                    self.allCities = self.allCities.sorted()
                    self.citiesTableView.reloadData()
                }
            }
        }
    }
}

extension DFPMainMenu:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DFPCitiesCell.reuseIdentifier(), for: indexPath) as! DFPCitiesCell
        cell.prepareView()
        cell.lblSelected.isHidden = true
        if DFPTodayWidgetManager.sharedInstance.getDefaultCity() == self.allCities[indexPath.row] {
            cell.lblSelected.isHidden = false
        }
        cell.lblCity.text = self.allCities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextController = DFPCityFuelPrices()
        nextController.city = allCities[indexPath.row]
        navigationController?.pushViewController(nextController, animated: true)
    }
}
