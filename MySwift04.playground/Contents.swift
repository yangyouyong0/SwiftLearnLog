//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//  -------------------------方法-------------------------  //

//  结构体和枚举能够定义方法是Swift与OC的主要区别之一

//  final 关键字会防止方法重写 类前面加final 类会不让继承

final class finalClass {
   final var name = ""
}
//class subClass: finalClass {
//    println("")
//}

//  -------------------------构造过程-------------------------  //


class cls1 {
    let name:String
    var age:NSInteger
    init(name:String , age:NSInteger){
        self.name = name
        self.age = age
    }
    
//    final func printName {
//        println(self.name)
//    }
}


class cls2: cls1 {
    let length :NSInteger
    init(name: String, age: NSInteger , length: NSInteger) {
        self.length = length
        super.init(name: name, age: age)
    }
    
//    init?(name: String, age: NSInteger , length: NSInteger) {
//        self.length = length
//        super.init(name: name, age: age)
//    }
    
    convenience init() {
        self.init(name: "name", age: 10 , length: 10)
    }
}

var clsTest = cls2()
var clsTest1 = cls2(name: "haha", age: 20, length: 17)
println(clsTest.length)
println(clsTest1.age)

// 存储多种类型的数组

var array = [Any]()
array.append(0)
array.append(1.5)
array.append(50)
array.append(3.1415926)
array.append("hello world")
array.append((3.0,5.0))
array.append(clsTest)
array.append({
    (name:String) -> String in
    "Hello \(name)"
})

// 判断类型 as 进行类型转换
println(array is Array)

//for thing in array {
//    switch thing {
//    case _ as NSInteger { //        println(thing)
//        } //
//    }
//}

// 关键字下标 subscript




















