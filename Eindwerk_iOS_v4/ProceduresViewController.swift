//
//  ProceduresViewController.swift
//  Eindwerk_iOS_v4
//
//  Created by Andrew Haentjens on 12/03/16.
//  Copyright © 2016 ehb. All rights reserved.
//

import UIKit

class ProceduresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    

    // UI elementen
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var proceduresTableView: UITableView!
    @IBOutlet weak var loadIcon: UIActivityIndicatorView!
    
    // Eigen variabelen voor JsonParsing
    var lijstProcedures = [Procedure]()
    var lijstCategories = [Categorie]()
    var lijstSections = [Section]()
    var valueToPass = String()
    
    // Eigen variabelen voor Searching
    var filteredProcedures = [Procedure]()
    var searchActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        proceduresTableView.delegate = self
        proceduresTableView.dataSource = self
        searchBar.delegate = self
        
        // een queue voor de taken aanmaken, zodat alles wordt ingeladen en er geen foutmeldingen komen omdat de data nog niet klaar is
        let queue = TaskQueue()
        
        queue.tasks += { result, next in
            
            self.loadIcon.hidden = false
            let urlProcedures = NSURL(string: NamingSpace.urlAlleProcedures)
            
            let taskProcedures = NSURLSession.sharedSession().dataTaskWithURL(urlProcedures!, completionHandler: {(data, response, error) in
                let jsonProcedures = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                
                if let data = jsonProcedures.dataUsingEncoding(NSUTF8StringEncoding) {
                    let encJson = JSON(data: data)
                    
                    if (encJson != nil) {
                    
                        // Loopen over elke procedure en categorie
                        self.lijstProcedures = self.jsonToProcedureList(encJson)
                    
                        dispatch_async(dispatch_get_main_queue(), {
                            next(nil)
                        })
                    } else {
                        let alertController = UIAlertController(title: "Server error", message: "No server data found! Try again!", preferredStyle: .Alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: { action in
                            self.viewDidLoad()
                        })
                        alertController.addAction(defaultAction)
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                }
                
            })
            
            taskProcedures.resume()
        }
        
        queue.tasks += { result, next in
            let urlCategories = NSURL(string: NamingSpace.urlAlleCategories)
            
            let taskCategories = NSURLSession.sharedSession().dataTaskWithURL(urlCategories!, completionHandler: {(data, response, error) in
                let jsonCategories = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                
                if let data = jsonCategories.dataUsingEncoding(NSUTF8StringEncoding) {
                    let encJson = JSON(data: data)
                    
                    if (encJson != nil) {
                    
                        self.lijstCategories = self.jsonToCategoryList(encJson)
                    
                        dispatch_async(dispatch_get_main_queue(), {
                            next(nil)
                        })
                        
                    } else {
                        let alertController = UIAlertController(title: "Server error", message: "No server data found! Try again!", preferredStyle: .Alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: { action in
                            self.viewDidLoad()
                        })
                        alertController.addAction(defaultAction)
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                }
            })
        
            taskCategories.resume()
        }
        
        queue.tasks += {
            self.lijstSections = self.makeSections()
        }
        
        queue.run {
            self.loadIcon.hidden = true
            self.proceduresTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Eigen methoden JSON parsing
    func makeSections() -> ([Section]) {
        var listSections = [Section]()
        
        for categorie in lijstCategories {
            var tempArray = [String]()
            
            for procedure in lijstProcedures {
                if(categorie.CName == procedure.PCategorie) {
                    
                    tempArray.append(procedure.PNaam)
                }
            }
            
            let section = Section(header: categorie.CName, items: tempArray)
            listSections.append(section)
        }
        return listSections
    }
    
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
    
    private func jsonToCategoryList(json: JSON) -> [Categorie] {
        var categories = [Categorie]()
        
        // loopen over elke categorie
        for item in json.arrayValue {
            
            let categorie: Categorie
            
            // data in het categorie object steken
            if (item["CHasBeacon"].boolValue == false) {
                categorie = Categorie(id: item["CId"].intValue, name: item["CName"].stringValue, hasBeacon: item["CHasBeacon"].boolValue, major: 0, minor: 0, uuid: "")
            } else {
                categorie = Categorie(id: item["CId"].intValue, name: item["CName"].stringValue, hasBeacon: item["CHasBeacon"].boolValue, major: item["CMajor"].intValue, minor: item["CMinor"].intValue, uuid: item["CUuid"].stringValue)
            }
            
            categories.append(categorie)
        }
        
        return categories
    }

    // MARK: - Eigen methoden Search bar
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
        self.proceduresTableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredProcedures = lijstProcedures.filter {
            return $0.PNaam.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        }
        
        self.proceduresTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchActive = false
        searchBar.resignFirstResponder()
        proceduresTableView.reloadData()
    }
   
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(searchActive) {
            return 1
        }
        
        return lijstSections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            return filteredProcedures.count
        }
        
        return lijstSections[section].items.count
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(searchActive) {
            return nil
        }
        
        return lijstSections[section].header
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 0.843, green: 0.843, blue: 0.843, alpha: 1)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("procedureCell", forIndexPath: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1)
        if(searchActive) {
            cell.textLabel?.text = filteredProcedures[indexPath.row].PNaam
            return cell
        }
        
        cell.textLabel?.text = lijstSections[indexPath.section].items[indexPath.row]
        
        return cell
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "toProcedureDetail") {
            
            let destination = (segue.destinationViewController as! ProcedureDetailViewController)
            
            if(searchActive) {
                let selectedRow = proceduresTableView.indexPathForSelectedRow?.row
                destination.value = filteredProcedures[selectedRow!].PNaam
                
            } else {
                
                let selectedSection = proceduresTableView.indexPathForSelectedRow?.section
                let selectedRow = proceduresTableView.indexPathForSelectedRow!.row
                destination.value = lijstSections[selectedSection!].items[selectedRow]
            }
        }
    }

}
