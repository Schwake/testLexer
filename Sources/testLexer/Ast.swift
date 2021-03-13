//
//  Ast.swift
//  testLexer
//
//  Created by Gregor Schwake on 15/01/2021.
//

import Foundation

public final class Ast {
    
    var rootNode: AstNode?
    let lexer: Lexer
    
    
    public init(lexer: Lexer) {
        self.lexer = lexer
        self.populate()
    }

    
    public func populate() {
        var started = false
        var currNode: AstNode?
        var rParenFound = false
        
        for token in lexer.tokens {
            if !started {
                started = true
                rootNode = AstNode(token: token)
                currNode = rootNode!
            } else {
                if token.type == .rightParen {
                    rParenFound = true
                } else {
                    if rParenFound {
                        rParenFound = false
                        currNode = currNode?.prevLParen(fromSucc: false)
                        let aNode = AstNode(token: token)
                        currNode!.succ = aNode
                        aNode.pre = currNode
                        currNode = aNode
                    } else {
                        currNode = currNode!.add(token: token)
                    }
                }
            }
        }
    }
    
    
    public func collectVariables() -> [String:Int] {
  
        var answer = [String:Int]()
        var variableNames = [String]()
        
        if let rootNode = rootNode {
            rootNode.collectVariables(names: &variableNames)
        }
        
        let sortedNames = Array(Set(variableNames)).sorted()
        
        for (index, value) in sortedNames.enumerated() {
            let orderIndex = index + 1
            answer[value] = orderIndex
        }
        
        return answer
    }
    
    
    
    public func collectVariablesSet() -> [String:Int] {
  
        var answer = [String:Int]()
        var namesSet = Set<String>()
        var sortedNames: [String]
        
        if let rootNode = rootNode {
            namesSet = rootNode.collectVariablesSet(names: namesSet)
        }
        
        sortedNames = Array(namesSet).sorted()
        
        for (index, value) in sortedNames.enumerated() {
            let orderIndex = index + 1
            answer[value] = orderIndex
        }
        
        return answer
    }
    
    public func toString() -> String {
        var answer = ""
        
        if let rootNode = rootNode {
            answer = rootNode.contentTo(string: answer)
        }
     
        return answer
    }
    
    
    public func printStructure() {
        
        if let rootNode = rootNode {
            rootNode.printStructure(string: "", index: 0)
        }
    }
  
}
