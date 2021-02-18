//
//  Token.swift
//  testLexer
//
//  Created by Gregor Schwake on 09/12/2020.
//

import Foundation

public struct Token {
    
    let opAnd = "\u{2227}"
    let opOr = "\u{2228}"
    let opNot = "\u{00AC}"

    public let type: TokenType
    public let content: String
    
    init(from: String) {
        self.content = from
        switch from {
            case "(": type = .leftParen
            case ")": type = .rightParen
            case opNot: type = .not
            case opAnd: type = .op
            case opOr: type = .op
            default: type = .text
        }
    }
    
}


extension Token: CustomStringConvertible {
      public var description: String {
          return "\(type) - \(content)"
      }
}
