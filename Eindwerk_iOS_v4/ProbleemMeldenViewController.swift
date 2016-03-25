//
//  ProbleemMeldenViewController.swift
//  WetLapp
//
//  Created by Dominiek Vandeputte on 11/03/16.
//  Copyright © 2016 Dominiek Vandeputte. All rights reserved.
//

import UIKit
import MessageUI

class ProbleemMeldenViewController: UIViewController, MFMailComposeViewControllerDelegate {

    //let validator = Validator()
    
    @IBOutlet weak var tfOnderwerp: UITextField!
    @IBOutlet weak var tvBericht: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    
    @IBAction func btn_verstuur(sender: AnyObject) {
        
        var BerichtTekst = tvBericht
        
        var Onderwerp = "Melding van WetLab: "
        Onderwerp += tfOnderwerp.text!
        
        var Ontvanger = ["dominiekvandeputte@me.com"]
        
        
        
        var mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(Onderwerp)
        mc.setMessageBody(BerichtTekst.text, isHTML: false)
        mc.setToRecipients(Ontvanger)
        
        self.presentViewController(mc, animated: true, completion: nil)
        
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue{
            
        case MFMailComposeResultCancelled.rawValue:
            NSLog("Mail Cancelled")
        case MFMailComposeResultSaved.rawValue:
            NSLog("Mail opgeslaan")
        case MFMailComposeResultSent.rawValue:
            NSLog("Mail verzonden")
        case MFMailComposeResultFailed.rawValue:
            NSLog("Mail mislukt %@", [error!.localizedDescription])
        default:
            break
            
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
   
}
