import SwiftUI

// メインのコンテンツビュー
struct ContentView: View {
    @StateObject private var simplifier = Simplifier()
    
    var body: some View {
        ZStack {
            Color(UIColor.init(.white))
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 20) {
                    InputSection(simplifier: simplifier)
                    
                    ButtonSection(simplifier: simplifier)
                    
                    if let num = simplifier.simplifiedNumerator, let den = simplifier.simplifiedDenominator {
                        ResultSection(simplifier: simplifier, num: num, den: den)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)
            }
            .onTapGesture {
                // キーボードを閉じる
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
