//
//  File.swift
//  
//
//  Created by Greg Main on 18/03/2021.
//

import Foundation

public class VarDictAndersen {
    
    var varDict: [String: Int]
    
    init() {
        varDict = [String: Int]()
    }
    
    public func existsNodeFor(varIndex: Int, lowIndex: Int, highIndex: Int) -> (exists: Bool, node: Int?) {
        let aKey = ("\(varIndex) \(lowIndex) \(highIndex)")
        
        if let aNode = varDict[aKey] {
            return (true, aNode)
        } else {
            return (false)
        }
        
    }
    
    public func addNode(nodeIndex: Int, varIndex: Int, lowIndex: Int, highIndex: Int) {

        let aKey = ("\(varIndex) \(lowIndex) \(highIndex)")
        varDict[aKey] = nodeIndex
    }
    
}
