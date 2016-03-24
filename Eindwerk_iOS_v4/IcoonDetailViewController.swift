//
//  IcoonDetailViewController.swift
//  WetLapp
//
//  Created by Dominiek Vandeputte on 15/03/16.
//  Copyright © 2016 Dominiek Vandeputte. All rights reserved.
//

import UIKit

class IcoonDetailViewController: UIViewController {

    @IBOutlet weak var icoonView: UIImageView!
    @IBOutlet weak var IcoonNaamLabel: UILabel!
    @IBOutlet weak var IcoonText: UITextView!
    
    let iconenDOA = IconenDataSource()
    var recievedIdBtn = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for item in iconenDOA.iconen {
            if item.id == recievedIdBtn {
                icoonView.image = item.icoonTeken
                IcoonNaamLabel.text = item.icoonNaam
                IcoonText.text = item.icoonText
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sluit_detail(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {});
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
