XCTestを試してみたくて、分数簡約アプリを作ってみました。

![GIF](https://github.com/user-attachments/assets/19e80930-3b1d-4f4f-b809-2b55aa0adeb9)

# ユニットテストとは

**ユニットテスト (Unit Test)** とは、ソフトウェア開発において、個々の最小単位（ユニット）であるプログラムの部品（メソッド、関数、クラスなど）が期待通りに動作するかを検証するためのテストです。
# XCTestとは

**XCTest** は、Apple が提供する Swift や Objective-C で書かれたコードのユニットテストを実行するためのフレームワークです。XCTestを使用することで、ユニットテストを簡単に作成することができます。

# XCTestの準備

## `Shift` + `Command` + `N` で`App` を選択
![qiita1.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3812600/da839287-ced9-a486-5fc2-93dec6cf6d52.png)

## `Include Tests` にチェック

![qiita2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3812600/7c9307d3-b9b3-095b-92cc-9a0997774198.png)


## Testファイルが作成されます
![qiita3.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3812600/fa0a12d1-a092-4f92-6883-15fa2b3b477d.png)

 XCTestに関連するファイルは以下の`Simplifier.swift`と`SimplifierTests.swift` です。

`Simplifier.swift` では分数を簡約する計算処理を行っています。

- `Simplifier.swift`
    
    ```swift
    import SwiftUI
    
    // 分数を簡約するクラス
    class Simplifier: ObservableObject {
        // 分子の入力値
        @Published var numerator: String = ""
        // 分母の入力値
        @Published var denominator: String = ""
        // 簡約後の分子
        @Published var simplifiedNumerator: Int?
        // 簡約後の分母
        @Published var simplifiedDenominator: Int?
        // オリジナルの分子
        @Published var originalNumerator: Int = 0
        // オリジナルの分母
        @Published var originalDenominator: Int = 0
        // 最大公約数の値
        @Published var gcdValue: Int = 0
        
        // 分数を簡約するメソッド
        func simplify() {
            // 分子と分母を整数に変換し、分母が0でないことを確認
            guard let num = Int(numerator), let den = Int(denominator), den != 0 else {
                return
            }
            
            // オリジナルの分子と分母を設定
            originalNumerator = num
            originalDenominator = den
            
            // 最大公約数を計算
            gcdValue = gcd(num, den)
            
            // 分子と分母を最大公約数で割って簡約
            simplifiedNumerator = num / gcdValue
            simplifiedDenominator = den / gcdValue
        }
        
        // 入力値と計算結果をクリアするメソッド
        func clear() {
            numerator = ""
            denominator = ""
            simplifiedNumerator = nil
            simplifiedDenominator = nil
            originalNumerator = 0
            originalDenominator = 0
            gcdValue = 0
        }
        
        // ユークリッドの互除法を用いて最大公約数を計算するプライベートメソッド
        private func gcd(_ a: Int, _ b: Int) -> Int {
            return b == 0 ? a : gcd(b, a % b)
        }
    }
    
    ```
    

`SimplifierTests.swift` では、ユニットテストを行うためのコードが記述されています。

- `SimplifierTests.swift`
    
    ```swift
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
    
    ```
    

## `SimplifierTests`クラスの流れ

### 1. テストクラスのセットアップ

**`setUpWithError` メソッド**: 各テストメソッドの前に呼び出され、テスト対象の `Simplifier` インスタンスを初期化します。

```swift
override func setUpWithError() throws {
    simplifier = Simplifier()
}
```

### 2. テストクラスのクリーンアップ

**`tearDownWithError` メソッド**: 各テストメソッドの後に呼び出され、 `Simplifier` インスタンスを解放します。

```swift
override func tearDownWithError() throws {
    simplifier = nil
}
```

### 3. テストケースの記述

- 分子が 20、分母が 50 の分数を設定

```swift
simplifier.numerator = "20"
simplifier.denominator = "50"

```

- `simplify` メソッドの呼び出し
このメソッドを呼び出さないと、分数の簡約処理が行われず、テストすることができません

```swift
simplifier.simplify()
```

- 結果をアサートして確認

```swift
XCTAssertEqual(simplifier.originalNumerator, 20)    // 分子が20であることを確認
XCTAssertEqual(simplifier.originalDenominator, 50)  // 分母が50であることを確認
XCTAssertEqual(simplifier.gcdValue, 10)             // GCDが10であることを確認
XCTAssertEqual(simplifier.simplifiedNumerator, 2)   // 簡約後の分子が2であることを確認
XCTAssertEqual(simplifier.simplifiedDenominator, 5) // 簡約後の分母が5であることを確認
```


# テスト実行方法

矢印で示したマーク部分をタップすると、テストが実行されます。左側のテストタブでは一覧でテスト結果を見ることができます。

![テスト実行.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3812600/63f46a7b-e608-94af-6566-b4700b34efef.png)
