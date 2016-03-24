//
//  IconenViewController.swift
//  WetLapp
//
//  Created by Dominiek Vandeputte on 11/03/16.
//  Copyright © 2016 Dominiek Vandeputte. All rights reserved.
//

import UIKit

class IconenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tappedButton(sender: UIButton) {
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "goToIconDetail") {
            let iconDetailViewController = segue.destinationViewController as! IcoonDetailViewController
            let idBtnPressed = sender!.tag
            iconDetailViewController.recievedIdBtn = idBtnPressed
        }
        
    }

}
