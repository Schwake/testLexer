//
//  LexerTests.swift
//  testLexerTests
//
//  Created by Gregor Schwake on 09/12/2020.
//

import XCTest
import testLexer

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
    
    
    func testLexerParenLRCount() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        let opNot = "\u{00AC}"
        
        // not ((not(x or not y) and z) or x)
        let source = opNot + "(( " + opNot + "(x " + opOr + opNot + " y) " + opAnd + " z)" + opOr + " x)"
        let lexer = Lexer(source: source)
        
        let checkOk = lexer.checkParenCount()
        
        XCTAssertTrue(checkOk)
    }
    
    func testLexerParenCountFalse() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        let opNot = "\u{00AC}"
        
        // not (not(x or not y) and z) or x)
        let source = opNot + "( " + opNot + "(x " + opOr + opNot + " y) " + opAnd + " z)" + opOr + " x)"
        let lexer = Lexer(source: source)
        
        let checkOk = lexer.checkParenCount()
        
        XCTAssertFalse(checkOk)
    }
    
    func testLexerParenRAppearance() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        let opNot = "\u{00AC}"
        
        // not (not(x or not y) and z) or x)
        let source = opNot + "( " + opNot + "(x " + opOr + opNot + " y) " + opAnd + " z)" + opOr + " x)"
        let lexer = Lexer(source: source)
        
        let checkOk = lexer.checkParenRAppearance()
        
        XCTAssertFalse(checkOk)
        
    }
    
    
    public func testLexerVariableOrdering() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        let opNot = "\u{00AC}"
        
        // not (not(y or not x) and z) or x)
        let source = opNot + "( " + opNot + "(y " + opOr + opNot + " x) " + opAnd + " z)" + opOr + " x)"
        let lexer = Lexer(source: source)
        
        let expectedOrdering: [String:Int] = ["x": 1, "y": 2, "z": 3]
        let variableOrdering = lexer.variableOrdering()
    
        XCTAssertTrue(expectedOrdering == variableOrdering)
    }
    
    public func testLexerCheckOrdering() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        let opNot = "\u{00AC}"
        
        // not ((not(x or not y) and z) or x)
        let source = opNot + "(( " + opNot + "(x " + opOr + opNot + " y) " + opAnd + " z)" + opOr + " x)"
        let lexer = Lexer(source: source)
        
        XCTAssertTrue(lexer.checkOrdering())
        
    }
    
    
    // Check that a term constructed from ast equals the lexer's source
    // Spaces are removed to allow for comparison
    func testAstCreation() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        let opNot = "\u{00AC}"
        
        // not ((not(x or not y) and z) or x)
        let source = opNot + "(( " + opNot + "(x " + opOr + opNot + " y) " + opAnd + " z)" + opOr + " x)"
        let lexer = Lexer(source: source)
        let sourceCompressed = lexer.source.filter{ $0 != " "}
    
        let ast = Ast(lexer: lexer)
        let astCompressed = ast.toString()
       
        XCTAssertEqual(sourceCompressed, astCompressed)
        
    }
    
    func testAstCheck() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        let opNot = "\u{00AC}"
    
        // not ((not(x or not y) and z) or x) or x and ((x) or y) and (x or ( y and x )))
        let source = opNot + "(( " + opNot + "(x " + opOr + opNot + " y) " + opAnd + " z)" + opOr + " x)" + opOr + " x " + opAnd + " ((x) " + opOr + " y)" + "(x " + opOr + "(y " + opAnd + " x))"
        let lexer = Lexer(source: source)
        let sourceCompressed = lexer.source.filter{ $0 != " "}
    
        let ast = Ast(lexer: lexer)
        let astCompressed = ast.toString()
        print(sourceCompressed)
        print(astCompressed)
       
        XCTAssertEqual(sourceCompressed, astCompressed)
        
    }
    
    
    func testAstCheckParenSimple() {
        
        let opOr = "\u{2228}"
    
        // ((((X) OR Y) OR Z))
        let source = "((((x) "  + opOr + " y)" + opOr + " z))"
        let lexer = Lexer(source: source)
        let sourceCompressed = lexer.source.filter{ $0 != " "}
    
        let ast = Ast(lexer: lexer)
        let astCompressed = ast.toString()
        print(sourceCompressed)
        print(astCompressed)
        
        //ast.printStructure()
        
        XCTAssertEqual(sourceCompressed, astCompressed)
        
    }
    
    
    public func testAstCollectVariables() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        let opNot = "\u{00AC}"
    
        // not ((not(x1 or not y1) and z1) or x2) or x1 and ((x3) or y2) and (x1 or ( y1 and x3 )))
        let source = opNot + "(( " + opNot + "(x1 " + opOr + opNot + " y1) " + opAnd + " z1)" + opOr + " x2)" + opOr + " x1 " + opAnd + " ((x3) " + opOr + " y2)" + "(x1 " + opOr + "(y1 " + opAnd + " x3))"
        
        let lexer = Lexer(source: source)
        let ast = Ast(lexer: lexer)
        
        let orderedVariables = ast.collectVariables()
        let expectedOrderedVariables = ["x1":1, "x2":2, "x3":3,"y1":4, "y2":5, "z1":6]
        
        XCTAssert(orderedVariables == expectedOrderedVariables)
        
    }

}
