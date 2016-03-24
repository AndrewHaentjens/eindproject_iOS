//
//  StepItemController.swift
//  OpenFabLabPaging
//
//  Created by mobapp07 on 10/03/16.
//  Copyright © 2016 mobapp07. All rights reserved.
//

import UIKit

class StepItemController: UIViewController {

    // MARK: - Variables
    var itemIndex: Int = 0
    var itemTitle: String = "Title" {
        didSet {
            if let titleLabel = titleLabel {
                titleLabel.text! = itemTitle
            }
        }
    }
    var itemContent: String = "Content" {
        didSet {
            if let contentLabel = contentLabel {
                contentLabel.text! = itemContent
            }
        }
    }
    var itemStepIndex: Int = 1 {
        didSet {
            if let indexImageView = indexImageView {
                indexImageView.image = UIImage(named: String(itemStepIndex))
            }
        }
    }
    var imageName: NSData? {
        didSet {
            if let imageView = stepImageView, imageName = imageName {
                imageView.image = UIImage(data: imageName)
            }
        }
    }


    
    //@IBOutlet var contentImageView: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var contentLabel: UILabel?
    @IBOutlet var stepImageView: UIImageView?
    @IBOutlet var indexImageView: UIImageView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageName = imageName {
            stepImageView!.image = UIImage(data: imageName)
        }
        indexImageView.image = UIImage(named: String(itemStepIndex))
        titleLabel!.text = itemTitle
        contentLabel!.text = itemContent
    }

}
