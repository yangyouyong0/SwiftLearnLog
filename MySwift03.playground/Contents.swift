//: Playground - noun: a place where people can play

import UIKit

//函数
// 函数一 不改变外部变量的值
var str = "Hello, playground"
var str1 = "change test"
func changeFunc(var str1:String , var str2:String) {
    var temp:String = str1
    str1 = str2
    str2 = temp
}
changeFunc(str, str1)
println(str)

// 函数二 改变外部变量的值
func changeIO(inout str1:String , inout str2:String) {
    var temp:String = str1
    str1 = str2
    str2 = temp
}

changeIO(&str, &str1)
println(str)
