//
//  CCBookListTableViewController.swift
//  CiChang
//
//  Created by yangyouyong on 15/7/8.
//  Copyright © 2015年 yangyouyong. All rights reserved.
//

import UIKit
import Alamofire
class CCBookListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://beta.cichang.hjapi.com/v1/book/?pageIndex=0&pageSize=10&sort=popular")
//        self.requestData()
//        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: url), queue: NSOperationQueue.mainQueue()){
//            (response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
////            if (let responseData = data){
//                let dataDic:NSDictionary =  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSDictionary
//                print("dataDic is \(dataDic)")
////            }
//        }
        
        //NSURL("http://beta.cichang.hjapi.com/v1/book/?pageIndex=0&pageSize=10&sort=popular")
//        NSURLSessionTask *task = 
        // loadDataFromNetwork

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

//    internal func requestData() {
//        let urlStr = "http://cichang.hjapi.com/v2/book/?pageIndex=0&pageSize=100&sort=popular"
//        Alamofire.request(.GET, URLString: urlStr).response {
//            (_, _, data, error) in
//            if data != nil {
//                if (JSON(data: data as! NSData) != nil){
//                    let json = JSON(data: data as! NSData)
//                    let items = json["data"]["items"]
//                    for value in items{
//                        let (_ , dict) = value as (String,JSON)
//                        let book = CCBook().initWithDict(dict.object as! [String : AnyObject])
//                        print(dict.object)
//                        print("value is \(book)")
//                        self.bookArray.append(book)
//                    }
//                    print("bookArray")
//                    print(self.bookArray)
//                    self.tableView!.reloadData()
//                }
//            }else{
//                print("noData,\(error)")
//            }
//            
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        // Return NO if you do not want the item to be re-orderable.
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
