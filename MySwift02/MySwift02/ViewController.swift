//
//  ViewController.swift
//  MySwift02
//
//  Created by yangyouyong on 15/4/21.
//  Copyright (c) 2015年 yangyouyong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createMyImageView()
    }
    
    
    func createMyImageView()->Void {
        
        let imageUrl = NSURL(string: "http://a3.topitme.com/7/73/ef/1164721906ba7ef737o.jpg")
        println(view.frame)
        
        var myImageView :UIImageView = UIImageView(frame: CGRectMake(50, 50, (CGRectGetWidth(view.frame) - 100), 200))
        
//        myImageView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        myImageView.backgroundColor = UIColor.cyanColor()
        
        view.addSubview(myImageView)
        myImageView.image = UIImage(data: NSData(contentsOfURL: imageUrl!)!)
        myImageView.contentMode = UIViewContentMode.ScaleAspectFill
        myImageView.center = view.center
        
//        view.setNeedsDisplay()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

