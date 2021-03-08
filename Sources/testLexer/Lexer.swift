//
//  Lexer.swift
//  testLexer
//
//  Created by Gregor Schwake on 09/12/2020.
//

import Foundation

public final class Lexer {
    
    // Basic variables
    public let source: String
    public var tokens: [Token]
    
    // We only need the string that is to be analyzed
    public init(source: String) {
        self.source = source
        self.tokens = []
        self.scan(source: source)
    }
    
    // There will always be at least one token
    func rootToken() -> Token {
        return tokens.first!
    }
    
    
    // Looping through the string to get tokens
    public func scan(source: String) {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        let opNot = "\u{00AC}"
        
        var currentString = ""
        let standardTokens = [opNot, opAnd, opOr, "(", ")"]
        
        for (_, char) in source.enumerated() {
            
            // Check if current character is a new token
            if char.isWhitespace {
                if !currentString.isEmpty {
                    let token = addToken(named: currentString)
                    tokens.append(token)
                }
                currentString = ""
            } else {
                if standardTokens.contains(currentString) {
                    let token = addToken(named: currentString)
                    tokens.append(token)
                    currentString = String(char)
                } else {
                    if standardTokens.contains(String(char)) && !currentString.isEmpty {
                        let token = addToken(named: currentString)
                        tokens.append(token)
                        currentString = ""
                    }
                    currentString.append(char)
                }
            }
        }
        // Do not forget last character
        if !currentString.isEmpty {
            let token = addToken(named: currentString)
            tokens.append(token)
        }
    }
    
    private func addToken(named: String) -> Token {
        let token = Token(from: named)
        return token
    }

    public func checkParenCount() -> Bool {
        
        let lParenCount = source.filter{ $0 == "("}.count
        let rParenCount = source.filter{ $0 == ")"}.count
        
        return lParenCount == rParenCount
    }
    
    public func checkParenRAppearance() -> Bool {
        
        var lParCount = 0
        var rParCount = 0
        var checkOK = true
        
        for item in source {
            if item == "(" { lParCount = lParCount + 1 }
            if item == ")" { rParCount = rParCount + 1 }
            
            if rParCount > lParCount { checkOK = false }
        }
        
        return checkOK
    }
    
}
