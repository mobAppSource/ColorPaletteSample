//
//  TableViewController.swift
//  ColorPaletteSample
//
//  Created by Master on 6/28/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var myDicData: NSDictionary?
    var paletteSet: [[[Int]]] = []
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.readData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.paletteSet.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.paletteSet[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...

        let color = self.paletteSet[indexPath.section][indexPath.row] 
        cell.textLabel?.text = "RGB: \(color)"
        cell.textLabel?.textColor = UIColor.yellowColor()
        cell.backgroundColor = UIColor(red: CGFloat(color[0])/255, green: CGFloat(color[1])/255, blue: CGFloat(color[2])/255, alpha: 1)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TableViewController
{
    //Read .plist file contents
    func readData()
    {
        if let path = NSBundle.mainBundle().pathForResource("palettes", ofType: ".plist"){
            self.myDicData = NSDictionary(contentsOfFile: path)
        }
        
        if let dict = myDicData{
            
            
            for (_, value) in dict
            {
                if value is NSArray{
                    var colorSet: [[Int]] = []
                    var color: [Int] = []
                    for items in value as! NSArray
                    {
                        if let str = items as? String{
                            let strArr = str.componentsSeparatedByString(", ")
                            for item in strArr{
                                color.append(Int(item)!)
                            }
                        }
                        colorSet.append(color)
                        color.removeAll(keepCapacity: false)
                    }
                    paletteSet.append(colorSet)
                    colorSet.removeAll(keepCapacity: false)
                }
            }
        }
    }
    func switchKey<T, U>(inout myDict: [T:U], fromKey: T, toKey: T) {
        if let entry = myDict.removeValueForKey(fromKey) {
            myDict[toKey] = entry
        }
    }
}