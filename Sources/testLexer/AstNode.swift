//
//  AstNode.swift
//  testLexer
//
//  Created by Gregor Schwake on 15/01/2021.
//

import Foundation

public class AstNode {
    
    let token: Token
    
    var top: AstNode?
    var bottom: AstNode?
    var pre: AstNode?
    var succ: AstNode?
    
    
    init(token: Token) {
        self.token = token
    }
    
    public func tokenType() -> TokenType {
        return token.type
    }
    
    public func content() -> String {
        return token.content
    }
    
    public func isLParen() -> Bool {
        return tokenType() == .leftParen
    }
    
    public func isRParen() -> Bool {
        return tokenType() == .rightParen
    }
    
    public func isNegation() -> Bool {
        return tokenType() == .not
    }
    
    
}
