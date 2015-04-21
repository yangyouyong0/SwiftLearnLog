// Playground - noun: a place where people can play

import UIKit

//  ----------------------Swift 初见

//---------------------控制流--------------------//

//if ... else ...

let individualScores = [11,22,33,44,55,66]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore = score
    } else {
        teamScore = score + 1
    }
    println(teamScore)
}

var optionalString: String? = "hello"
//optionalString = nil
var optionalName: String? = "John"

    optionalName = nil
    
var greeting = "Hello"
if let name = optionalName {
    greeting = "Hello,\(optionalName)"
}

// switch ... case ...

// for...in 快速遍历

let interestingNumbers = [
    "Prime": [2,3,5,7,11,13],
    "Fibonacci": [1,1,2,3,5,8],
    "Square": [1,4,9,16,25],
]

var largest = 0
var key = ""

for (kind,numbers) in interestingNumbers {
    
    for number in numbers {
        if number > largest {
            largest = number;
            key = kind
        }
    }
}

println("largest is \(largest),kind is \(key)")

// while 循环 ...

var n = 2
while n < 100 {
    n = n * 2
}
println("n is \(n)")

var m = 2
do {
m = m * 2
} while m < 100
println("m is \(m)")

// for ... in ...
// ... 为闭区间 ..< 为前开后闭区间
var fastLoop = 0
for i in 0...4 {
    fastLoop = fastLoop + i
}
println("\(fastLoop)")

// --------------------函数和闭包----------------------- //

//  函数

func stringAppending(hax: String, end: String)->String {
    return hax+end
}
stringAppending("hello", "Swift")

func max(scores: [Int]) -> Int {
    var max = scores[0]
    for score in scores {
        max = max > score ? max : score
    }
    return max
}

func min(scores: [Int]) -> Int {
    var min = scores[0]
    for score in scores {
        min = min < score ? min : score
    }
    return min
}

func selector(scores: [Int]) -> (little: Int, large: Int, sum: Int){
    var big = max(scores)
    var lit = min(scores)
    var sum = 0
    for score in scores {
        sum = sum + score
    }
    return (lit,big,sum)
}
selector([1,2,3,3,4,5,6,7])

//  函数内嵌函数
func funcInFunc(scores: [Int]) -> Float {
    func sum(scores: [Int]) ->Int {
        var sum = 0
        for score in scores {
            sum = sum + score
        }
        return sum
    }
    return Float(sum(scores))/Float(scores.count) // 显式强转
}
funcInFunc([1,2,3,4,5,6,7,8,9,9,3])

//  函数作为参数传递
func isTheSame(scores: [Int] , max:[Int]->Int , min:[Int]->Int) ->Bool {
    return max(scores) == min(scores)
}
var scores:[Int] = [1,1,1,1,1,1]
isTheSame(scores, max, min)

//  闭包
var numbers = [1,2,3,5,3,2,1]
let sortedNumbers = sorted(numbers) {$0 > $1}
sortedNumbers

// --------------------对象和类----------------------- //

// 类
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A Shape With \(numberOfSides) sides."
    }
}

var shape = Shape()
shape.numberOfSides = 4
shape.simpleDescription()

// 类继承加冒号，方法重写
class  NamedShape:Shape {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
   override func simpleDescription() -> String {
        return "A Shape with \(numberOfSides) sides and name :\(name)"
    }
}

var shapeHasName = NamedShape(name:"haha")
shapeHasName.numberOfSides = 6
shapeHasName.simpleDescription()

// 继承和构造方法重写
class Square: NamedShape {
    var sideLength: Double
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    // 成员变量的setter 和 getter 默认新值的名称为 newValue
    var paremeter: Double {
        set{
           sideLength = newValue / 3.0
        }
        get {
            return 3.0 * sideLength
        }
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)"
    }
}

let test = Square(sideLength: 4.4, name: "Square")
test.paremeter
test.paremeter = 8.8
test.area()
test.simpleDescription()

// --------------------枚举和结构体----------------------- //
// 枚举 原始值如果没意义，可以不设置
enum Rank: Int {
    case Ace = 1
    case Two, Three, Four
    case Jack, Queue, King
    func simpleDescription()->String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queue:
            return "queue"
        case .King:
            return "king"
        default:
            return "default"
        }
    }
}
let ace = Rank.Ace
let aceRawValue = ace.rawValue

// 结构体 和类很相似，结构体传递的是值，类传递的是引用（指针）
struct Card {
    var rank: Rank
    func simpleDescription () -> String {
        return "The \(rank.simpleDescription())"
    }
}
let testSpads = Card(rank: .King)
testSpads.simpleDescription()

// --------------------协议和扩展----------------------- //

// 协议 protocol
protocol ExampleProtocol {
    var simpleDescription: String{ get }
    mutating func adjust()
}

// 类，枚举，结构体都可以实现协议
class SimpleClass: ExampleProtocol {
    var simpleDescription:String = "A very simple class"
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "Now 100% adjusted"
    }
}
var simpleClass = SimpleClass()
simpleClass.adjust()
simpleClass.simpleDescription

// 结构体实现协议
struct SimpleStructure:ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var simpleStructure = SimpleStructure()
simpleStructure.adjust()
simpleStructure.simpleDescription

// 注意mutating 用来修饰会修改结构体的方法 类中未标注是因为类中的方法经常会修改类

// 扩展 extension
extension Int:ExampleProtocol {
    
    var simpleDescription: String {
        return "The number \(self)"
    }
    
    mutating func adjust() {
        self += 42
    }
}
7.simpleDescription

// --------------------泛型----------------------- //
func repeat<ItemType>(item: ItemType, times: Int) -> [ItemType] {
    var result = [ItemType]()
    for i in 0 ..< times {
        result.append(item)
    }
    return result
}
repeat("knock", 4)
// 泛型到底是何东东 难道是取代id类型？有点像
// 可以创建泛型类，结构体，枚举


























