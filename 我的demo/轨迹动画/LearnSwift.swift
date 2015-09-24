//
//  LearnSwift.swift
//  轨迹动画
//
//  Created by ZY on 15/8/12.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

import UIKit

class LearnSwift: UIViewController {
    var qwe = "dsfsdf"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.simpleValue()
        
        self.functionAndClosure("", day: "")
        
        self.returnFifteen()

    }
    
    //MARK: - 简单值
    func simpleValue() {
        
//        let lkasd = 1
//        let df = 3
//        var kf = lkasd + df
//        var eee = qwe + String(df)
//        
//        
//        let apples = 3
//        let oranges = 5
        
//        let appleSummary = "I have \(apples) apples."
//        let fruitSummary = "I have \(apples + oranges) pieces of fruit."
        
        var shoppingList = ["catfish", "water", "tulips", "blue paint"]
        shoppingList[1] = "bottle of water"
        var occupations = [
            "Malcolm": "Captain",
            "Kaylee": "Mechanic",
        ]
        occupations["Jayne"] = "Public Relations"
        print(occupations, terminator: "")
        
        
        let individualScores = [75, 43, 103, 87, 12]
        var teamScore = 0
        for score in individualScores {
            if score > 50 {
                teamScore += 3
            } else {
                teamScore += 1
            }
        }
        print(teamScore, terminator: "")
        
        
        let optionalString: String? = "Hello"
        print(optionalString == nil, terminator: "")
        
//        let optionalName: String? = nil
//        var greeting = "Hello!"
//        if let name = optionalName {
//            greeting = "Hello, \(name)"
//        } else {
//            greeting = "Hello, www"
//        }
//        
        
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            let vegetableComment = "Add some raisins and make ants on a log."
            vegetableComment
        case "cucumber", "watercress":
            let vegetableComment = "That would make a good tea sandwich."
            vegetableComment
        case let x where x.hasSuffix("pepper"):
            let vegetableComment = "Is it a spicy \(x)?"
            vegetableComment
            
        default:
            let vegetableComment = "Everything tastes good in soup."
            vegetableComment
        }
        
        
        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25],
        ]
        var largest = 0
        for (kind, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                }
            }
           kind
        }
        
        //        使用while来重复运行一段代码直到不满足条件。循环条件也可以在结尾，保证能至少循环一次。
        
        var n = 2
        while n < 100 {
            n = n * 2
        }
        print(n, terminator: "")
        
        var m = 2
        
        
        //repeat
        repeat {
            m = m * 2
        } while m < 100
        print(m, terminator: "")
        
        //        你可以在循环中使用..<来表示范围，也可以使用传统的写法，两者是等价的：
        //        使用..<创建的范围不包含上界，如果想包含的话需要使用...
        
        
        
        var firstForLoop = 0
        for i in 0..<4 {
            firstForLoop += i
        }
        print(firstForLoop, terminator: "")
        
        var secondForLoop = 0
        for var i = 0; i < 4; ++i {
            secondForLoop += i
        }
        print(secondForLoop, terminator: "")
        
    }
    
    //MARK: - 函数和闭包 Function and closure
    func functionAndClosure(name: String, day: String) -> Void{
        
        greet("Bob", day: "Tuesday")
        
        
        let statistics = calculateStatistics([5, 3, 100, 3, 9])
        print(statistics.sum, terminator: "")
        print(statistics.2, terminator: "")
//        let qq = statistics.2
//        let qq1 = statistics.sum
//        let qq2 = statistics.1
//        let qq3 = statistics.0
        
        
//        var qq4 = sumOf()
//        var qq5 = sumOf(42, 597, 12)
        
        
        let increment = makeIncrementer()
        increment(7)
    }
    //    使用func来声明一个函数，使用名字和参数来调用函数。使用->来指定函数返回值的类型。
    
    func greet(name: String, day: String) -> String {
        return "Hello \(name), today is \(day)."
    }
    
    
    //    使用元组来让一个函数返回多个值。该元组的元素可以用名称或数字来表示。
    
    func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        
        for score in scores {
            if score > max {
                max = score
            } else if score < min {
                min = score
            }
            sum += score
        }
        
        return (min, max, sum)
    }
    
    //    函数可以带有可变个数的参数，这些参数在函数内表现为数组的形式：
    
    func sumOf(numbers: Int...) -> Int {
        var sum = 0
        for number in numbers {
            sum += number
        }
        return sum
    }
//    函数可以嵌套。被嵌套的函数可以访问外侧函数的变量，你可以使用嵌套函数来重构一个太长或者太复杂的函数。
    
    func returnFifteen() -> Int {
        var y = 10
        func add() {
            y += 5
        }
        add()
        return y
    }
//    函数是第一等类型，这意味着函数可以作为另一个函数的返回值。
    
    func makeIncrementer() -> (Int -> Int) {
        func addOne(number: Int) -> Int {
            return 1 + number
        }
        return addOne
    }
//    函数实际上是一种特殊的闭包:它是一段能之后被调取的代码。闭包中的代码能访问闭包所建作用域中能得到的变量和函数，即使闭包是在一个不同的作用域被执行的 - 你已经在嵌套函数例子中所看到。你可以使用{}来创建一个匿名闭包。使用in将参数和返回值类型声明与闭包函数体进行分离。
    
//    numbers.map({
//    (number: Int) -> Int in
//    let result = 3 * number
//    return result
//    })
    
    
//    let greeting = "Guten Tag"
//    print(greeting.startIndex)
//    // 0
//    print(greeting.endIndex)
//    // 9
////    你可以通过下表来获得String对应位置的Character：
//    
//    greeting[greeting.startIndex]
//    // G
}




