//
//  ProgressBar.swift
//  ProgressBar
//
//  Created by Михаил Щербаков on 15.11.2021.
//

import SwiftUI

struct ProgressBar: View {
    
    @State var percentage: CGFloat = 0
    @State var showAmount: Bool = false
    
    @Binding var amount: CGFloat
    @Binding var total: CGFloat
    
    let linearGradient = LinearGradient(colors: [Color("first"), Color("second")], startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        ZStack {
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(linearGradient)
                    .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
                    .padding()
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.4))
                    .frame(width: (UIScreen.main.bounds.width / 115) * percentage, height: 40, alignment: .center)
                    .padding()
                    .padding(.horizontal, 9)
                
                HStack {
                    
                    Text("0")
                    Spacer()
                    Text(String(format: "%.0f", total))
                    
                }
                .font(.title3)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding()
                .padding(.horizontal, 20)
                
            }
            .onAppear {
                withAnimation(.easeOut(duration: 2)) {
                    percentage = calculate()
                }
            }
            
            ZStack {
                Text(String(format: "%.0f", amount))
                    .font(.title3)
                    .frame(width: 100, height: 30)
                    .background(
                        Capsule()
                            .fill(Color("purple"))
                    )
                    .foregroundColor(.white)
                
                AmountPicker()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("purple"))
                    .offset(y: 10)
            }
            .position(x: CGFloat((UIScreen.main.bounds.width / 115) * percentage) + 25, y: (UIScreen.main.bounds.height / 2) - 100)
            .opacity(showAmount ? 1 : 0)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        showAmount.toggle()
                    }
                }
            }
        }
    }
    
    func calculate() -> CGFloat {
        percentage = amount / (total / 100)
        return CGFloat(percentage)
    }
}


struct AmountPicker: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        
        return path
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(amount: .constant(15000), total: .constant(24000))
//        amountPicker()
    }
}
