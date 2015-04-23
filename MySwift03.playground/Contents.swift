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

//  解释: swift 中集合（Collection）类型均以结构体的形式实现，String，Array，Dictionary，Set 类型的数据被赋值是发生值拷贝行为
//  Objective－C 中 集合类型均以类的形式实现， 在赋值和传入函数时，不会发生值拷贝，传递的是实例的引用
 println("\(str)")

//  常量 存储属性
//  当值类型的实例被声明为常量时， 它所有的属性也成为了常量
//  引用类型的类不一样，把引用类型的实例赋给常量后，仍然可以修改其变量的属性

//  lazy 关键字来创建延迟属性

//  值类型（结构体或者枚举）可以定义存储型和计算型类型属性，对于类则只能定义计算型类型属性

