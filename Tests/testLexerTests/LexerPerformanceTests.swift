//
//  LexerPerformanceTests.swift
//  testLexerTests
//
//  Created by Greg Main on 12/03/2021.
//

import XCTest
@testable import testLexer

class LexerPerformanceTests: XCTestCase {

    func testSourceCreationPerformance() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
 
        measure {
            let n = 100000
            var source = ""

            for index in (1...n) {
                source = source + (" (X\(index) \(opOr) y\(index) ) \(opAnd)")
            }
        }
    }
    
    func testLexerPerformance() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        
        // (Xn OR Yn) AND
        let term = (" (X1 \(opOr) Y1 ) \(opAnd)")
        let n = 100000
        var source = ""
        
        for _ in (1...n) {
            source += term
        }
        source += " z"

        measure {
            Lexer(source: source)
        }
    }
    
    func testLexerVariableOrderingPerformance() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        
        // (Xn OR Yn) AND
        let term = (" (X1 \(opOr) Y1) \(opAnd)")
        let n = 1000000
        var source = ""
        
        for _ in (1...n) {
            source += term
        }
        source += " z"
        
        let lexer = Lexer(source: source)
        
        measure {
            lexer.variableOrdering()
        }
    }

    func testAstOrderDictPerformance() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        
        // (Xn OR Yn) AND
        let term = (" (X1 \(opOr) Y1) \(opAnd)")
        let n = 10000
        var source = ""
        
        for _ in (1...n) {
            source += term
        }
        source += " z"
        
        let lexer = Lexer(source: source)
        let ast = Ast(lexer: lexer)
        
        measure {
            ast.collectVariablesSet()
            // Inout variant - double speed
            // ast.collectVariables()
        }
    }

    
    func testAstPerformance() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        
        // (Xn OR Yn) AND
        let term = (" (X1 \(opOr) Y1) \(opAnd)")
        let n = 100000
        var source = ""
        
        for _ in (1...n) {
            source += term
        }
        source += " z"
        
        let lexer = Lexer(source: source)
        
        measure {
            Ast(lexer: lexer)
        }
    }
    
    func testBddAndersonPerformance() {
        
        let opAnd = "\u{2227}"
        let opOr = "\u{2228}"
        
        var source = ""
        // x1 or x2
        for index in (1...10) {
            source += "x\(index) " + opAnd + " y\(index) " + opOr
        }
        source = source + " z1"
        let lexer = Lexer(source: source)
        let varOrdering = lexer.variableOrdering()
        let ast = Ast(lexer: lexer)
        let rootNode = ast.rootNode!
        
        let aBddAndersen = BddAndersen(variableOrdering: varOrdering)
        
        measure {
            aBddAndersen.build(node: rootNode)
        }
       
       
    }

    
}
