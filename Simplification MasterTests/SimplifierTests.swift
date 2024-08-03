import XCTest
@testable import Simplification_Master

class SimplifierTests: XCTestCase {

    var simplifier: Simplifier!

    override func setUpWithError() throws {
        simplifier = Simplifier()
    }

    override func tearDownWithError() throws {
        simplifier = nil
    }

    // 正常ケース
        //入力: 分子 = 20, 分母 = 50
        //期待される結果: 簡約後の分数 = 2/5
    func testSimplify() throws {
        // 分子と分母を設定
        simplifier.numerator = "20"
        simplifier.denominator = "50"
        
        // 簡約メソッドを呼び出し
        simplifier.simplify()

        // 期待される結果を確認
        XCTAssertEqual(simplifier.originalNumerator, 20)    // 分子が20であることを確認
        XCTAssertEqual(simplifier.originalDenominator, 50)  // 分母が50であることを確認
        XCTAssertEqual(simplifier.gcdValue, 10)             // GCDが10であることを確認
        XCTAssertEqual(simplifier.simplifiedNumerator, 2)   // 簡約後の分子が2であることを確認
        XCTAssertEqual(simplifier.simplifiedDenominator, 5) // 簡約後の分母が5であることを確認
    }

    // 正常ケース: すでに簡約されている分数
    func testSimplifyAlreadySimplified() throws {
        simplifier.numerator = "2"
        simplifier.denominator = "5"
        simplifier.simplify()

        XCTAssertEqual(simplifier.originalNumerator, 2)
        XCTAssertEqual(simplifier.originalDenominator, 5)
        XCTAssertEqual(simplifier.gcdValue, 1)
        XCTAssertEqual(simplifier.simplifiedNumerator, 2)
        XCTAssertEqual(simplifier.simplifiedDenominator, 5)
    }

    // エッジケース: 分子が0
    func testSimplifyNumeratorZero() throws {
        simplifier.numerator = "0"
        simplifier.denominator = "50"
        simplifier.simplify()

        XCTAssertEqual(simplifier.originalNumerator, 0)
        XCTAssertEqual(simplifier.originalDenominator, 50)
        XCTAssertEqual(simplifier.gcdValue, 50)
        XCTAssertEqual(simplifier.simplifiedNumerator, 0)
        XCTAssertEqual(simplifier.simplifiedDenominator, 1)
    }

    // エッジケース: 分母が1
    func testSimplifyDenominatorOne() throws {
        simplifier.numerator = "50"
        simplifier.denominator = "1"
        simplifier.simplify()

        XCTAssertEqual(simplifier.originalNumerator, 50)
        XCTAssertEqual(simplifier.originalDenominator, 1)
        XCTAssertEqual(simplifier.gcdValue, 1)
        XCTAssertEqual(simplifier.simplifiedNumerator, 50)
        XCTAssertEqual(simplifier.simplifiedDenominator, 1)
    }

    // 異常ケース: 分母が0
    func testSimplifyDenominatorZero() throws {
        simplifier.numerator = "50"
        simplifier.denominator = "0"
        simplifier.simplify()

        XCTAssertNil(simplifier.simplifiedNumerator)
        XCTAssertNil(simplifier.simplifiedDenominator)
        XCTAssertEqual(simplifier.originalNumerator, 0)
        XCTAssertEqual(simplifier.originalDenominator, 0)
        XCTAssertEqual(simplifier.gcdValue, 0)
    }

    // 異常ケース: 数字以外の入力
    func testSimplifyInvalidInput() throws {
        simplifier.numerator = "abc"
        simplifier.denominator = "50"
        simplifier.simplify()

        XCTAssertNil(simplifier.simplifiedNumerator)
        XCTAssertNil(simplifier.simplifiedDenominator)
        XCTAssertEqual(simplifier.originalNumerator, 0)
        XCTAssertEqual(simplifier.originalDenominator, 0)
        XCTAssertEqual(simplifier.gcdValue, 0)
    }

    func testClear() throws {
        simplifier.numerator = "20"
        simplifier.denominator = "50"
        simplifier.simplifiedNumerator = 2
        simplifier.simplifiedDenominator = 5
        simplifier.clear()

        XCTAssertEqual(simplifier.numerator, "")
        XCTAssertEqual(simplifier.denominator, "")
        XCTAssertNil(simplifier.simplifiedNumerator)
        XCTAssertNil(simplifier.simplifiedDenominator)
        XCTAssertEqual(simplifier.originalNumerator, 0)
        XCTAssertEqual(simplifier.originalDenominator, 0)
        XCTAssertEqual(simplifier.gcdValue, 0)
    }
}
