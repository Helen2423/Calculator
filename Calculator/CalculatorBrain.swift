//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by trans on 16/3/23.
//  Copyright © 2016年 trans. All rights reserved.
//
//swift基类
import Foundation

//栈
class CalculatorBrain
{
    //private私有化 其他默认public
    
    //CustomStringConvertible不是继承 是告诉swift这个枚举有自己的protocol的内容
    private enum Op :CustomStringConvertible
    {
        case Operand(Double)
        //参数 方法
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        //op转换为string类型，方便以后调试 只读
        var description: String {
            get {
                switch  self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                    
                }
            }

        }
    }
    
    //var openStackCal = Array <Double>()
    //相同var opStack = Array <Op> ()
    private var opStack = [Op]()
    
    //dictionary
    //var knownOps = Dictionary<String, Op>()
    private var knownOps = [String:Op]()
    
    init() {
//        func learnOp(op: Op) {
//            knownOps[op.description] = op
//        }
//        
//        learnOp(Op.BinaryOperation("×", *))
        
        
        //"×+−÷√"
        //case BinaryOperation(String, (Double, Double) -> Double)
        //knownOps["×"] = Op.BinaryOperation("×", {$0 * $1})
        //knownOps["×"] = Op.BinaryOperation("×") {$0 * $1}
        //* + － ÷ sqrt 都是函数
        //不能改 因为／ －都是反过来的
        //knownOps["+"] = Op.BinaryOperation("+") {$0 + $1}
        //knownOps["√"] = Op.UnaryOperation("√") { sqrt($0) }
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−") {$1 - $0}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)

    }
    
    //string dictionary 结构体传值
    //类 传引用 可继承
    
    //let常量 var变量
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            //let op = ops.removeLast() 报错 ops是常量，不能改变 (ops: [Op])省略了let
            //改法一：private func evaluate(var ops: [Op])...
            //改法二：
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            //_表示不关心
            case .UnaryOperation(_, let operation):
                //递归
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
                
            case .BinaryOperation(_, let operation):
                //递归
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            //default: break 已经把所有情况写了
                
            }
            
        }
        
        return (nil, ops)
    }
    
    //Double?  报错 为nil
    func evaluate() -> Double? {
        
        //调用递归
        //let (result, _) = evaluate(opStack)
        let (result, remainder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol:String) ->Double? {
        //operation 类型Op? optional Op 可能为nil
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
    
}
