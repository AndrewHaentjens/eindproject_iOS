//
//  StapItem.swift
//  OpenFabLabPaging
//
//  Created by mobapp07 on 10/03/16.
//  Copyright © 2016 mobapp07. All rights reserved.
//

import Foundation

class StapItem {
    var STitel: String
    var SHtmlcontent: String
    var SVorigeStapId: Int
    var SStapnr: Int
    var SId: Int
    var SWachtijd: Int
    var SImage: Image?

    init(title: String, htmlcontent: String, vorige: Int, stapNr: Int, id: Int, wachtijd: Int) {
        self.STitel = title
        self.SHtmlcontent = htmlcontent
        self.SVorigeStapId = vorige
        self.SStapnr = stapNr
        self.SId = id
        self.SWachtijd = wachtijd
    }

}

struct Image {
    var Name: String = ""
    var Id: Int = 0
    var ImageData: String = ""
}