//
//  ProcedureDetailViewController.swift
//  Eindwerk_iOS_v4
//
//  Created by Andrew Haentjens on 14/03/16.
//  Copyright © 2016 ehb. All rights reserved.
//

import UIKit

class ProcedureDetailViewController: UIViewController {

    @IBOutlet weak var procedureTitle: UITextField!
    
    var value = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        procedureTitle.text = value
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        if(self.isMovingFromParentViewController()) {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
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
