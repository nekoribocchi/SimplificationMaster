import SwiftUI

// UnifiedFractionView: 分数表示用の統一クラス
struct UnifiedFractionView: View {
    var numerator: Int
    var denominator: Int
    
    var body: some View {
        VStack {
            Text("\(numerator)")
                .font(.title2)
                .padding(.bottom, -10)
            
            Divider()
                .frame(height: 2)
            
            Text("\(denominator)")
                .font(.title2)
                .padding(.top, -10)
        }
    }
}

struct UnifiedFractionView_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedFractionView(numerator: 3, denominator: 4)
    }
}
