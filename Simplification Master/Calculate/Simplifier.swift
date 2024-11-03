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
        // 分子と分母が整数に変換可能であるか、分母が0でないことを確認
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
