import SwiftUI

struct ButtonSection: View {
    @ObservedObject var simplifier: Simplifier
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                simplifier.simplify()
            }) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                    Text("計算")
                }
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.cyan)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            Button(action: {
                simplifier.clear()
            }) {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                    Text("クリア")
                }
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding(.horizontal, 20)
    }
}

struct ButtonSection_Previews: PreviewProvider {
    static var previews: some View {
        ButtonSection(simplifier: Simplifier())
    }
}
