//
//  File.swift
//  
//
//  Created by Greg Main on 18/03/2021.
//

import Foundation

public class BddAndersen {
    
    public var orderDict: [String: Int]
    public var nodeDict = [Int: [Int]]()
    public var varDict: [String: Int]
    
    
    init(variableOrdering: [String: Int]) {
        
        orderDict = variableOrdering
        nodeDict[0] = [Int]()
        nodeDict[1] = [Int]()
        varDict = [String: Int]()
    }
    
    
    public func build(node: AstNode) -> Int {
        
        let currNode = node
        let currVar = node.content()
        let currNodeVarIndex = orderDict[currVar]!
        
        let opNode = currNode.next()
        let op = opNode!.token.content
        
        let nextNode = opNode!.next()
        let low = build(node: nextNode!, op: op, boolValue: false)
        let high = build(node: nextNode!, op: op, boolValue: true)
        
        return make(varIndex: currNodeVarIndex, lowIndex: low, highIndex: high)
        
    }
    
    public func build(node: AstNode, op: String, boolValue: Bool) -> Int {
        var op = op
        let currNode = node
        let currVar = node.content()
        let currNodeVarIndex = orderDict[currVar]
        if (currNodeVarIndex == orderDict.keys.count) {
            var low: Int
            var high: Int
            let lowCalc = calculate(op: op, firstBool: boolValue, secBool: false)
            let highCalc = calculate(op: op, firstBool: boolValue, secBool: true)
            if lowCalc { low = 1 } else { low = 0 }
            if highCalc { high = 1 } else { high = 0 }
            return make(varIndex: currNodeVarIndex!, lowIndex: low, highIndex: high)
        }
        
        let opNode = currNode.next()
        op = opNode!.token.content
        
        let nextNode = opNode!.next()
        let low = build(node: nextNode!, op: op, boolValue: false)
        let high = build(node: nextNode!, op: op, boolValue: true)
        
        return make(varIndex: currNodeVarIndex!, lowIndex: low, highIndex: high)
        
    }
    
    
    public func calculate(op: String, firstBool: Bool, secBool: Bool) -> Bool {
        
        let op = op
        switch op {
            // And
            case "\u{2227}":
                return firstBool && secBool
            // Or
            case "\u{2228}":
                return firstBool || secBool
        default:
            return false
        }
     
    }
    
    
    public func make(varIndex: Int, lowIndex: Int, highIndex: Int) -> Int {
        
        guard (lowIndex != highIndex) else {
            return lowIndex
        }
        
        let answer = varDictExistsNodeFor(varIndex: varIndex, lowIndex: lowIndex, highIndex: highIndex)
        if answer.exists {
            return answer.node!
        } else {
            let nodeIndex = nodeDictAddNode(varIndex: varIndex, lowIndex: lowIndex, highIndex: highIndex)
            varDictAddNode(nodeIndex: nodeIndex, varIndex: varIndex, lowIndex: lowIndex, highIndex: highIndex)
            return nodeIndex
        }
    }
    
    
    public func nodeDictAddNode(varIndex: Int, lowIndex: Int, highIndex: Int) -> Int {
        
        let nodeIndex = nodeDict.keys.count
        nodeDict[nodeIndex] = [varIndex, lowIndex, highIndex]
        
        return nodeIndex
    }
    
    public func nodeDictTerminal0() -> [Int] {
        return nodeDict[0]!
    }
    
    public func nodeDictTerminal1() -> [Int] {
        return nodeDict[1]!
    }
    
    public func varDictExistsNodeFor(varIndex: Int, lowIndex: Int, highIndex: Int) -> (exists: Bool, node: Int?) {
        let aKey = ("\(varIndex) \(lowIndex) \(highIndex)")
        
        if let aNode = varDict[aKey] {
            return (true, aNode)
        } else {
            return (false, nil)
        }
        
    }
    
    public func varDictAddNode(nodeIndex: Int, varIndex: Int, lowIndex: Int, highIndex: Int) {

        let aKey = ("\(varIndex) \(lowIndex) \(highIndex)")
        varDict[aKey] = nodeIndex
    }
    

}
