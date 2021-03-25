//
//  File.swift
//  
//
//  Created by Greg Main on 18/03/2021.
//

import Foundation

public class BddAndersen {
    
    var orderDict: [String: Int]
    var nodeDict = [Int: [Int]]()
    var varDict: [String: Int]
    
    
    init(variableOrdering: [String: Int]) {
        
        orderDict = variableOrdering
        nodeDict[0] = [Int]()
        nodeDict[1] = [Int]()
        varDict = [String: Int]()
    }
    
    
    public func make(varIndex: Int, lowIndex: Int, highIndex: Int) -> Int {
        
        guard (lowIndex != highIndex) else {
            return lowIndex
        }
        
        let answer = varDictExistsNodeFor(varIndex: varIndex, lowIndex: lowIndex, highIndex: highIndex)
        if answer.exists {
            return answer.node!
        } else {
            let nodeIndex = addNodeDict(varIndex: varIndex, lowIndex: lowIndex, highIndex: highIndex)
            varDictAddNode(nodeIndex: nodeIndex, varIndex: varIndex, lowIndex: lowIndex, highIndex: highIndex)
            return nodeIndex
        }
    }
    
    
    public func addNodeDict(varIndex: Int, lowIndex: Int, highIndex: Int) -> Int {
        
        let nodeIndex = nodeDict.keys.count + 1
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
