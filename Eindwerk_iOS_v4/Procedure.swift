//
//  Procedure.swift
//  Eindwerk_iOS_v4
//
//  Created by Andrew Haentjens on 12/03/16.
//  Copyright © 2016 ehb. All rights reserved.
//

import UIKit

class Procedure: NSObject {
    
    var PId: Int
    var PNaam: String
    var PCategorie: String
    var PYoutubeUrl: String
    
    init(id: Int, naam: String, categorie: String, youtubeUrl: String) {
        self.PId = id
        self.PNaam = naam
        self.PCategorie = categorie
        self.PYoutubeUrl = youtubeUrl
    }

}
