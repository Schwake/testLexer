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
                        currNode = currNode?.prevLParen()
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
    
    public func toString() -> String {
        var answer = ""
        
        if let rootNode = rootNode {
            answer = rootNode.contentTo(string: answer)
        }
     
        return answer
    }
  
}
