import SwiftUI

// FactorizationView: 素因数分解の結果を表示
struct FactorizationView: View {
    var number: Int
    
    var body: some View {
        let factors = primeFactors(of: number)
        
        return HStack {
            if factors.count <= 3 {
                Spacer()
            }
            HStack {
                ForEach(factors.indices, id: \.self) { index in
                    if index == factors.count - 1 {
                        Text("\(factors[index])")
                            .font(.title2)
                    } else {
                        Text("\(factors[index]) ×")
                            .font(.title2)
                    }
                }
            }
            if factors.count <= 3 {
                Spacer()
            }
        }
    }
    
    // 数字の素因数分解を行う関数
    func primeFactors(of number: Int) -> [Int] {
        var n = number
        var factors: [Int] = []
        var divisor = 2
        while n > 1 {
            while n % divisor == 0 {
                factors.append(divisor)
                n /= divisor
            }
            divisor += 1
        }
        return factors
    }
}

struct FactorizationView_Previews: PreviewProvider {
    static var previews: some View {
        FactorizationView(number: 20)
    }
}
