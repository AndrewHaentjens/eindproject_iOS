

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    var steps = [StapItem]()
    var procedureId: Int = 0
    private var pageViewController: UIPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControl()
    }
    
    private func createPageViewController() {
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("StepController") as! UIPageViewController
        pageController.dataSource = self
        
        if steps.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! StepItemController
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! StepItemController
        if itemController.itemIndex+1 < steps.count {
            return getItemController(itemController.itemIndex+1)
        }
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> StepItemController? {
        
        if itemIndex < steps.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! StepItemController
            pageItemController.itemIndex = itemIndex
            pageItemController.itemTitle = steps[itemIndex].STitel
            let contentStr: String = steps[itemIndex].SHtmlcontent
            let attrStr = try! NSAttributedString(data: contentStr.dataUsingEncoding(NSUnicodeStringEncoding)!,
                options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil);
            pageItemController.itemContent = attrStr.string
            // let data: NSData? = steps[itemIndex].SImage?.ImageData.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            if let imageData = steps[itemIndex].SImage?.ImageData {
                let data = NSData(base64EncodedString: imageData, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                pageItemController.imageName = data
            }
            if itemIndex < 6 {
                pageItemController.itemStepIndex = itemIndex+1
            }
           
            // pageItemController.imageName = steps[itemIndex].SImage?.ImageData
            
            return pageItemController
        }
        return nil
    }


    // MARK: - Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return steps.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            RestApiManager.sharedInstance.getRandomUser(self.procedureId) { json in
                //let jsonObject = try NSJSONSerialization.JSONObjectWithData(json, options: .AllowFragments)
                //let json = JSONValue(json)
                //print(json)
                
                //            if let data = json.dataUsingEncoding(NSUTF8StringEncoding) {
                //                let json = JSON(data: data)
                //
                //                for item in json["people"].arrayValue {
                //                    print(item["firstName"].stringValue)
                //                }
                //            }
                for (key: String, subJson: JSON) in json {
                    let step: StapItem = StapItem(title: "", htmlcontent: "", vorige: 0, stapNr: 0, id: 0, wachtijd: 0)
                    if let sTitel = JSON["STitel"].string {
                        step.STitel = sTitel
                    }
                    if let sHtmlcontent = JSON["SHtmlcontent"].string {
                        step.SHtmlcontent = sHtmlcontent
                    }
                    if let sVorigeStapId = JSON["SVorigeStapId"].int {
                        step.SVorigeStapId = sVorigeStapId
                    }
                    if let sStapnr = JSON["SStapnr"].int {
                        step.SStapnr = sStapnr
                    }
                    if let sId = JSON["SId"].int {
                        step.SId = sId
                    }
                    if let sWachtijd = JSON["SWachtijd"].int {
                        step.SWachtijd = sWachtijd
                    }
                    if let afbeelding = JSON["SAfbeeldingId"].dictionary {
                        step.SImage = Image()
                        for (key: String, subJson: JSON) in afbeelding {
                            print(JSON["AImagedata"])
                            if let aId = JSON["AId"].int {
                                step.SImage!.Id = aId
                            }
                            if let aName = JSON["aName"].string {
                                step.SImage!.Name = aName
                            }
                            if let AImagedata = JSON["AImagedata"].string {
                                step.SImage!.ImageData = AImagedata
                                print(AImagedata)
                            }
                        }
                        var test = afbeelding["AImagedata"]?.stringValue
                        step.SImage!.ImageData = test!
                    }
                    print(step)
                    self.steps.append(step)
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.createPageViewController()
                    self.setupPageControl()
                }
            }


        }
        
    }
    
}

