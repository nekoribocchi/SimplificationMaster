import SwiftUI

// FractionCalculationView: FractionCalculationViewでUnifiedFractionViewを使用
struct FractionCalculationView: View {
    var originalNumerator: Int
    var originalDenominator: Int
    var gcdValue: Int
    var simplifiedNumerator: Int
    var simplifiedDenominator: Int
    
    var body: some View {
        VStack(spacing: 10) {
            // オリジナルの分数を表示するHStack
            HStack {
                Spacer()
                UnifiedFractionView(numerator: originalNumerator, denominator: originalDenominator)
                Spacer()
            }
            
            // 分数の約分の過程を表示するHStack
            HStack {
                Spacer()
                Text("=")
                    .font(.title2)
                Spacer()
                VStack {
                    // 分子の素因数分解の表示
                    FactorizationView(number: originalNumerator)
                        .padding(.bottom, -10)
                    Divider()
                        .frame(height: 2)  // Dividerの高さをFractionViewに合わせる
                    
                    // 分母の素因数分解の表示
                    FactorizationView(number: originalDenominator)
                        .padding(.top, -10)
                }
                Spacer()
            }
            
            // 約分後の分数を表示するHStack
            HStack {
                Spacer()
                Text("=")
                    .font(.title2)
                Spacer()
                UnifiedFractionView(numerator: simplifiedNumerator, denominator: simplifiedDenominator)
                Spacer()
            }
        }
        .padding()
    }
}

struct FractionCalculationView_Previews: PreviewProvider {
    static var previews: some View {
        FractionCalculationView(
            originalNumerator: 20,
            originalDenominator: 50,
            gcdValue: 10,
            simplifiedNumerator: 2,
            simplifiedDenominator: 5
        )
    }
}

