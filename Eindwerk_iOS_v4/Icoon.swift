//
//  Icoon.swift
//  WetLapp
//
//  Created by Dominiek Vandeputte on 15/03/16.
//  Copyright © 2016 Dominiek Vandeputte. All rights reserved.
//

import UIKit

class Icoon {
    
    var id: Int
   
    var icoonTeken: UIImage?
    
    var icoonNaam: String
    
    var icoonText: String
    


    init?(id: Int, icoonTeken: UIImage?, icoonNaam: String, icoonText: String){
    
    self.id = id
    self.icoonTeken = icoonTeken
    self.icoonNaam = icoonNaam
    self.icoonText = icoonText
    
    if icoonNaam.isEmpty{
    return nil
    }
}
}