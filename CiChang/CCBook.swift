//
//  CCBook.swift
//  CiChang
//
//  Created by yangyouyong on 15/7/9.
//  Copyright © 2015年 yangyouyong. All rights reserved.
//

import UIKit
/*
coverImageUrl = "http://f1.c.hjfile.cn/yl/pic/201406/201406200631395975.jpg";
dateAdded = "2012-02-23T16:23:39.6";
dateUpdated = "2015-05-29T15:16:00.85";
id = 10565;
introduction = "\U7efc\U5408\U4e86\U5927\U5b66\U56db\U7ea7\U5386\U5e74\U8003\U8bd5\U771f\U9898\U7684\U5e38\U89c1\U8bcd\U6c47\Uff0c\U9002\U5408\U8003\U8bd5\U8003\U524d\U67e5\U7f3a\U8865\U6f0f";
isSelected = 1;
name = "\U82f1\U8bed\U56db\U7ea7\U9ad8\U9891\U8bcd\U6c47";
originalLanguage = en;
settings = 91;
type = 2;
unitCount = 34;
userCount = 198280;
wordCount = 678;
*/
struct CCBook {
    var coverImageUrl: String?
    var dateAdded: String?
    var dateUpated: String?
    var bookID:NSNumber?
    var introduction: String? = ""
    var isSelected: Bool? = false
    var name: String? = ""
    var originalLanguage: String? = ""
    var settings: NSNumber? = 0
    var type: NSNumber? = 0
    var unitCount: NSNumber? = 0
    var userCount: NSNumber? = 0
    var wordCount: NSNumber? = 0
    func initWithDict(dic:[String:AnyObject]) -> CCBook{
        var book = CCBook()
        book.coverImageUrl = dic["coverImageUrl"] as? String
        book.name = dic["name"] as? String
        return book
    }
}
