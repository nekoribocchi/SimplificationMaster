import SwiftUI

struct InputSection: View {
    @ObservedObject var simplifier: Simplifier
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                VStack(spacing: 10) {
                    TextField("分子を入力", text: $simplifier.numerator)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .font(.title2)
                    
                    Divider()
                    
                    TextField("分母を入力", text: $simplifier.denominator)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .font(.title2)
                }
                
                Text("=")
                    .font(.title2)
                
                if let num = simplifier.simplifiedNumerator, let den = simplifier.simplifiedDenominator {
                    UnifiedFractionView(numerator: num, denominator: den)
                } else {
                    UnifiedFractionView(numerator: 0, denominator: 0)
                        .hidden()
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
struct InputSection_Previews: PreviewProvider {
    static var previews: some View {
        InputSection(simplifier: Simplifier())
    }
}
