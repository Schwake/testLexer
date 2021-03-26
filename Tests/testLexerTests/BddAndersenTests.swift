//
//  AndersenTests.swift
//  testLexerTests
//
//  Created by Greg Main on 25/03/2021.
//

import XCTest
@testable import testLexer


class BddAndersenTests: XCTestCase {

    
    func testInit() {
        
        let opOr = "\u{2228}"
        
        // x1 or x2
        let source = "x1 " + opOr + " x2"
        let lexer = Lexer(source: source)
        
        let varOrdering = lexer.variableOrdering()
    
        let aBddAndersen = BddAndersen(variableOrdering: varOrdering)
        
        XCTAssert(aBddAndersen.nodeDict.count == 2)
        XCTAssert(aBddAndersen.nodeDictTerminal0() == [])
        XCTAssert(aBddAndersen.nodeDictTerminal1() == [])
        XCTAssert(aBddAndersen.varDict.isEmpty)
    }
    
    
    func testVarDict() {
        
        let opOr = "\u{2228}"
        
        // x1 or x2
        let source = "x1 " + opOr + " x2"
        let lexer = Lexer(source: source)
        
        let varOrdering = lexer.variableOrdering()
    
        let aBddAndersen = BddAndersen(variableOrdering: varOrdering)
        aBddAndersen.varDictAddNode(nodeIndex: 2, varIndex: 1, lowIndex: 0, highIndex: 1)
        
        let aNode = aBddAndersen.varDictExistsNodeFor(varIndex: 1, lowIndex: 0, highIndex: 1)
        XCTAssert(aBddAndersen.varDict.count == 1)
        XCTAssert(aNode.exists == true)
        XCTAssert(aNode.node! == 2)
    }
    
    
    func testNodeDict() {
        
        let opOr = "\u{2228}"
        
        // x1 or x2
        let source = "x1 " + opOr + " x2"
        let lexer = Lexer(source: source)
        
        let varOrdering = lexer.variableOrdering()
    
        let aBddAndersen = BddAndersen(variableOrdering: varOrdering)
        aBddAndersen.nodeDictAddNode(varIndex: 1, lowIndex: 0, highIndex: 1)
    
        XCTAssert(aBddAndersen.nodeDict.count == 3)
        XCTAssert(aBddAndersen.nodeDict[2] == [1, 0, 1])
    }
    
    
    func testMake() {
        
        let opOr = "\u{2228}"
        
        // x1 or x2
        let source = "x1 " + opOr + " x2"
        let lexer = Lexer(source: source)
        
        let varOrdering = lexer.variableOrdering()
    
        let aBddAndersen = BddAndersen(variableOrdering: varOrdering)
        let highLow = aBddAndersen.make(varIndex: 1, lowIndex: 0, highIndex: 0)
        let firstEntry = aBddAndersen.make(varIndex: 1, lowIndex: 0, highIndex: 1)
        let secondEntry = aBddAndersen.make(varIndex: 1, lowIndex: 0, highIndex: 1)

        XCTAssert(highLow == 0)
        XCTAssert(firstEntry == 2)
        XCTAssert(secondEntry == 2)
    }
    
    
    func testBuildOr() {
        
        let opOr = "\u{2228}"
        
        // x1 or x2
        let source = "x1 " + opOr + " x2"
        let lexer = Lexer(source: source)
        let varOrdering = lexer.variableOrdering()
        let ast = Ast(lexer: lexer)
        let rootNode = ast.rootNode!
        
        let aBddAndersen = BddAndersen(variableOrdering: varOrdering)
        
        aBddAndersen.build(node: rootNode)
        
        XCTAssert(aBddAndersen.nodeDict[3] == [1, 2, 1])
        XCTAssert(aBddAndersen.nodeDict[1] == [])
        XCTAssert(aBddAndersen.nodeDict[0] == [])
        XCTAssert(aBddAndersen.nodeDict[2] == [2, 0, 1])
        XCTAssert(aBddAndersen.nodeDict.count == 4)
        
        XCTAssert(aBddAndersen.varDict["2 0 1"] == 2)
        XCTAssert(aBddAndersen.varDict["1 2 1"] == 3)
        XCTAssert(aBddAndersen.varDict.count == 2)
    }
    
    
    func testBuildAnd() {
        
        let opAnd = "\u{2227}"
        
        // x1 or x2
        let source = "x1 " + opAnd + " x2"
        let lexer = Lexer(source: source)
        let varOrdering = lexer.variableOrdering()
        let ast = Ast(lexer: lexer)
        let rootNode = ast.rootNode!
        
        let aBddAndersen = BddAndersen(variableOrdering: varOrdering)
        
        aBddAndersen.build(node: rootNode)
        
        XCTAssert(aBddAndersen.nodeDict[3] == [1, 0, 2])
        XCTAssert(aBddAndersen.nodeDict[1] == [])
        XCTAssert(aBddAndersen.nodeDict[0] == [])
        XCTAssert(aBddAndersen.nodeDict[2] == [2, 0, 1])
        XCTAssert(aBddAndersen.nodeDict.count == 4)
        
        XCTAssert(aBddAndersen.varDict["2 0 1"] == 2)
        XCTAssert(aBddAndersen.varDict["1 0 2"] == 3)
        XCTAssert(aBddAndersen.varDict.count == 2)
    }
    
    func testBuildTest() {
        
        let opAnd = "\u{2227}"
        
        // x1 or x2
        let source = "x1 " + opAnd + " x2"
        let lexer = Lexer(source: source)
        let varOrdering = lexer.variableOrdering()
        let ast = Ast(lexer: lexer)
        let rootNode = ast.rootNode!
        
        let aBddAndersen = BddAndersen(variableOrdering: varOrdering)
        
        aBddAndersen.build(node: rootNode)
        
        XCTAssert(aBddAndersen.nodeDict[3] == [1, 0, 2])
        XCTAssert(aBddAndersen.nodeDict[1] == [])
        XCTAssert(aBddAndersen.nodeDict[0] == [])
        XCTAssert(aBddAndersen.nodeDict[2] == [2, 0, 1])
        XCTAssert(aBddAndersen.nodeDict.count == 4)
        
        XCTAssert(aBddAndersen.varDict["2 0 1"] == 2)
        XCTAssert(aBddAndersen.varDict["1 0 2"] == 3)
        XCTAssert(aBddAndersen.varDict.count == 2)
    }
    
}
