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
    
    public func add(token: Token) -> AstNode {
        
        // All other tokens are handled by the ast node
        if (isLParen() || isNot()) {
            bottom = AstNode(token: token)
            bottom!.top = self
            return bottom!
        } else {
            if (isText() || isOperation()) {
                succ = AstNode(token: token)
                succ!.pre = self
                return succ!
            }
        }
        // This should never happen: Make it crash
        return AstNode(token: token)
    }
    
    public func prevLParen() -> AstNode {
        if isLParen() {
            if hasTopNot() {
                return top!
            }
            return self
        } else {
            if hasTop() {
                return top!.prevLParen()
            } else {
                return pre!.prevLParen()
            }
        }
        
    }
    
    public func isLParen() -> Bool {
        return tokenType() == .leftParen
    }
    
    public func isRParen() -> Bool {
        return tokenType() == .rightParen
    }
    
    public func isNot() -> Bool {
        return tokenType() == .not
    }
    
    public func isText() -> Bool {
        return tokenType() == .text
    }
    
    public func isOperation() -> Bool {
        return tokenType() == .op
    }
    
    public func hasTopNot() -> Bool {
        if  hasTop() {
            if top!.isNot() {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    public func hasTop() -> Bool {
        return top != nil
    }
    
    
    public func hasBottom() -> Bool {
        return bottom != nil
    }
    
    
    public func hasSucc() -> Bool {
        return succ != nil
    }
    
    
    public func contentTo(string: String) -> String {
        var answer = string
        
        answer = answer + content()
        
        if hasBottom() {
            answer = bottom!.contentTo(string: answer)
            if isLParen() { answer = answer + ")" }
        }
        
        if hasSucc() {
            answer = succ!.contentTo(string: answer)
        }
        
        return answer
    }
    
    
    public func printStructure(string: String, index: Int) {

        let index = index + 1
        let string = string
        
        print("\(string) \(index) \(content())")
        
        if hasSucc() {
            succ!.printStructure(string: " succ ", index: index)
        }
        
        if hasBottom() {
            bottom!.printStructure(string: " bott ", index: index)
        }
    }
    
    
}
