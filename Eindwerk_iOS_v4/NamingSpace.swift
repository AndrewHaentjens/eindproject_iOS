//
//  NamingContract.swift
//  Eindwerk_iOS_v4
//
//  Created by Andrew Haentjens on 13/03/16.
//  Copyright © 2016 ehb. All rights reserved.
//

import UIKit

// Klasse wordt gebruikt om de Json aan te spreken
class NamingSpace: NSObject {
    
    // REST API calls
    static let urlAlleProcedures = "http://193.190.238.49:8080/wetlabapi/webapi/procedures"
    static let urlAlleCategories = "http://193.190.238.49:8080/wetlabapi/webapi/categories"
    
    // Procedure namespaces
    static let PId = "PId"
    static let PName = "PNaam"
    static let PCategorie = "PCategorie"
    static let PYoutubeUrl = "PYoutubeUrl"
    
    // Categorien namespaces
    static let CId = "CId"
    static let CName = "CName"
    static let CHasBeacon = "CHasBeacon"
    static let CMajor = "CMajor"
    static let CMinor = "CMinor"
    static let CUuid = "CUuid"

}
