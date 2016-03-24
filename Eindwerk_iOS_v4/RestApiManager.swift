//
//  RestApiManager.swift
//  OpenFabLabPaging
//
//  Created by mobapp07 on 09/03/16.
//  Copyright © 2016 mobapp07. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    let baseURL = "http://193.190.238.49:8080/wetlabapi/webapi/stappen/procedure/"
    
    func getRandomUser(procedureId: Int, onCompletion: (JSON) -> Void) {
        let route = String(baseURL+String(procedureId))
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
//        let postEndpoint: String = path
//        let url = NSURL(string: postEndpoint)
//        let request = NSURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        
//        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
//        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task.resume()
    }
}
