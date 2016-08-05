//
//  ViewController.swift
//  Calculator
//
//  Created by trans on 16/3/17.
//  Copyright © 2016年 trans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //实例变量 outlet var 变量名 变量类型
    @IBOutlet var calculatorLable: UILabel!
    //option 默认nil

    //方法 action func 方法名 参数变量 -> 返回值
//    @IBAction func appendDight(sender: UIButton) -> Double{
//    }

    //Swift中每个变量都要初始化或赋初值
    var firstClearZero: Bool = false
    var brain = CalculatorBrain()
    
    
    @IBAction func appendDight(sender: UIButton) {
        // let 和 var 一样表示变量 但是表示的是常量 不可更改
        // digit没有类型 由后面的类型推导而来 类型let digit: String?
        // String?
        // ？表示变量类型为optional 
        // option 有2个值1、notset nil 2、被set something ？前面的类型
        // String?表示类型为optional 但被设置为string
        
        //当类型为option时可以用！来解包
        //let digit = sender.currentTitle   类型String?
        //let digit = sender.currentTitle!  类型String
        //当option的值为nil，且用！解包，程序会崩溃
        
        
        // \(变量) 可以直接将变量转化为string类型输出
        //let digit = sender.currentTitle
        //控制台输出结果 digit = Optional("2")  digit = Optional("3")
        
        //let digit = sender.currentTitle!
        //控制台输出结果digit = 8  digit = 9  digit = 8
        //print("digit = \(digit)")
        
        let digit = sender.currentTitle!
        if firstClearZero {
            //string? 可以被赋string类型
            calculatorLable.text = calculatorLable.text! + digit
        } else {
            calculatorLable.text = digit
            firstClearZero = true
        }
        
    }
    
    //加减乘除
    @IBAction func operate(sender: UIButton) {
        
        if firstClearZero {
            calretrun()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayvalue = result
            } else {
                displayvalue = 0
            }
            
//            switch operation {
////版本一：不理想 最好方法传参
////            case "×":
////                //removeLast() Requires: count > 0
////                if openStackCal.count >= 2 {
////                    //调用displayvalue的set
////                    displayvalue = openStackCal.removeLast() * openStackCal.removeLast()
////                    calretrun()
////                }
////            case "÷":
////            case "+":
////            case "−":
//
////版本二：swift 需要写四个函数
////            case "×": performOperation(multiply)
////            case "÷": performOperation(divide)
////            case "+": ..
////            case "−": ..
////版本三：把multiply函数写在语句里 闭包 移大括号＋in
////        case "×": performOperation({(op1: Double, op2: Double) -> Double in
////            return op1 * op2})
//            
////版本四：类型推导
////        case "×": performOperation({(op1, op2) in return op1 * op2})
////版本五：类型推导
////        case "×": performOperation({(op1, op2) in op1 * op2})
////版本六：参数名参略 $0 $1 $2 $3
////        case "×": performOperation({$0 * $1})
////版本七：方法里写方法 最后一个参数，可以放在括号外面
////        case "×": performOperation(){$0 * $1}
////版本八：如果只有一个参数，可以省略括号
//            case "×": performOperation {$0 * $1}
//            case "÷": performOperation {$1 / $0}
//            case "+": performOperation {$0 + $1}
//            case "−": performOperation {$1 - $0}
//            case "√": performOperationsingle { sqrt($0) }
//            
//            default: break;
//            }
        }
        
    }
    

    
//    func performOperation(operation: (Double, Double) -> Double) {
//        if openStackCal.count >= 2 {
//            //调用displayvalue的set
//            displayvalue = operation(openStackCal.removeLast(), openStackCal.removeLast())
//            calretrun()
//        }
//    }
//    
//    //
//    func performOperationsingle(operation: Double -> Double) {
//        if openStackCal.count >= 1 {
//            displayvalue = operation(openStackCal.removeLast())
//            calretrun()
//        }
//    }
    
//    func multiply(op1: Double, op2: Double) -> Double {
//        return op1 * op2
//    }
    
    
    
    //var openStackCal: Array<Double> = Array <Double>() 类型推导
//    var openStackCal = Array <Double>()
    
    @IBAction func calretrun() {
        firstClearZero = false
        //调用displayvalue的get方法，获取值，存入数组
//        openStackCal.append(displayvalue)
//        print("openStackCal = \(openStackCal)")
        if let result = brain.pushOperand(displayvalue) {
            displayvalue = result
        } else {
            displayvalue = 0
            
        }
    }
    
    var displayvalue: Double {
        get {
            //将label中的值转为double，获取lable中的值
            return NSNumberFormatter().numberFromString(calculatorLable.text!)!.doubleValue
        }
        set {
            //displayvalue = openStackCal.removeLast() * openStackCal.removeLast()
            //displayvalue ＝ 3 * 6
            //newValue 值为18
            calculatorLable.text = "\(newValue)"
            firstClearZero = false
        }
    }
    
    
    

}

