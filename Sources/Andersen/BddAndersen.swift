//
//  File.swift
//  
//
//  Created by Greg Main on 18/03/2021.
//

import Foundation

public class BddAndersen {
    
    var orderDict: [String: Int]
    var nodeDict: NodeDictAndersen
    var varDict: VarDictAndersen
    
    
    init(variableOrdering: [String: Int]) {
        
        orderDict = variableOrdering
        nodeDict = NodeDictAndersen()
        varDict = VarDictAndersen()
    }
    
    
    public func make(varIndex: Int, lowIndex: Int, highIndex: Int) -> Int {
        
        guard (lowIndex != highIndex) else {
            return lowIndex
        }
        
        let answer = varDict.existsNodeFor(varIndex: varIndex, lowIndex: lowIndex, highIndex: highIndex)
        if answer.exists {
            return answer.node
        } else {
            let nodeIndex = nodeDict.addNode(varIndex: varIndex, lowIndex: lowIndex, highIndex: highIndex)
            varDict.addNode(nodeIndex: nodeIndex, varIndex: varIndex, lowIndex: lowIndex, highIndex: highIndex)
            return nodeIndex
        }
    }
}
