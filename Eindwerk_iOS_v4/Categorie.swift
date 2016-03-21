//
//  Categorie.swift
//  Eindwerk_iOS_v4
//
//  Created by Andrew Haentjens on 12/03/16.
//  Copyright © 2016 ehb. All rights reserved.
//

import UIKit

class Categorie: NSObject {
    
    var CId: Int
    var CName: String
    var CHasBeacon: Bool
    var CMajor: Int
    var CMinor: Int
    var CUuid: String
    
    init(id: Int, name: String, hasBeacon: Bool, major: Int, minor: Int, uuid: String) {
        self.CId = id
        self.CName = name
        self.CHasBeacon = hasBeacon
        self.CMajor = major
        self.CMinor = minor
        self.CUuid = uuid
    }

}
