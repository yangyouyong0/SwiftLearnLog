//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//  -----------------------------Protoclo------------------------------- //

class ProtocolTest {
    var property : String
    init(property:String){
        self.property = property
    }
    
    
}

var test = ProtocolTest(property: "protocol")
println(test.property)

test.property = "hello"




