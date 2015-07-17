//: Playground - noun: a place where people can play

/////////////----柯里化函数和方法(Curried Functions and Methods)-----////////

import UIKit

var str = "Hello, playground"

func addTwoInts(a:Int,b:Int) ->Int {
    return a + b
}

func addTwoIntsCurried(a:Int) ->(Int ->Int) {
    func addTheOtherInt(b:Int) ->Int {
        return a + b
    }
    return addTheOtherInt
}


addTwoInts(4, 5)
addTwoIntsCurried(4)(5)
let plusOne = addTwoIntsCurried(1)
plusOne(10)
plusOne(11)
UIImageView(image: UIImage(data: NSData(contentsOfURL: NSURL(string: "http://ww1.sinaimg.cn/large/684ff39bjw1eh2xkuz8roj20nc0fajs5.jpg")!)!));

