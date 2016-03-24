//
//  IconenDataSource.swift
//  WetLapp
//
//  Created by Dominiek Vandeputte on 17/03/16.
//  Copyright © 2016 Dominiek Vandeputte. All rights reserved.
//

import UIKit

class IconenDataSource {
    var iconen:[Icoon]
    
    init() {
        iconen = []
        let giftig = Icoon(id: 0, icoonTeken: UIImage(named: "Iconen_giftig.png"), icoonNaam: "Giftig", icoonText: "Giftige producten kunnen bij inademing, inslikken of opname door de huid zelfs in kleine hoeveelheden een gevaar voor de gezondheid opleveren of tot de dood leiden.")
        iconen.append(giftig!)
        
        let bijtend = Icoon(id: 1, icoonTeken: UIImage(named: "Iconen_bijtend.png"), icoonNaam: "Bijtend", icoonText: "Corrosieve of bijtende producten tasten bij contact het levend weefsel aan: ze vernietigen de huid en slijmvliezen en kunnen zeer zware (brand)wonden veroorzaken. Soms zijn ze ook corrosief voor metalen.")
        iconen.append(bijtend!)
        
        let ontvlambaar = Icoon(id: 2, icoonTeken: UIImage(named: "Iconen_ontvlambaar.png"), icoonNaam: "Ontvlambaar", icoonText: "Ontvlambare producten ontbranden gemakkelijk in de aanwezigheid van een vlam, een warmtebron (zoals een heet oppervlak) of een vonk.")
        iconen.append(ontvlambaar!)
        
        let oxiderend = Icoon(id: 3, icoonTeken: UIImage(named: "Iconen_oxiderend.png"), icoonNaam: "Oxiderend", icoonText: "Oxiderende producten bevatten veel zuurstof en bevorderen zo sterk de verbranding van ontvlambare of brandbare stoffen.")
        iconen.append(oxiderend!)
        
        let ontplofbaar = Icoon(id: 4, icoonTeken: UIImage(named: "Iconen_ontplofbaar.png"), icoonNaam: "Ontplofbaar", icoonText: "Ontplofbare producten kunnen door een vlam, warmte, een schok of wrijving tot ontploffing komen. Ze kunnen ernstige verwondingen en grote materiële schade veroorzaken.")
        iconen.append(ontplofbaar!)
        
        let milieugevaarlijk = Icoon(id: 5, icoonTeken: UIImage(named: "Iconen_milieugevaarlijk.png"), icoonNaam: "Milieugevaarlijk", icoonText: "Milieugevaarlijke producten vormen op korte of lange termijn een risico voor de fauna en flora in het water en tasten de ozonlaag aan als ze in de natuur terechtkomen.")
        iconen.append(milieugevaarlijk!)
        
        let irriterend = Icoon(id: 6, icoonTeken: UIImage(named: "Iconen_irriterend.png"), icoonNaam: "Irriterend / Schadelijk", icoonText: "Irriterende producten veroorzaken bij direct, langdurig of herhaald contact jeuk, roodheid van de huid of ontstekingen. Als de dosis hoog is, kunnen ze schadelijk zijn.")
        iconen.append(irriterend!)
        
        let houder = Icoon(id: 7, icoonTeken: UIImage(named: "Iconen_houder_onder_druk.png"), icoonNaam: "Houder onder druk", icoonText: "Deze producten zijn opgeslagen in een houder onder druk. Het gaat bijvoorbeeld om flessen met zuurstof, acetyleen, koolmonoxide of kooldioxide.")
        iconen.append(houder!)
        
        let gezondheidsgevaarlijk = Icoon(id: 8, icoonTeken: UIImage(named: "Iconen_gezondheidsgevaarlijk.png"), icoonNaam: "Gezondheidsgevaarlijk", icoonText: "Deze producten zijn kankerverwekkend, brengen het erfelijk materiaal schade toe (mutageen) of hebben een nadelige invloed op de vruchtbaarheid en het ongeboren kind (reprotoxisch).")
        iconen.append(gezondheidsgevaarlijk!)
        
        let biohazard = Icoon(id: 9, icoonTeken: UIImage(named: "Icoon_biohazard.png"), icoonNaam: "Biohazard", icoonText: "Biohazard is biomedisch of besmettelijk afval zoals urine, bloed en naalden gebruikt voor vaccins. Juiste afvoer en zorg is nodig om ziekte te voorkomen. Dit afval is een gevolg van menselijke of dierlijke behandeling en bevat materialen die als besmettelijk of potentieel gevaarlijk worden beschouwd.")
        iconen.append(biohazard!)
        
        
    }
    
   /* func getIconen() -&gt; [Icoon]{
    return iconen
    }
*/
}
