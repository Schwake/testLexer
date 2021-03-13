//
//  LexerPerformanceTests.swift
//  testLexerTests
//
//  Created by Greg Main on 12/03/2021.
//

import XCTest
import testLexer

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

}
