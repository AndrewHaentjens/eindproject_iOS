//
//  QRCodeController.swift
//  Eindwerk_iOS_v4
//
//  Created by Andrew Haentjens on 11/03/16.
//  Copyright © 2016 ehb. All rights reserved.
//

import UIKit
import AVFoundation

// tutorial: theappguruz.com
class QRCodeController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var infoText: UITextView!
    
    var objCaptureSession = AVCaptureSession()
    var objCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    var vwQRCode = UIView()
    var lijstProcedures = [Procedure]()
    var idToCompare = Int()
    var idToPass = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getProceduresFromJson()
        self.configureVideoCapture()
        self.addVideoPreviewLayer()
        self.initializeQRView()
    }
    
    // De procedures binnentrekken van vanuit de JSON
    func getProceduresFromJson() {
        let urlProcedures = NSURL(string: NamingSpace.urlAlleProcedures)
        
        let taskProcedures = NSURLSession.sharedSession().dataTaskWithURL(urlProcedures!, completionHandler: {(data, response, error) in
            let jsonProcedures = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            
            if let data = jsonProcedures.dataUsingEncoding(NSUTF8StringEncoding) {
                let encJson = JSON(data: data)
                
                // Loopen over elke procedure en categorie
                self.lijstProcedures = self.jsonToProcedureList(encJson)
            }
        })
        
        taskProcedures.resume()
    }
    
    // Een lijst van procedures aanmaken op basis van de JSON die binnenkomt
    private func jsonToProcedureList(json: JSON) -> [Procedure] {
        var procedures = [Procedure]()
        
        // loopen over elke procedure
        for item in json.arrayValue {
            let procedure: Procedure
            
            // data in het procedure object steken
            procedure = Procedure(id: item["PId"].intValue, naam: item["PNaam"].stringValue, categorie: item["PCategorie"]["CName"].description, youtubeUrl: item["PYoutubeUrl"].stringValue)
            
            // het procedure object steken in de array van procedures
            procedures.append(procedure)
        }
        
        return procedures
    }
    
    // Kijken of er een camera aanwezig is, waarmee we de code kunnen scannen, zoniet geven we een foutmelding
    func configureVideoCapture() {
        let objCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error:NSError?
        let objCaptureDeviceInput: AnyObject!
        
        do {
            objCaptureDeviceInput = try AVCaptureDeviceInput(device: objCaptureDevice) as AVCaptureDeviceInput
        } catch let error1 as NSError {
            error = error1
            objCaptureDeviceInput = nil
        }
        
        if (error != nil) {
            let alertController = UIAlertController(title: "Device error", message: "Device not supported for this application", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: { action in
                    if let navigationController = self.navigationController {
                        navigationController.popViewControllerAnimated(true)
                    }
                })
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        objCaptureSession = AVCaptureSession()
        objCaptureSession.addInput(objCaptureDeviceInput as! AVCaptureInput)
        
        let objCaptureMetadataOutput = AVCaptureMetadataOutput()
        
        objCaptureSession.addOutput(objCaptureMetadataOutput)
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    }
    
    // de video layer aanmaken
    func addVideoPreviewLayer() {
        objCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: objCaptureSession)
        objCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        objCaptureVideoPreviewLayer.frame = view.layer.bounds
        
        self.view.layer.addSublayer(objCaptureVideoPreviewLayer)
        objCaptureSession.startRunning()
    }
    
    // de view initialiseren
    func initializeQRView() {
        vwQRCode = UIView()
        vwQRCode.layer.borderColor = UIColor.redColor().CGColor
        vwQRCode.layer.borderWidth = 5
        
        self.view.addSubview(vwQRCode)
        self.view.bringSubviewToFront(infoText)
    }
    
    // alles capturen vanuit de camera
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        if(metadataObjects == nil || metadataObjects.count == 0) {
            vwQRCode.frame = CGRectZero
            return
        }
        
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if (objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode){
            let objBarCode = objCaptureVideoPreviewLayer.transformedMetadataObjectForMetadataObject(objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            vwQRCode.frame = objBarCode.bounds
            
            if(Int(objMetadataMachineReadableCodeObject.stringValue) != nil){
                idToCompare = Int(objMetadataMachineReadableCodeObject.stringValue)!
                
                for procedure in lijstProcedures {
                    if(procedure.PId == idToCompare) {
                        self.idToPass = procedure.PId
                    }
                }
                performSegueWithIdentifier("QRToProcedureDetail", sender: self)
                objCaptureSession.stopRunning()
            } else {
                let alertController = UIAlertController(title: "ID error", message: "QR-Code is niet in de database gevonden!", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: { action in
                    if let navigationController = self.navigationController {
                        navigationController.popViewControllerAnimated(true)
                    }
                })
                alertController.addAction(defaultAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                objCaptureSession.stopRunning()
            }
        }
    }
    
    // de procedure doorgeven aan het volgende scherm
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "QRToProcedureDetail") {
            let destination = (segue.destinationViewController as! ViewController)
            destination.procedureId = self.idToPass
        }
    }
}
