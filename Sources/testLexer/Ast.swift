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
    }

    public func populateAst() {
//        var started = false
//        
//        for token in lexer.tokens {
//            if !started {
//                started = true
//                var currAstNode = AstNode(token: token)
//                currAstNode = currAstNode.next()
//            } else {
//                
//            }
//        }
        
    }
    
    
}
