import SwiftUI

struct ResultSection: View {
    @ObservedObject var simplifier: Simplifier
    var num: Int
    var den: Int
    
    var body: some View {
        VStack(spacing: 20) {
            FractionCalculationView(
                originalNumerator: simplifier.originalNumerator,
                originalDenominator: simplifier.originalDenominator,
                gcdValue: simplifier.gcdValue,
                simplifiedNumerator: num,
                simplifiedDenominator: den
            )
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


struct ResultSection_Previews: PreviewProvider {
    static var previews: some View {
        let simplifier = Simplifier()
        simplifier.originalNumerator = 20
        simplifier.originalDenominator = 50
        simplifier.gcdValue = 10
        simplifier.simplifiedNumerator = 2
        simplifier.simplifiedDenominator = 5
        
        return ResultSection(simplifier: simplifier, num: simplifier.simplifiedNumerator ?? 0, den: simplifier.simplifiedDenominator ?? 0)
    }
}
