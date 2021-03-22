//
//  File.swift
//  
//
//  Created by Greg Main on 18/03/2021.
//

import Foundation

public class NodeDictAndersen {
    
    var nodeDict = [Int: [Int]]()
    
    
    init() {
        nodeDict[0] = [Int]
        nodeDict[1] = [Int]
    }
    
    
    public func addNode(varIndex: Int, lowIndex: Int, highIndex: Int) -> Int {
        
        let nodeIndex = nodeDict.keys.count + 1
        nodeDict[nodeIndex] = [varIndex, lowIndex, highIndex]
        
        return nodeIndex
    }
    
    public func terminal0() -> Int {
        return nodeDict[0]
    }
    
    
    public func terminal1() -> Int {
        return nodeDict[1]
    }
    
}
