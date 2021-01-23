//
//  LexerTests.swift
//  testLexerTests
//
//  Created by Gregor Schwake on 09/12/2020.
//

import XCTest

class LexerTests: XCTestCase {
    
    func testLexerStrings() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        let opNot = "\u{00AC}"

        let source = opNot + " ( x " + opOr + " xc ) " + opAnd + " " + opNot + " y"
        let lexer = Lexer(source: source)
        
        XCTAssertEqual(lexer.tokens.first!.content, opNot)
        XCTAssertEqual(lexer.tokens[1].content, "(")
        XCTAssertEqual(lexer.tokens[2].content, "x")
        XCTAssertEqual(lexer.tokens[3].content, opOr)
        XCTAssertEqual(lexer.tokens[4].content, "xc")
        XCTAssertEqual(lexer.tokens[5].content, ")")
        XCTAssertEqual(lexer.tokens[6].content, opAnd)
        XCTAssertEqual(lexer.tokens[7].content, opNot)
        XCTAssertEqual(lexer.tokens.last!.content, "y")
    }
    
    func testLexerWithSpaces() {
  
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        let opNot = "\u{00AC}"
        let source = opNot + " ( x " + opOr + " xc ) " + opAnd + " " + opNot + " y"
        //let source = "! ( x OR xc ) AND ! y"
        let lexer = Lexer(source: source)
        
        XCTAssertEqual(lexer.tokens.first!.type, .not)
        XCTAssertEqual(lexer.tokens[1].type, .leftParen)
        XCTAssertEqual(lexer.tokens[2].type, .text)
        XCTAssertEqual(lexer.tokens[3].type, .op)
        XCTAssertEqual(lexer.tokens[4].type, .text)
        XCTAssertEqual(lexer.tokens[5].type, .rightParen)
        XCTAssertEqual(lexer.tokens[6].type, .op)
        XCTAssertEqual(lexer.tokens[7].type, .not)
        XCTAssertEqual(lexer.tokens.last!.type, .text)
    }
    
    func testLexerWithoutSpaces() {
  
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        let opNot = "\u{00AC}"
        //let source = "!(x OR xc) AND !y"
        let source = opNot + "(x " + opOr + " xc) " + opAnd + " " + opNot + "y"
        let lexer = Lexer(source: source)
        
        XCTAssertEqual(lexer.tokens.first!.type, .not)
        XCTAssertEqual(lexer.tokens[1].type, .leftParen)
        XCTAssertEqual(lexer.tokens[2].type, .text)
        XCTAssertEqual(lexer.tokens[3].type, .op)
        XCTAssertEqual(lexer.tokens[4].type, .text)
        XCTAssertEqual(lexer.tokens[5].type, .rightParen)
        XCTAssertEqual(lexer.tokens[6].type, .op)
        XCTAssertEqual(lexer.tokens[7].type, .not)
        XCTAssertEqual(lexer.tokens.last!.type, .text)
    }
    
    func testLexerUnicodeOperators() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        let opNot = "\u{00AC}"
        
        print(opAnd)
        print(opOr)
        print(opNot)
    }
}
