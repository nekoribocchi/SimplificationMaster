import XCTest
@testable import Simplification_Master
/*
 このクラスでは、以下の三点のテストケースを実施しています。
 
 1. 正常ケース: 仕様通りに動作することが期待される、通常の条件下でのテストケース。
 2. エッジケース: 仕様の境界に近い極端な条件でのテストケース。
 3. 異常ケース: 無効または不正な入力が提供されたときに、システムがどのように応答するかをテストするケース。
*/

class SimplifierTests: XCTestCase {

    var simplifier: Simplifier!

    // 各テストケースの前に呼び出され、`Simplifier`インスタンスを初期化します
    override func setUpWithError() throws {
        simplifier = Simplifier()
    }

    // 各テストケースの後に呼び出され、`Simplifier`インスタンスを解放します
    override func tearDownWithError() throws {
        simplifier = nil
    }

    // 正常ケース: 20/50 を簡約して 2/5 にするテスト
    func testSimplify() throws {
        // 分子と分母を設定
        simplifier.numerator = "20"
        simplifier.denominator = "50"
        
        // 簡約メソッドを呼び出し
        simplifier.simplify()

        // 期待される結果を確認
        XCTAssertEqual(simplifier.originalNumerator, 20)    // 分子が20であることを確認
        XCTAssertEqual(simplifier.originalDenominator, 50)  // 分母が50であることを確認
        XCTAssertEqual(simplifier.gcdValue, 10)             // 最大公約数が10であることを確認
        XCTAssertEqual(simplifier.simplifiedNumerator, 2)   // 簡約後の分子が2であることを確認
        XCTAssertEqual(simplifier.simplifiedDenominator, 5) // 簡約後の分母が5であることを確認
    }

    // 正常ケース: すでに簡約されている分数 (2/5) をそのまま保持するテスト
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

    // エッジケース: 分子が0の場合、結果が0/1になることを確認
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

    // エッジケース: 分母が1の場合、そのままの分数が返されることを確認
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

    // 異常ケース: 分母が0の場合、分子/分母が無効であることを確認
    func testSimplifyDenominatorZero() throws {
        simplifier.numerator = "50"
        simplifier.denominator = "0"
        simplifier.simplify()

        XCTAssertNil(simplifier.simplifiedNumerator)       // 無効な分数のため簡約後の分子はnilであることを確認
        XCTAssertNil(simplifier.simplifiedDenominator)     // 簡約後の分母もnilであることを確認
        XCTAssertEqual(simplifier.originalNumerator, 0)    // 分子が0であることを確認
        XCTAssertEqual(simplifier.originalDenominator, 0)  // 分母が0であることを確認
        XCTAssertEqual(simplifier.gcdValue, 0)             // GCDが0であることを確認
    }

    // 異常ケース: 無効な入力（文字列）が与えられた場合、適切に処理されることを確認
    func testSimplifyInvalidInput() throws {
        simplifier.numerator = "abc"
        simplifier.denominator = "50"
        simplifier.simplify()

        XCTAssertNil(simplifier.simplifiedNumerator)       // 無効な入力のため簡約後の分子はnilであることを確認
        XCTAssertNil(simplifier.simplifiedDenominator)     // 簡約後の分母もnilであることを確認
        XCTAssertEqual(simplifier.originalNumerator, 0)    // 分子が0であることを確認
        XCTAssertEqual(simplifier.originalDenominator, 0)  // 分母が0であることを確認
        XCTAssertEqual(simplifier.gcdValue, 0)             // GCDが0であることを確認
    }

    // クリア≈: 以前の値がリセットされていることを確認
    func testClear() throws {
        simplifier.numerator = "20"
        simplifier.denominator = "50"
        simplifier.simplifiedNumerator = 2
        simplifier.simplifiedDenominator = 5
        simplifier.clear()

        XCTAssertEqual(simplifier.numerator, "")           // 分子が空文字列であることを確認
        XCTAssertEqual(simplifier.denominator, "")         // 分母が空文字列であることを確認
        XCTAssertNil(simplifier.simplifiedNumerator)       // 簡約後の分子がnilであることを確認
        XCTAssertNil(simplifier.simplifiedDenominator)     // 簡約後の分母がnilであることを確認
        XCTAssertEqual(simplifier.originalNumerator, 0)    // 元の分子が0であることを確認
        XCTAssertEqual(simplifier.originalDenominator, 0)  // 元の分母が0であることを確認
        XCTAssertEqual(simplifier.gcdValue, 0)             // GCDが0であることを確認
    }
}
