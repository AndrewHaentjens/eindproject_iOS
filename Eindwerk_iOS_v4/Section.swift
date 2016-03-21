//
//  Section.swift
//  Eindwerk_iOS_v4
//
//  Created by Andrew Haentjens on 13/03/16.
//  Copyright © 2016 ehb. All rights reserved.
//

import UIKit

class Section: NSObject {
    
    var header: String
    var items: [String]

    init(header: String, items: [String]) {
        self.header = header
        self.items = items
    }
}
