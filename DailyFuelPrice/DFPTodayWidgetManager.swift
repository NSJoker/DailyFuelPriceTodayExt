//
//  DFPTodayWidgetManager.swift
//  DailyFuelPrice
//
//  Created by Chandrachudh on 05/02/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class DFPTodayWidgetManager: NSObject {

    private let groupUserDefaults = UserDefaults.init(suiteName: APP_GROUP_ID)
    private var defaultCity = ""
    
    class var sharedInstance: DFPTodayWidgetManager {
        struct Static {
            static let instance: DFPTodayWidgetManager = DFPTodayWidgetManager()
        }
        return Static.instance
    }
    
    func setDefaultTofayWidgetCutyTO(city:String) {
        defaultCity = city
        groupUserDefaults?.set(city, forKey: EXTENSION_DATA_PATH)
    }
    
    func getDefaultCity()->String {
        if defaultCity.count > 0 {
            return defaultCity
        }
        guard let city = groupUserDefaults?.object(forKey: EXTENSION_DATA_PATH) else {
            return ""
        }
        defaultCity = city as! String
        return city as! String
    }
}
