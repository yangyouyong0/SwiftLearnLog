//
//  ViewController.swift
//  YYPlayer
//
//  Created by yangyouyong on 15/7/5.
//  Copyright (c) 2015年 yangyouyong. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var request:Request? {
            didSet {
                oldValue?.cancel()
                
                self.title = request?.description
                
            }
        }
    }

//    func loadRequest() {
//        let mainAPI:String = "http://online.dongting.com/recomm/new_songs_more?page=1&size=30";
//        Alamofire.manager.request(Method.GET, mainAPI).validate().responseImage(){
//            (request,_,image,error)in
//            
//            if  error == nil {
//                if request.URLString.isEqual(imageURL){
//                    cell.userImageView.image = image
//                }
//            }
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

