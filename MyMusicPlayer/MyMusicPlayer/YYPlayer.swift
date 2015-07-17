//
//  YYPlayer.swift
//  MyMusicPlayer
//
//  Created by yangyouyong on 15/7/4.
//  Copyright (c) 2015年 yangyouyong. All rights reserved.
//

import UIKit
class YYPlayer: NSObject {
    class func sharInstance()->YYPlayer {
        struct YYSingleton {
            static var predicete:dispatch_once_t = 0
            static var instance:YYPlayer? = nil
        }
//        dispatch_once(&YYSingleton.predicete, {
//            YYSingleton.instance = YYSingleton()
//        })
        dispatch_once(&YYSingleton.predicete){
            YYSingleton.instance = YYPlayer()
        }
        return YYSingleton.instance!
    }
    
    func playWithUrl(url:String) {
        
    }
}
