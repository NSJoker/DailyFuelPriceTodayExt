//
//  DFPDataCenter.swift
//  DailyFuelPrice
//
//  Created by Chandrachudh on 05/02/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

typealias DFPReturnBlock = ([String:Any]?, String?) -> Void

class DFPDataCenter: NSObject {

    class func makeGETRequest(connectingURL:String, returnBlock:@escaping DFPReturnBlock) -> Void {
        let request = NSMutableURLRequest(url: NSURL(string:connectingURL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                returnBlock(nil, error?.localizedDescription)
            } else {
                do {
                    let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                    if let response = resultsDictionary {
                        returnBlock(response, nil)
                    }
                    else {
                        returnBlock(nil, "Something went wrong. Please try again.")
                    }
                    
                } catch _ {
                    returnBlock(nil, "Something went wrong. Please try again.")
                    return
                }
            }
        })
        dataTask.resume()
    }
}
