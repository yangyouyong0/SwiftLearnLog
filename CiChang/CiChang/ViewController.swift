//
//  ViewController.swift
//  CiChang
//
//  Created by yangyouyong on 15/7/8.
//  Copyright © 2015年 yangyouyong. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    var bookArray = Array<CCBook>()
    var tableView:UITableView?
    // tableView
//    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setupView()
        self.requestData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func setupView() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, CGRectGetHeight(self.view.bounds), CGRectGetHeight(self.view.bounds)), style: .Plain)
        self.view.addSubview(self.tableView!)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "bookCell")
    }
    
   internal func requestData() {
        let urlStr = "http://cichang.hjapi.com/v2/book/?pageIndex=0&pageSize=100&sort=popular"
//        let url = NSURL(string: urlStr)
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
//            (data, response, error) in
//            if data != nil {
//                do {
//                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
//                    print("jsonData \(jsonData)")
//                    
//                } catch {
//                    // report error
//                    print("noData,\(error)")
//                }//
//            }else{
//                print("noData,\(error)")
//            }
//        }
//        task!.resume()
//                do {
//                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
//                    print("jsonData \(jsonData)")
//                } catch {
//                    // report error
//                    print("noData,\(error)")
//                }//
    Alamofire.request(.GET, URLString: urlStr).response {
        (_, _, data, error) in
        if data != nil {
                if (JSON(data: data as! NSData) != nil){
                    let json = JSON(data: data as! NSData)
                    let items = json["data"]["items"]
                    for value in items{
                        let (_ , dict) = value as (String,JSON)
                        let book = CCBook().initWithDict(dict.object as! [String : AnyObject])
                        print(dict.object)
                        print("value is \(book)")
                        self.bookArray.append(book)
                    }
                    print("bookArray")
                    print(self.bookArray)
                    self.tableView!.reloadData()
                }
            }else{
                print("noData,\(error)")
            }

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
    // MARK: - TableViewDelegate&DataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bookCell", forIndexPath: indexPath)
        let book:CCBook = self.bookArray[indexPath.row]
        cell.textLabel?.text = book.name
//        Alamofire.request(.GET, URLString: book.coverImageUrl!).response {
//            (_, _, data, error) in
//            if data != nil {
//                let image = UIImage(data: data as! NSData)
//                cell.imageView?.image = image
//            }
//        }
//        let imageUrl :NSURL = NSURL()
//        let imageData :NSData = NSData(contentsOfURL: )
//        cell.coverImage.image = UIImage(data: NSData(contentsOfURL:NSURL.URLWithString(book.coverImageUrl!)!)!)!)!
//        var nsd = NSData(contentsOfURL:NSURL.URLWithString("http://ww2.sinaimg.cn/bmiddle/632dab64jw1ehgcjf2rd5j20ak07w767.jpg"))
        
        // Configure the cell...
        
        return cell
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 68
    }

}
